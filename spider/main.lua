

local composer = require( "composer" )
local json = require( "json" )
local filePath = system.pathForFile( "level.json", system.DocumentsDirectory )
local levelTable = {}
 
-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
math.randomseed( os.time() )

if file then
	local contents = file:read( "*a" )
	io.close( file )
	levelTable = json.decode( contents )
	print("level from file:")
	for i = 0, #levelTable do
		print(levelTable[i] .. " " )
	end
end

local options = {
    effect = "fade",
    time = 800
}
 
-- Go to the menu screen
composer.setVariable( "level", 1 )
composer.gotoScene( "dos_donts", options )