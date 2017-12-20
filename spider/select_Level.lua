
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local drawFuncs = require("drawFuncs")

local scene = composer.newScene()

local Level
local bgProp = {}
local totalHeight
local totalWidth

local spiderProp = {}
local spider = {}

local function gotoGame()
	local options = {
		effect = "slideLeft",
		time = 800
	}
    composer.gotoScene( "level" , options)
end

function scene:create( event )
 
	Level = composer.getVariable("level")
	print("dos_donts Level = " .. Level)
	
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	
	bgProp.Img = commonProp.level_select_screen.Img
	bgProp.Color = commonProp.level_select_screen.Color
	-- local bgRect = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	-- bgRect:setFillColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4])
	
	local background = display.newImageRect( sceneGroup, bgProp.Img, totalHeight, totalWidth )
    background.x = totalHeight/2
    background.y = totalWidth/2
	background:scale(1,1)
	background:setFillColor(1,1,1,0.4)
	
	spiderProp.MyScale = 0.4
	spiderProp.ArrowSize = 83.5 * spiderProp.MyScale
	spiderProp.BodySize = 487 * spiderProp.MyScale
	spiderProp.ArrowDistance = 365 * spiderProp.MyScale
	spiderProp.SpiderRadius = spiderProp.ArrowSize + spiderProp.ArrowDistance
	spiderProp.PosiX = totalHeight / 2
	spiderProp.PosiY = totalWidth / 2
	spiderProp.LegExists = {1,1,1,1,1,1,1,1}
	spiderProp.leg = {}
	spiderProp.legSquare = {}
	
	drawFuncs.drawSpider(sceneGroup, spider, spiderProp, physics)
 
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