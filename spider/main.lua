

local composer = require( "composer" )
local json = require( "json" )
local startapp = require( "plugin.startapp" )
local levelProp = require("levelProp")
local composer = require( "composer" )
local facebook = require( "plugin.facebook.v4" )
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


local function facebookListener( event )
 
    if ( "fbinit" == event.name ) then
 
        print( "Facebook initialized" )
        facebook.login()
 
    elseif ( "fbconnect" == event.name ) then
 
        -- if ( "session" == event.type ) then
            -- -- Handle login event
            -- if ( "login" == event.phase ) then
                -- local shareParams = {
                    -- link = "https://www.coronalabs.com/",
                    -- title = "Corona Labs"
                -- }
                -- facebook.showDialog( "link", shareParams )
            -- end
 
        -- elseif ( "dialog" == event.type ) then
            -- -- Handle dialog event
            -- print( event.response )
        -- end
    end
end
 
-- Set the "fbinit" listener to be triggered when initialization is complete
if(facebook ~= nil) then
	if(facebook.init ~= nil) then
		facebook.init( facebookListener )
	else
		print("facebook.init nil")
	end
else
	print("facebook nil")
end



local options = {
    effect = "fade",
    time = 800
}

startapp.init( adListener, { appId="200202265", enableReturnAds = true } )
 
-- Go to the menu screen
composer.setVariable( "1st_level", 1 )
composer.setVariable( "show_1st_move", 0 )
composer.setVariable( "level", 16 )
composer.setVariable( "max_completed_level", levelTable[1] )
composer.gotoScene( "title", options )