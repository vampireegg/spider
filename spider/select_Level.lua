
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local drawFuncs = require("drawFuncs")

local scene = composer.newScene()

local Level
local bgProp = {}
local totalHeight
local totalWidth
local legPhase
local legPhaseCount

local MaxLevel
local Level_Per_Row
local Rows

local levelIcons = {}
local spiderProp = {}
local spider = {}

local iConPosX
local iConPosY

local function gotoGame(event)
	local options = {
		effect = "slideLeft",
		time = 800
	}
	composer.getVariable(event.target.level)
    composer.gotoScene( "dos_donts" , options)
end


local function on_frame( event )
	for i = 1, 8 do
		if(spiderProp.leg[i].exists == 1)then
			if(legPhase == 1) then
				spiderProp.leg[i].x = spiderProp.leg[i].x + 0.5 * spiderProp.leg[i].dirx
				spiderProp.leg[i].y = spiderProp.leg[i].y + 0.5 * spiderProp.leg[i].diry
			else
				spiderProp.leg[i].x = spiderProp.leg[i].x - 0.5 * spiderProp.leg[i].dirx
				spiderProp.leg[i].y = spiderProp.leg[i].y - 0.5 * spiderProp.leg[i].diry
			end
		end
	end
	legPhaseCount = legPhaseCount + 1
	if(legPhaseCount == 10) then
		legPhase = legPhase * -1
		legPhaseCount = 0
	end
end

function scene:create( event )
 
	Level = composer.getVariable("level")
	print("dos_donts Level = " .. Level)
	
	MaxLevel = 9
	-- Level_Per_Row = 5
	-- Rows = math.ceil(MaxLevel / Level_Per_Row)
	
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	-- iConPosX = totalHeight / Level_Per_Row
	-- iConPosY = 150
	
	legPhase = 1
	legPhaseCount = 0
	
	bgProp.Img = commonProp.level_select_screen.Img
	bgProp.Color = commonProp.level_select_screen.Color
	local bgRect = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	bgRect:setFillColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4])
	
	-- local levelCount = 1
	-- for i = 1,Rows do
		-- for j = 1,Level_Per_Row do
			-- if(levelCount <= MaxLevel) then
				-- levelIcons[levelCount] = display.newImageRect( sceneGroup, levelProp[levelCount].icon.Img, 640, 605 )
				-- levelIcons[levelCount]:scale(0.15, 0.15)
				-- levelIcons[levelCount].x = (j - 1) * iConPosX + iConPosX/2
				-- levelIcons[levelCount].y = (i - 1) * iConPosY + iConPosY/2
				-- levelIcons[levelCount].circle = display.newCircle( sceneGroup, levelIcons[levelCount].x , levelIcons[levelCount].y, 45 )
				-- levelIcons[levelCount].circle:setFillColor( 1,1,1,0 )
				-- levelIcons[levelCount].circle.strokeWidth = 5
				-- levelIcons[levelCount].circle:setStrokeColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4] )
				-- levelCount = levelCount + 1
			-- end
		-- end
	-- end	
	
	
	
	
	
	
	-- local background = display.newImageRect( sceneGroup, bgProp.Img, totalHeight, totalWidth )
    -- background.x = totalHeight/2
    -- background.y = totalWidth/2
	-- background:scale(1,1)
	-- background:setFillColor(1,1,1,0.4)
	
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
	spiderProp.LegImg = "arrow_icon.png"
	spiderProp.Img = "spider_icon.png"
	
	drawFuncs.drawSpider(sceneGroup, spider, spiderProp, physics, 1, 0)
	
	local levelCount = 1
	for i = 1,8 do
		if(levelCount <= MaxLevel) then
			levelIcons[levelCount] = display.newImageRect( sceneGroup, levelProp[levelCount].icon.Img, 100, 100 )
			--levelIcons[levelCount]:scale(0.15, 0.15)
			local radAngle = (i - 1) * 45 * math.pi / 180
			levelIcons[levelCount].x = totalHeight/ 2 + 250 * math.cos(radAngle)
			levelIcons[levelCount].y = totalWidth / 2 + 250 * math.sin(radAngle)
			levelIcons[levelCount].level = levelCount
			levelIcons[levelCount]:addEventListener( "tap", gotoGame )
			-- levelIcons[levelCount].circle = display.newCircle( sceneGroup, levelIcons[levelCount].x , levelIcons[levelCount].y, 45 )
			-- levelIcons[levelCount].circle:setFillColor( 1,1,1,0 )
			-- levelIcons[levelCount].circle.strokeWidth = 5
			-- levelIcons[levelCount].circle:setStrokeColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4] )
			levelCount = levelCount + 1
		end
	end	
 
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		Runtime:addEventListener( "enterFrame", on_frame )

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
		composer.removeScene( "select_level" )

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