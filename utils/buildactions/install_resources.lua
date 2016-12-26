premake.modules.install_resources = {}

local SERVER_DIR = "Bin/server/resources"
local RESOURCES_DIR = "Shared/data/resources"

newaction {
	trigger = "install_resources",
	description = "Installs the resources to the bin directory",
	
	execute = function()
		-- Make Bin directory if not exists
		os.mkdir(SERVER_DIR)
		
		-- Copy data files
		if os.get() == "windows" then
			os.copydir(RESOURCES_DIR, SERVER_DIR)
		end
	end
}

return premake.modules.install_resources
