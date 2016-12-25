require 'utils'

premake.modules.install_data = {}

-- Config variables
local BIN_DIR = "Bin"
local DATA_DIR = "Shared/data/MTA San Andreas"

newaction {
	trigger = "install_data",
	description = "Installs data files",
	
	execute = function()
		-- Make Bin directory if not exists
		os.mkdir(BIN_DIR)
		
		-- Copy data files
		if os.get() == "windows" then
			os.copydir(DATA_DIR, BIN_DIR)
		end

		-- Copy configs
		os.copydir("Server/mods/deathmatch", BIN_DIR.."/server/mods/deathmatch", "*.conf", false, true)
		os.copydir("Server/mods/deathmatch", BIN_DIR.."/server/mods/deathmatch", "*.xml", false, true)
		
		-- Make sure server/x64 directory exists
		os.mkdir(BIN_DIR.."/server/x64")
	end
}

return premake.modules.install_data
