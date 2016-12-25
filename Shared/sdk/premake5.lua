project "Shared - SDK"
	language "C++"
	kind "StaticLib"
	targetname "sdk"
	
	pchheader "StdInc.h"
	pchsource "StdInc.cpp"
	
	flags { "ExcludeFromBuild" }

	vpaths { 
		["Headers/*"] = { "**.h", "**.hpp" },
		["Sources/*"] = "**.cpp",
		["*"] = "premake5.lua"
	}
	
	includedirs {
		"../../vendor/sparsehash/current/src/"
	}
	
	files {
		"premake5.lua",
		"**.h",
		"**.hpp",
		"**.cpp"
	}
