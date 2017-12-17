

local composer = require( "composer" )
 
-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
math.randomseed( os.time() )

local options = {
    effect = "fade",
    time = 800
}
 
-- Go to the menu screen
composer.setVariable( "level", 9 )
composer.gotoScene( "dos_donts", options )