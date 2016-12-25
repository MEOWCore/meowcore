project "Server - Launcher"
	language "C++"
	kind "ConsoleApp"
	targetdir(buildpath("."))
	
	includedirs { "../sdk" }
	
	vpaths { 
		["Headers/*"] = "**.h",
		["Sources/*"] = "**.cpp",
		["Resources/*"] = {"*.rc", "**.ico"},
		["*"] = "premake5.lua"
	}
	
	files {
		"premake5.lua",
		"*.h",
		"*.cpp"
	}
	
	filter "system:windows"
		targetname "meow-server"
		flags { "StaticRuntime" } 
		files {
			"launcher.rc",
			"resource/mtaicon.ico"
		}

	filter "system:linux"
		links { "dl" }

	filter {"system:linux", "platforms:x86"}
		targetname "meow-server"

	filter {"system:linux", "platforms:x64"}
		targetname "meow-server64"
	
	filter {"system:windows", "platforms:x64"}
		targetname "meow-server64"
