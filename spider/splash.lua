
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local scene = composer.newScene()


local Level
local bgProp = {}
local totalHeight
local totalWidth

local function gotoGame()
	local options = {
		effect = "fade",
		time = 800
	}
    composer.gotoScene( "select_level" , options)
end

local function on_frame( event )
end

function scene:create( event )
 
	print("splash")
	
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	
	bgProp.Img = commonProp.splash.Img

	
	
 
	
    local background = display.newImageRect( sceneGroup, bgProp.Img, totalHeight, totalWidth )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	
	
	
	background:addEventListener( "tap", gotoGame )
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
		composer.removeScene( "splash" )

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