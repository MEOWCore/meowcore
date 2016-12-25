project "curl"
	language "C++"
	kind "StaticLib"
	targetname "libcurl"
	targetdir(buildpath("server"))
	
	includedirs { 
		"../include",
		"../../zlib"
	}
	disablewarnings { "4996" }
	
	vpaths { 
		["Headers"] = "**.h",
		["Sources"] = "**.c",
		["*"] = "premake5.lua"
	}
	
	files {
		"premake5.lua",
		"asyn-ares.c",
		"asyn-thread.c",
		"axtls.c",
		"base64.c",
		"bundles.c",
		"conncache.c",
		"connect.c",
		"content_encoding.c",
		"cookie.c",
		"curl_addrinfo.c",
		"curl_darwinssl.c",
		"curl_fnmatch.c",
		"curl_gethostname.c",
		"curl_gssapi.c",
		"curl_memrchr.c",
		"curl_multibyte.c",
		"curl_ntlm.c",
		"curl_ntlm_core.c",
		"curl_ntlm_msgs.c",
		"curl_ntlm_wb.c",
		"curl_rtmp.c",
		"curl_sasl.c",
		"curl_schannel.c",
		"curl_sspi.c",
		"curl_threads.c",
		"cyassl.c",
		"dict.c",
		"dotdot.c",
		"easy.c",
		"escape.c",
		"file.c",
		"fileinfo.c",
		"formdata.c",
		"ftp.c",
		"ftplistparser.c",
		"getenv.c",
		"getinfo.c",
		"gopher.c",
		"gskit.c",
		"gtls.c",
		"hash.c",
		"hmac.c",
		"hostasyn.c",
		"hostcheck.c",
		"hostip.c",
		"hostip4.c",
		"hostip6.c",
		"hostsyn.c",
		"http.c",
		"http_chunks.c",
		"http_digest.c",
		"http_negotiate.c",
		"http_negotiate_sspi.c",
		"http_proxy.c",
		"idn_win32.c",
		"if2ip.c",
		"imap.c",
		"inet_ntop.c",
		"inet_pton.c",
		"krb4.c",
		"krb5.c",
		"ldap.c",
		"llist.c",
		"md4.c",
		"md5.c",
		"memdebug.c",
		"mprintf.c",
		"multi.c",
		"netrc.c",
		"non-ascii.c",
		"nonblock.c",
		"nss.c",
		"openldap.c",
		"parsedate.c",
		"pingpong.c",
		"pipeline.c",
		"polarssl.c",
		"polarssl_threadlock.c",
		"pop3.c",
		"progress.c",
		"qssl.c",
		"rawstr.c",
		"rtsp.c",
		"security.c",
		"select.c",
		"sendf.c",
		"share.c",
		"slist.c",
		"smtp.c",
		"socks.c",
		"socks_gssapi.c",
		"socks_sspi.c",
		"speedcheck.c",
		"splay.c",
		"ssh.c",
		"sslgen.c",
		"ssluse.c",
		"strdup.c",
		"strequal.c",
		"strerror.c",
		"strtok.c",
		"strtoofft.c",
		"telnet.c",
		"tftp.c",
		"timeval.c",
		"transfer.c",
		"url.c",
		"version.c",
		"warnless.c",
		"wildcard.c",
		"x509asn1.c",
		"arpa_telnet.h",
		"asyn.h",
		"axtls.h",
		"bundles.h",
		"config-dos.h",
		"config-vxworks.h",
		"config-win32.h",
		"conncache.h",
		"connect.h",
		"content_encoding.h",
		"cookie.h",
		"curl_addrinfo.h",
		"curl_base64.h",
		"curl_darwinssl.h",
		"curl_fnmatch.h",
		"curl_gethostname.h",
		"curl_gssapi.h",
		"curl_hmac.h",
		"curl_ldap.h",
		"curl_md4.h",
		"curl_md5.h",
		"curl_memory.h",
		"curl_memrchr.h",
		"curl_multibyte.h",
		"curl_ntlm.h",
		"curl_ntlm_core.h",
		"curl_ntlm_msgs.h",
		"curl_ntlm_wb.h",
		"curl_rtmp.h",
		"curl_sasl.h",
		"curl_schannel.h",
		"curl_setup.h",
		"curl_setup_once.h",
		"curl_sspi.h",
		"curl_threads.h",
		"curlx.h",
		"cyassl.h",
		"dict.h",
		"dotdot.h",
		"easyif.h",
		"escape.h",
		"file.h",
		"fileinfo.h",
		"formdata.h",
		"ftp.h",
		"ftplistparser.h",
		"getinfo.h",
		"gopher.h",
		"gskit.h",
		"gtls.h",
		"hash.h",
		"hostcheck.h",
		"hostip.h",
		"http.h",
		"http_chunks.h",
		"http_digest.h",
		"http_negotiate.h",
		"http_proxy.h",
		"if2ip.h",
		"imap.h",
		"inet_ntop.h",
		"inet_pton.h",
		"krb4.h",
		"llist.h",
		"memdebug.h",
		"multihandle.h",
		"multiif.h",
		"netrc.h",
		"non-ascii.h",
		"nonblock.h",
		"nssg.h",
		"parsedate.h",
		"pingpong.h",
		"pipeline.h",
		"polarssl.h",
		"polarssl_threadlock.h",
		"pop3.h",
		"progress.h",
		"qssl.h",
		"rawstr.h",
		"rtsp.h",
		"select.h",
		"sendf.h",
		"setup-vms.h",
		"share.h",
		"slist.h",
		"smtp.h",
		"sockaddr.h",
		"socks.h",
		"speedcheck.h",
		"splay.h",
		"ssh.h",
		"sslgen.h",
		"ssluse.h",
		"strdup.h",
		"strequal.h",
		"strerror.h",
		"strtok.h",
		"strtoofft.h",
		"telnet.h",
		"tftp.h",
		"timeval.h",
		"transfer.h",
		"url.h",
		"urldata.h",
		"warnless.h",
		"wildcard.h",
		"x509asn1.h"
	}
	
	defines {
		"BUILDING_LIBCURL",
		"HAVE_LIBZ",
		"HAVE_ZLIB_H",
		"CURL_DISABLE_LDAP"
	}
	
	links { "zlib" }

	filter "system:windows"
		defines { 
			"USE_WINDOWS_SSPI",
			"USE_SCHANNEL",
			"USE_WIN32_IDN",
			"WANT_IDN_PROTOTYPES"
		}
		links { "ws2_32", "Normaliz" }
		
	filter {"system:windows", "platforms:x86"}
		postbuildcommands {
			copy "mta"
		}

	filter {"system:windows", "platforms:x86", "configurations:Debug"}
		postbuildcommands {
			-- Fix net(c).dll requiring the release build
			"copy %{wks.location}..\\Bin\\server\\libcurl_d.dll %{wks.location}..\\Bin\\mta\\libcurl.dll",
			"copy %{wks.location}..\\Bin\\server\\libcurl_d.dll %{wks.location}..\\Bin\\server\\libcurl.dll"
		}

	filter "platforms:x64"
		targetdir(buildpath("server/x64"))
	