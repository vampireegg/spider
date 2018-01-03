

local composer = require( "composer" )
local json = require( "json" )
local startapp = require( "plugin.startapp" )
local filePath = system.pathForFile( "level.json", system.DocumentsDirectory )
local levelTable = {}
 
-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
math.randomseed( os.time() )

local file = io.open( filePath, "r" )

local function adListener( event )
	if ( event.phase == "init" ) then  -- Successful initialization
        print( event.provider )
		startapp.load( "interstitial" )
	elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
        print( event.type )
		
    elseif ( event.phase == "failed" ) then  -- The ad failed to load
        print( event.type )
        print( event.isError )
        print( event.response )
	elseif ( event.phase == "displayed" ) then  -- The ad was displayed/played
        print( event.type )
    elseif ( event.phase == "hidden" ) then  -- The ad was closed/hidden
        print( event.type )
    elseif ( event.phase == "clicked" ) then  -- The ad was clicked/tapped
        print( event.type )
    elseif ( event.phase == "reward" ) then  -- Rewarded video ad playback completed
        print( event.type )
    end
end

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

startapp.init( adListener, { appId="200202265", enableReturnAds = true } )
 
-- Go to the menu screen
composer.setVariable( "1st_level", 1 )
composer.setVariable( "show_1st_move", 0 )
composer.setVariable( "level", 12 )
composer.setVariable( "max_completed_level", levelTable[1] )
composer.gotoScene( "title", options )