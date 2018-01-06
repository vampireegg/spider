
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local drawFuncs = require("drawFuncs")

local scene = composer.newScene()

local Max_Level
local bgProp = {}
local totalHeight
local totalWidth
local legPhase
local legPhaseCount

local MaxCompletedLevel
local Level_Per_Row
local Rows

local levelIcons = {}
local spiderProp = {}
local spider = {}

local iConPosX
local iConPosY

local next1st_Level
local current1st_Level

local bgRect

local nextScreenButton = {}
local prevScreenButton = {}

local ending_level
local needtoGoToSelectLevel
local gotoSelectedLevel

local backgroundMusic
local backgroundMusicChannel

local function endSelection()
	audio.setVolume( 1/0.3, { channel=1 } )
	audio.stop( backgroundMusicChannel)
	audio.stop(backgroundMusicChannel)
	backgroundMusicChannel = nil
	audio.dispose( backgroundMusicChannel )
	display.remove(sceneGroup)
	for i = 1, 8 do
		display.remove(spiderProp.leg[i])
	end
	display.remove( spider[1] )
	for i = current1st_Level,current1st_Level + 7 do
		display.remove(levelIcons[i])
		display.remove(levelIcons[i].txt)
		display.remove(levelIcons[i].txt2)
	end
	display.remove(bgProp.bg)
	display.remove(bgRect)
	display.remove(nextScreenButton[1])
	display.remove(prevScreenButton[1])
	ending_level = true
	local options = {
		effect = "fade",
		time = 800
	}
	if(gotoSelectedLevel == true) then
		print("going to select_level")
		composer.gotoScene( "select_level", options )
	else
		print("going to dos_donts")
		composer.gotoScene( "dos_donts" , options)
	end
	
end 

local function on_frame( event )

	if(needtoGoToSelectLevel == true) then
		Runtime:removeEventListener( "enterFrame", on_frame )
		timer.performWithDelay( 100, endSelection )
	else
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
end



local function gotoGame(event)
	needtoGoToSelectLevel = true	
	gotoSelectedLevel = false
	composer.setVariable("level",event.target.level)
end

local function gotoSelectLevel(event)
	needtoGoToSelectLevel = true	
	composer.setVariable("1st_level",event.target.target1stLevel)
	print("gotoSelectLevel" .. event.target.target1stLevel)
    
end



function scene:create( event )
 
	MaxCompletedLevel = composer.getVariable("max_completed_level")
	print("dos_donts MaxCompletedLevel = " .. MaxCompletedLevel)
	
	needtoGoToSelectLevel = false
	MaxLevel = #levelProp
	current1st_Level = composer.getVariable("1st_level")
	gotoSelectedLevel= true
	print("current1st_Level = " .. current1st_Level)
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
	
	ending_level = false
	
	bgProp.Img = commonProp.level_select_screen.Img
	bgProp.Color = commonProp.level_select_screen.Color
	bgProp.bg = display.newImageRect( sceneGroup, commonProp.level_select_screen.Img, totalHeight, totalWidth )
	bgProp.bg.x = totalHeight/2
	bgProp.bg.y = totalWidth/2
	bgRect = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	bgRect:setFillColor(bgProp.Color[1], bgProp.Color[2], bgProp.Color[3], bgProp.Color[4])
	
	
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
	spiderProp.ImgWidth = 629
	spiderProp.ImgHeight = 710
	spiderProp.BodyRatio = 0.65
	
	drawFuncs.drawSpider(sceneGroup, spider, spiderProp, nil, 0)
	
	local levelCount = current1st_Level
	for i = 1,8 do
		if(levelCount <= MaxLevel) then
			levelIcons[levelCount] = display.newImageRect( sceneGroup, levelProp[levelCount].icon.Img, 432, 468 )
			levelIcons[levelCount]:scale(0.25, 0.25)
			local radAngle = (i - 1) * 45 * math.pi / 180
			levelIcons[levelCount].x = totalHeight/ 2 + 230 * math.cos(radAngle)
			levelIcons[levelCount].y = totalWidth / 2 + 230 * math.sin(radAngle)
			levelIcons[levelCount].level = levelCount
			
			
			levelIcons[levelCount].txt2 = display.newText(sceneGroup,levelProp[levelCount].levelName, levelIcons[levelCount].x + 10, levelIcons[levelCount].y + 40,  "comic.ttf", 10 )
			levelIcons[levelCount].txt = display.newText(sceneGroup,levelProp[levelCount].levelNumber .. ".", levelIcons[levelCount].txt2.x - levelIcons[levelCount].txt2.width/2 - 10, levelIcons[levelCount].txt2.y,  "comic.ttf", 12 )
			levelIcons[levelCount].txt:setFillColor( 0.2, 0.2, 0.0, 1)
			levelIcons[levelCount].txt2:setFillColor( 0.2, 0.2, 0.0, 1)
			
			if(levelCount <= MaxCompletedLevel) then
				levelIcons[levelCount]:addEventListener( "tap", gotoGame )
			else
				levelIcons[levelCount]:setFillColor(1,1,1,0.3)
				levelIcons[levelCount].txt2:setFillColor( 0.2, 0.2, 0.0, 0.3)
				levelIcons[levelCount].txt:setFillColor( 0.2, 0.2, 0.0, 0.3)
			end
		end
		spiderProp.leg[i].level = levelCount
		if(spiderProp.leg[i].level > MaxCompletedLevel) then
			spiderProp.leg[i]:setFillColor(1,1,1,0.3)
		end
		if(spiderProp.leg[i].level > MaxLevel) then
			spiderProp.leg[i]:setFillColor(1,1,1,0)
		end
		levelCount = levelCount + 1
	end

	if (current1st_Level + 8 <= MaxLevel) then
		nextScreenButton[1] = display.newImageRect( sceneGroup, "arrow_icon.png", 50, 50 )
		nextScreenButton[1].x = totalHeight - 50
		nextScreenButton[1].y = totalWidth - 50
		nextScreenButton[1].rotation = 45
		nextScreenButton[1].target1stLevel = current1st_Level + 8
		nextScreenButton[1]:addEventListener( "tap", gotoSelectLevel )
	end
	
	if (current1st_Level ~= 1) then
		prevScreenButton[1] = display.newImageRect( sceneGroup, "arrow_icon.png", 50, 50 )
		prevScreenButton[1].x = 50
		prevScreenButton[1].y = totalWidth - 50
		prevScreenButton[1].rotation = -135
		prevScreenButton[1].target1stLevel = current1st_Level - 8
		prevScreenButton[1]:addEventListener( "tap", gotoSelectLevel )
	end
	
	backgroundMusic = audio.loadStream( "jungle.mp3" )
	backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )
	audio.setVolume( 0.3, { channel=1 } )
 
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