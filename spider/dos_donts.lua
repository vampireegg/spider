
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local scene = composer.newScene()


local Level
local bgProp = {}
local totalHeight
local totalWidth
local myTimers = {}
local startapp = require( "plugin.startapp" )

local function gotoGame()
	for k, v in pairs(myTimers) do
        timer.cancel(v)
    end
	local options = {
		effect = "fade",
		time = 800
	}
    composer.gotoScene( "level" , options)
end

local function showAdd( event )
	if ( startapp.isLoaded( "interstitial" ) ) then
		startapp.show( "interstitial" )
	end
end

local function adListener( event )
	if ( event.phase == "init" ) then  -- Successful initialization
        print( event.provider )
		startapp.load( "interstitial" )
	elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
        print( event.type )
		myTimers[#myTimers+1] = timer.performWithDelay( 300, showAdd )
    elseif ( event.phase == "failed" ) then  -- The ad failed to load
        print( event.type )
        print( event.isError )
        print( event.response )
		myTimers[#myTimers+1] = timer.performWithDelay( 30, gotoGame )
	elseif ( event.phase == "displayed" ) then  -- The ad was displayed/played
        print( event.type )
		myTimers[#myTimers+1] = timer.performWithDelay( 30, gotoGame )
    elseif ( event.phase == "hidden" ) then  -- The ad was closed/hidden
        print( event.type )
		myTimers[#myTimers+1] = timer.performWithDelay( 30, gotoGame )
    elseif ( event.phase == "clicked" ) then  -- The ad was clicked/tapped
        print( event.type )
		myTimers[#myTimers+1] = timer.performWithDelay( 30, gotoGame )
    elseif ( event.phase == "reward" ) then  -- Rewarded video ad playback completed
        print( event.type )
		myTimers[#myTimers+1] = timer.performWithDelay( 30, gotoGame )
    end
end

function scene:create( event )
 
	Level = composer.getVariable("level")
	print("dos_donts Level = " .. Level)
	
	startapp.init( adListener, { appId="200202265", enableReturnAds = true } )
	
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	
	bgProp.Img = levelProp[Level].dos_donts.Img
	bgProp.Color = levelProp[Level].dos_donts.Color
	local bgRect = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	bgRect:setFillColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4])
	
	
 
	
    local background = display.newImageRect( sceneGroup, bgProp.Img, totalHeight, totalWidth )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	
	
	
	background:addEventListener( "tap", gotoGame )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene( "dos_donts" )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene