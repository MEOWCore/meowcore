project "Server - Core"
	language "C++"
	kind "SharedLib"
	targetname "server"
	targetdir(buildpath("."))
	
	filter "system:windows"
		includedirs { "../../vendor/sparsehash/current/src/windows" }
		linkoptions { "/SAFESEH\:NO" }
	
	filter {}
		includedirs { 
			"../sdk", 
			"../../vendor/google-breakpad/src",
			"../../vendor/sparsehash/current/src/",
			"../../vendor/pthreads/include",
			"../../Bin/server/"
		}
	
	pchheader "StdInc.h"
	pchsource "StdInc.cpp"
	
	vpaths { 
		["Headers/*"] = "**.h",
		["Sources"] = "*.c",
		["*"] = "premake5.lua"
	}
	
	files {
		"premake5.lua",
		"*.h",
		"*.cpp"
	}

      
	filter "system:windows"
		libdirs {
			"../../vendor/detours/lib"
		}
		includedirs { 
			"../../vendor/detours/include"
		}
		links { "Normaliz", "detours", "Imagehlp", "Server - Game Logic", "pthread", "Lua_Server", "sqlite", "ehs", "cryptopp", "pme", "pcre", "json-c", "zip", "zlib", "ws2_32", "Server - Network", "XML", "curl" }
	
	filter "system:not windows"
		excludes { "CExceptionInformation_Impl.cpp" }

	filter "system:linux"
		links { "ncursesw", "breakpad", "pthread", "stdc++", "rt" }

	filter "platforms:x64"
		targetdir(buildpath("server/x64"))
