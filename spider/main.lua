

local composer = require( "composer" )
local json = require( "json" )
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )
 
-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
math.randomseed( os.time() )

local options = {
    effect = "fade",
    time = 800
}
 
-- Go to the menu screen
composer.setVariable( "level", 1 )
composer.gotoScene( "dos_donts", options )