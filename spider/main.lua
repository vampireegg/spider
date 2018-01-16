

local composer = require( "composer" )
local json = require( "json" )
local vungle = require( "plugin.vungle" )
local levelProp = require("levelProp")
local composer = require( "composer" )
local filePath = system.pathForFile( "level.json", system.DocumentsDirectory )
local levelTable = {}
local scoreTable = {}
 
-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )
 
-- Seed the random number generator
math.randomseed( os.time() )

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

local function myUnhandledErrorListener( event )
 
    local iHandledTheError = true
 
    if iHandledTheError then
        print( "Handling the unhandled error", event.errorMessage )
    else
        print( "Not handling the unhandled error", event.errorMessage )
    end
    
    return iHandledTheError
end
 
Runtime:addEventListener("unhandledError", myUnhandledErrorListener)



local options = {
    effect = "fade",
    time = 800
}

local vungle = require( "plugin.vungle" )
 
local appID, placementID1, placementID2
if ( system.getInfo("platform") == "android" ) then
    appID = "5a5dc14aef493e900c002889"
    placementID1 = "DEFAULT74324"
    placementID2 = "DEFAULT74324"
else
    appID = "YOUR_IOS_APP_ID"
    placementID1 = "YOUR_IOS_PLACEMENT_ID_1"
    placementID2 = "YOUR_IOS_PLACEMENT_ID_2"
end
 
-- Vungle listener function
local function adListener( event )
 
    if ( event.type == "adInitialize" ) then  -- Successful initialization
        print( event.provider )
    end
end
 
-- Initialize the Vungle plugin
local initParams = appID .. "," .. placementID1 .. "," .. placementID2
vungle.init( "vungle", initParams, adListener )

local adShown = vungle.show( { placementId=placementID1, isSoundEnabled=true } )
 
-- Go to the menu screen
composer.setVariable( "1st_level", 1 )
composer.setVariable( "show_1st_move", 0 )
composer.setVariable( "level", 1 )
composer.setVariable( "max_completed_level", levelTable[1] )
composer.gotoScene( "title", options )