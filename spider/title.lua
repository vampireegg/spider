
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

local function gotoGame()
	
	local options = {
		effect = "fade",
		time = 1800
	}
    composer.gotoScene( "splash" , options)
end

local function on_frame( event )
	counter = counter + 1

	if(counter == 60) then
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
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	
	bgProp.Img = commonProp.title.Img
	bgProp.Width = commonProp.title.Width
	bgProp.Height = commonProp.title.Height
	
	bgProp.Color = commonProp.title.Color
	bgRect = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	bgRect:setFillColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4])
 
	
    background[1] = display.newImageRect( sceneGroup, bgProp.Img[1], bgProp.Width[1], bgProp.Height[1] )
    background[1].x = display.contentCenterX
    background[1].y = display.contentCenterY
	background[1]:translate(-50, -30)
	background[1]:scale(0.25,0.25)
	
	background[2] = display.newImageRect( sceneGroup, bgProp.Img[2], bgProp.Width[2], bgProp.Height[2] )
    background[2].x = display.contentCenterX
    background[2].y = display.contentCenterY
	background[2]:translate(100, 60)
	background[2]:scale(0.18,0.18)
	
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
		composer.removeScene( "title" )

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