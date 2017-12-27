

local composer = require( "composer" )
local json = require( "json" )
local filePath = system.pathForFile( "level.json", system.DocumentsDirectory )
local levelTable = {}
 
-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
math.randomseed( os.time() )

local file = io.open( filePath, "r" )

if file then
	local contents = file:read( "*a" )
	io.close( file )
	levelTable = json.decode( contents )
	print("level from file:")
	for i = 1, #levelTable do
		print(levelTable[i] .. " " )
	end
else
	print("file not found")
end

if ( levelTable == nil or #levelTable == 0 ) then
        levelTable = { 1 }
end

local options = {
    effect = "fade",
    time = 800
}
 
-- Go to the menu screen
composer.setVariable( "1st_level", 1 )
composer.setVariable( "level", 11 )
composer.setVariable( "max_completed_level", levelTable[1] )
composer.gotoScene( "level", options )