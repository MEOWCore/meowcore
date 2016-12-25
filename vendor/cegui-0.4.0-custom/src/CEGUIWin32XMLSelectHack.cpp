/************************************************************************
	filename: 	CEGUIWin32XMLSelectHack.cpp
	created:	14/3/2005
	author:		Paul D Turner
*************************************************************************/
/*************************************************************************
    Crazy Eddie's GUI System (http://www.cegui.org.uk)
    Copyright (C)2004 - 2005 Paul D Turner (paul@cegui.org.uk)

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*************************************************************************/
#include "StdInc.h"
/*************************************************************************
    This hack of a file will become source for whichever XML Parser has
    been selected as the default.  It's easier to do this than to mess
    about trying to do the same by messing around with the project files
    for all the different VC++ compiler versions.
*************************************************************************/
#include "CEGUIConfig.h"



#ifdef CEGUI_WITH_XERCES
#   if defined (_MSC_VER)
#       if defined (DEBUG) || defined (_DEBUG)
#           pragma comment(lib,"xerces-c_2D.lib")
#       else
#           pragma comment(lib,"xerces-c_2.lib")
#       endif
#   endif
#   include "CEGUIXercesParser.hpp"
#else
#   include "CEGUITinyXMLParser.hpp"
#endif

void TiXmlElement::StreamOut(TIXML_OSTREAM * stream) const
{
	(*stream) << "<" << value;

	const TiXmlAttribute* attrib;
	for (attrib = attributeSet.First(); attrib; attrib = attrib->Next())
	{
		(*stream) << " ";
		attrib->StreamOut(stream);
	}

	// If this node has children, give it a closing tag. Else
	// make it an empty tag.
	TiXmlNode* node;
	if (firstChild)
	{
		(*stream) << ">";

		for (node = firstChild; node; node = node->NextSibling())
		{
			node->StreamOut(stream);
		}
		(*stream) << "</" << value << ">";
	}
	else
	{
		(*stream) << " />";
	}
}

TiXmlElement* TiXmlNode::FirstChildElement()
{
	TiXmlNode* node;

	for (node = FirstChild();
		node;
		node = node->NextSibling())
	{
		if (node->ToElement())
			return node->ToElement();
	}
	return 0;
}

void TiXmlString::append(const char * suffix)
{
	char * new_string;
	unsigned new_alloc, new_size;

	new_size = length() + strlen(suffix) + 1;
	// check if we need to expand
	if (new_size > allocated)
	{
		// compute new size
		new_alloc = assign_new_size(new_size);

		// allocate new buffer
		new_string = new char[new_alloc];
		new_string[0] = 0;

		// copy the previous allocated buffer into this one
		if (allocated && cstring)
			memcpy(new_string, cstring, 1 + length());
		// strcpy (new_string, cstring);

		// append the suffix. It does exist, otherwize we wouldn't be expanding 
		// strcat (new_string, suffix);
		memcpy(new_string + length(),
			suffix,
			strlen(suffix) + 1);

		// return previsously allocated buffer if any
		if (allocated && cstring)
			delete[] cstring;

		// update member variables
		cstring = new_string;
		allocated = new_alloc;
	}
	else
	{
		// we know we can safely append the new string
		// strcat (cstring, suffix);
		memcpy(cstring + length(),
			suffix,
			strlen(suffix) + 1);
	}
	current_length = new_size - 1;
}

void TiXmlText::StreamOut(TIXML_OSTREAM * stream) const
{
	PutString(value, stream);
}

void TiXmlBase::PutString(const TIXML_STRING& str, TIXML_OSTREAM* stream)
{
	TIXML_STRING buffer;
	PutString(str, &buffer);
	(*stream) << buffer;
}

void TiXmlBase::PutString(const TIXML_STRING& str, TIXML_STRING* outString)
{
	int i = 0;

	while (i<(int)str.length())
	{
		unsigned char c = (unsigned char)str[i];

		if (c == '&'
			&& i < ((int)str.length() - 2)
			&& str[i + 1] == '#'
			&& str[i + 2] == 'x')
		{
			// Hexadecimal character reference.
			// Pass through unchanged.
			// &#xA9;	-- copyright symbol, for example.
			//
			// The -1 is a bug fix from Rob Laveaux. It keeps
			// an overflow from happening if there is no ';'.
			// There are actually 2 ways to exit this loop -
			// while fails (error case) and break (semicolon found).
			// However, there is no mechanism (currently) for
			// this function to return an error.
			while (i<(int)str.length() - 1)
			{
				outString->append(str.c_str() + i, 1);
				++i;
				if (str[i] == ';')
					break;
			}
		}
		else if (c == '&')
		{
			outString->append(entity[0].str, entity[0].strLength);
			++i;
		}
		else if (c == '<')
		{
			outString->append(entity[1].str, entity[1].strLength);
			++i;
		}
		else if (c == '>')
		{
			outString->append(entity[2].str, entity[2].strLength);
			++i;
		}
		else if (c == '\"')
		{
			outString->append(entity[3].str, entity[3].strLength);
			++i;
		}
		else if (c == '\'')
		{
			outString->append(entity[4].str, entity[4].strLength);
			++i;
		}
		else if (c < 32)
		{
			// Easy pass at non-alpha/numeric/symbol
			// Below 32 is symbolic.
			char buf[32];
			sprintf(buf, "&#x%02X;", (unsigned)(c & 0xff));
			//*ME:	warning C4267: convert 'size_t' to 'int'
			//*ME:	Int-Cast to make compiler happy ...
			outString->append(buf, (int)strlen(buf));
			++i;
		}
		else
		{
			//char realc = (char) c;
			//outString->append( &realc, 1 );
			*outString += (char)c;	// somewhat more efficient function call.
			++i;
		}
	}
}


// append a const char * to an existing TiXmlString
void TiXmlString::append(const char* str, int len)
{
	char * new_string;
	unsigned new_alloc, new_size, size_suffix;

	// don't use strlen - it can overrun the len passed in!
	const char* p = str;
	size_suffix = 0;

	while (*p && size_suffix < (unsigned)len)
	{
		++p;
		++size_suffix;
	}
	if (!size_suffix)
		return;

	new_size = length() + size_suffix + 1;
	// check if we need to expand
	if (new_size > allocated)
	{
		// compute new size
		new_alloc = assign_new_size(new_size);

		// allocate new buffer
		new_string = new char[new_alloc];
		new_string[0] = 0;

		// copy the previous allocated buffer into this one
		if (allocated && cstring)
			// strcpy (new_string, cstring);
			memcpy(new_string, cstring, length());

		// append the suffix. It does exist, otherwize we wouldn't be expanding 
		// strncat (new_string, str, len);
		memcpy(new_string + length(),
			str,
			size_suffix);

		// return previsously allocated buffer if any
		if (allocated && cstring)
			delete[] cstring;

		// update member variables
		cstring = new_string;
		allocated = new_alloc;
	}
	else
	{
		// we know we can safely append the new string
		// strncat (cstring, str, len);
		memcpy(cstring + length(),
			str,
			size_suffix);
	}
	current_length = new_size - 1;
	cstring[current_length] = 0;
}

void TiXmlDocument::StreamOut(TIXML_OSTREAM * out) const
{
	const TiXmlNode* node;
	for (node = FirstChild(); node; node = node->NextSibling())
	{
		node->StreamOut(out);

		// Special rule for streams: stop after the root element.
		// The stream in code will only read one element, so don't
		// write more than one.
		if (node->ToElement())
			break;
	}
}