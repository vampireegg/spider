
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local drawFuncs = require("drawFuncs")
local scene = composer.newScene()


local Level
local bgProp = {}
local totalHeight
local totalWidth
local counter


local backgroundMusic
local backgroundMusicChannel
local bgRect
local background = {}
local sheet
local titleAnimation

local options =
{
    width = 538,
    height = 448,
    numFrames = 5
}


local function gotoGame()
	
	local options = {
		effect = "fade",
		time = 800
	}
    composer.gotoScene( "splash" , options)
end

local function on_frame( event )
	counter = counter + 1

	if(counter == 160) then
		--display.remove(bgRect)
		--display.remove(background[1])
		--display.remove(background[2])
		display.remove(sceneGroup)
		Runtime:removeEventListener( "enterFrame", on_frame )
		timer.performWithDelay( 100, gotoGame )
	end
end


function scene:create( event )
 
	print("splash")

	counter = 0
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	sheet = graphics.newImageSheet( "litl.png", options )
	
	local sequenceData =
	{
		name="title_sequence",
		start=1,
		count=5,
		time=1500,
		loopCount = 1,   -- Optional ; default is 0 (loop indefinitely)
		loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
	}
	
	
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	
	bgProp.Img = commonProp.title.Img
	bgProp.Width = commonProp.title.Width
	bgProp.Height = commonProp.title.Height
	
	bgProp.Color = commonProp.title.Color
	bgRect = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	bgRect:setFillColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4])
 
	
    -- background[1] = display.newImageRect( sceneGroup, bgProp.Img[1], bgProp.Width[1], bgProp.Height[1] )
    -- background[1].x = display.contentCenterX
    -- background[1].y = display.contentCenterY
	-- background[1]:translate(-35, -30)
	-- background[1]:scale(0.25,0.25)
	
	-- background[2] = display.newImageRect( sceneGroup, bgProp.Img[2], bgProp.Width[2], bgProp.Height[2] )
    -- background[2].x = display.contentCenterX
    -- background[2].y = display.contentCenterY
	-- background[2]:translate(115, 60)
	-- background[2]:scale(0.18,0.18)
	
	titleAnimation = display.newSprite( sceneGroup, sheet, sequenceData )
	titleAnimation.x = display.contentCenterX
	titleAnimation.y = display.contentCenterY
	titleAnimation:scale(0.5,0.5)
	
	
	background[3] = display.newImageRect( sceneGroup, bgProp.Img[3], bgProp.Width[3], bgProp.Height[3] )
    background[3].x = display.contentCenterX
    background[3].y = display.contentCenterY
	background[3]:translate(450, 250)
	background[3]:scale(0.06,0.06)
	
	Runtime:addEventListener( "enterFrame", on_frame )
	
	
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		titleAnimation:play()
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
		timer.performWithDelay( 30, 
		   function()
			  composer.removeScene( "title" )
		   end 
	   )

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