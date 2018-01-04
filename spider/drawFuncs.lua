
local sheetInfo = require("sheet")
local eyesheetInfo = require("eyesheet")
local M = {}
local function drawBorder(sceneGroup, borders, totalWidth, totalHeight, borderProp, physics)
	borders[1] = display.newRect(sceneGroup, borderProp.borderWidth/2, totalWidth/2, borderProp.borderWidth, totalWidth)
	borders[1]:setFillColor( 1, 1, 1, 0 )
	
	borders[2] = display.newRect(sceneGroup, totalHeight - borderProp.borderWidth/2,  totalWidth/2, borderProp.borderWidth, totalWidth)
	borders[2]:setFillColor( 1, 1, 1, 0 )
	
	borders[3] = display.newRect(sceneGroup, totalHeight/2, borderProp.borderWidth/2, totalHeight, borderProp.borderWidth)
	borders[3]:setFillColor( 1, 1, 1, 0 )

	borders[4] = display.newRect(sceneGroup, totalHeight/2, totalWidth - borderProp.borderWidth/2, totalHeight, borderProp.borderWidth)
	borders[4]:setFillColor( 1, 1, 1, 0 )
	
	for i = 1,4 do
		physics.addBody( borders[i], "static", { friction=0, bounce=0} )
		borders[i].Name = "borders_" .. i
		borders[i].CommonName = borderProp.CommonName
	end
end

M.drawBorder = drawBorder

local function drawBackGround(sceneGroup, bg, totalWidth, totalHeight, bgProp)
	bg[1] = display.newImageRect( sceneGroup, bgProp.Img, totalHeight, totalWidth )
	bg[1].x = totalHeight/2
	bg[1].y = totalWidth/2
	bg[1]:setFillColor( 1, 1, 1, bgProp.Opacity )
	
	bgProp.extra = {}
	if(bgProp.ExtraImgExists == 1) then
		for i = 1, #bgProp.ExtraImg do
			bgProp.extra[i] = {}
			bgProp.extra[i].ExtraImg = display.newImageRect( sceneGroup, bgProp.ExtraImg[i], bgProp.ExtraImgWidth[i], bgProp.ExtraImgHeight[i] )
			bgProp.extra[i].ExtraImg.x = bgProp.ExtraImgX[i]
			bgProp.extra[i].ExtraImg.y = bgProp.ExtraImgY[i]
			bgProp.extra[i].ExtraImg:scale (bgProp.ExtraImgScale[i], bgProp.ExtraImgScale[i])
			bgProp.extra[i].ExtraImg:setFillColor (1,1,1, bgProp.ExtraImgOpacity[i])
		end
	end
	
end

M.drawBackGround = drawBackGround

local function drawScoreBoard(sceneGroup, scoreboard, scoreboardProp, totalWidth, totalHeight)
	scoreboardProp.rect:setFillColor( scoreboardProp.rectColor[1], scoreboardProp.rectColor[2], scoreboardProp.rectColor[3], 1)
	
	local posiY = 0
	local posiX = scoreboardProp.StartPosiX
	scoreboard.iconWidth = 1090
	scoreboard.iconHeight = 1080
	scoreboard.iconScale = 0.05
	
	posiY = posiY + 50
	
	scoreboard.scoreText = {}
	scoreboard.scoreText[1] = display.newText( "You Spent: ", posiX, posiY,  "comic.ttf", 24 )
	scoreboard.scoreText[1]:setFillColor( 0.9, 0.9, 0.65, 1)
	
	
	
	posiY = posiY + 200
	scoreboard.scoreText[2] = display.newText( "Moves : " .. scoreboardProp.PlayerMoves .. "/" .. scoreboardProp.OptimalMoves, posiX - 300, posiY,  "comic.ttf", 12 )
	
	scoreboard.scoreText[3] = display.newText( "Free Moves : " .. scoreboardProp.UsedFreeMoves, posiX + 300, posiY,  "comic.ttf", 12 )

	
	posiY = posiY + 50
	
	scoreboard.line = display.newLine( sceneGroup, 50, posiY, 1030, posiY)
	scoreboard.line:setStrokeColor( 0.9, 0.9, 0.65, 1)
	scoreboard.line.strokeWidth = 8
	
	
	posiY = posiY + 50
	
	scoreboard.scoreText[4] = display.newText( "You Earned: ", posiX, posiY,  "comic.ttf", 24 )
	scoreboard.scoreText[4]:setFillColor( 0.9, 0.9, 0.65, 1)
	
	posiY = posiY + 200
	
	scoreboard.scoreText[5] = display.newText( "Score : " .. scoreboardProp.Score .. "/" .. scoreboardProp.LevelGold, posiX - 300, posiY,  "comic.ttf", 12 )
	scoreboard.scoreText[5]:setFillColor( 0.9, 0.9, 0.65, 1)
	
	scoreboard.scoreText[6] = display.newText( "Gold : " .. scoreboardProp.EarnedGold, posiX, posiY,  "comic.ttf", 12 )
	scoreboard.scoreText[6]:setFillColor( 0.9, 0.9, 0.65, 1)
	
	scoreboard.scoreText[7] = display.newText( "Free Moves : " .. scoreboardProp.EarnedFreeMove, posiX + 300, posiY,  "comic.ttf", 12 )
	scoreboard.scoreText[7]:setFillColor( 0.9, 0.9, 0.65, 1)
	
	-- posiY = posiY + scoreboardProp.LineGap
	-- scoreboard.scoreText[8] = display.newText( "Total Gold : " .. scoreboardProp.TotalGold, posiX, posiY,  "comic.ttf", 24 )
	-- scoreboard.scoreText[8]:setFillColor( 0.9, 0.9, 0.65, 1)
	
	-- posiY = posiY + scoreboardProp.LineGap
	-- scoreboard.scoreText[9] = display.newText( "Total Free Moves : " .. scoreboardProp.TotalFreeMove, posiX, posiY,  "comic.ttf", 24 )
	-- scoreboard.scoreText[9]:setFillColor( 0.9, 0.9, 0.65, 1)
	
end

M.drawScoreBoard = drawScoreBoard

local function drawNextMove(sceneGroup, nextMove, nextMoveProp)
	nextMove[1] = display.newGroup()
	nextMove[1].x = nextMoveProp.PosiX
	nextMove[1].y = nextMoveProp.PosiY
	
	nextMove[1].img = display.newImageRect(nextMoveProp.Img, nextMoveProp.Width, nextMoveProp.Height )
	nextMove[1]:insert(nextMove[1].img)
	nextMove[1].img.x = 0
	nextMove[1].img.y = 0
	nextMove[1].img:scale(nextMoveProp.Scale, nextMoveProp.Scale)
	
	nextMove[1].txt = display.newText( "Use one Free Move?", 80, 0,  "comic.ttf", 12 )
	nextMove[1]:insert(nextMove[1].txt)
	nextMove[1].txt:setFillColor( 0.9, 0.9, 0.65, 1)
	
	nextMove[1].txt2 = display.newText( nextMoveProp.totalFreeMove .. "", 25, 20,  "comic.ttf", 12 )
	nextMove[1]:insert(nextMove[1].txt2)
	nextMove[1].txt2:setFillColor( 0.9, 0.9, 0.65, 1)
	
	
	sceneGroup:insert(nextMove[1])
end

M.drawNextMove = drawNextMove

local function drawNotiFication(sceneGroup, noti, notiProp, totalWidth, totalHeight)
	notiProp.rect = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	notiProp.rect:setFillColor( 0.3, 0.3, 0.3, RectOpacity)
	for i = 1, #notiProp.Img do
		noti[i] = display.newImageRect( sceneGroup, notiProp.Img[i], notiProp.Width[i], notiProp.Height[i] )
		noti[i].x = notiProp.PosiX[i]
		noti[i].y = notiProp.PosiY[i]
		noti[i]:setFillColor( 1, 1, 1, notiProp.Opacity[i] )
		noti[i]:scale(notiProp.Scale[i], notiProp.Scale[i])
	end
end

M.drawNotiFication = drawNotiFication

local function drawButtons(sceneGroup, totalWidth, totalHeight, bgProp)
	bgProp.reLoadButton = display.newImageRect( sceneGroup, "reload2.png", 30, 30 )
	bgProp.reLoadButton.x = totalHeight - 80
	bgProp.reLoadButton.y =  50
	bgProp.reLoadButton:scale(0.9,0.9)
	
	bgProp.reLoadButtonBox = display.newRect(sceneGroup, bgProp.reLoadButton.x, bgProp.reLoadButton.y, 30, 30)
	bgProp.reLoadButtonBox:setFillColor( 1, 1, 1, 0 )
	bgProp.reLoadButtonBox.isHitTestable = true
	
	bgProp.crossButton = display.newImageRect( sceneGroup, "cross2.png", 30, 30 )
	bgProp.crossButton.x = totalHeight - 40
	bgProp.crossButton.y =  50
	bgProp.crossButton:scale(0.8,0.8)
	
	bgProp.crossButtonBox = display.newRect(sceneGroup, bgProp.crossButton.x, bgProp.crossButton.y, 30, 30)
	bgProp.crossButtonBox:setFillColor( 1, 1, 1, 0 )
	bgProp.crossButtonBox.isHitTestable = true
end

M.drawButtons = drawButtons

local function drawPortals(sceneGroup, portal, portalProp)
	for i = 1,#(portalProp.Types) do
		portal[i] = {}
		for j = 1, 2 do
			portal[i][j] = display.newImageRect(sceneGroup, portalProp.Img[portalProp.Types[i]], portalProp.Size, portalProp.Size  )
			portal[i][j].x = portalProp.PosiX[i][j]
			portal[i][j].y = portalProp.PosiY[i][j]
			portal[i][j].sensitive = 1
		end
		portal[i][2].pair = portal[i][1]
		portal[i][1].pair = portal[i][2]
	end
end

M.drawPortals = drawPortals

local function drawHearts(sceneGroup, heart, heartProp)
	for i = 1,#(heartProp.PosiX) do
		heart[i] = display.newImageRect(sceneGroup, heartProp.Img, heartProp.Size, heartProp.Size  )
		heart[i].x = heartProp.PosiX[i]
		heart[i].y = heartProp.PosiY[i]
	end
end

M.drawHearts = drawHearts

local function drawCollider(sceneGroup, collider, colliderProp, physics)
	for i = 1,#(colliderProp.numColliders) do
		collider[i] = {}
		if(colliderProp.Orientation[i] == 1) then
			for j = 1, colliderProp.numColliders[i] do
				collider[i][j] = display.newImageRect(sceneGroup, colliderProp.Img[colliderProp.ColliderType[i]], colliderProp.colliderWidth[colliderProp.ColliderType[i]], colliderProp.colliderHeight  )
				collider[i][j].x = colliderProp.colliderGroupx[i] + (j - 1) * colliderProp.colliderWidth[colliderProp.ColliderType[i]]
				collider[i][j].y = colliderProp.colliderGroupy[i]
				collider[i][j].Orientation = colliderProp.Orientation[i]
				if(physics ~= nil) then
					physics.addBody( collider[i][j], "static", { friction=0, bounce=0} )
				end
				collider[i][j].Name = "collider_" .. i
				collider[i][j].CommonName = colliderProp.CommonName[colliderProp.ColliderType[i]]
			end
		else
			for j = 1, colliderProp.numColliders[i] do
				collider[i][j] = display.newImageRect(sceneGroup, colliderProp.Img[colliderProp.ColliderType[i]], colliderProp.colliderWidth[colliderProp.ColliderType[i]], colliderProp.colliderHeight  )
				collider[i][j].x = colliderProp.colliderGroupx[i] 
				collider[i][j].y = colliderProp.colliderGroupy[i] + (j - 1) * colliderProp.colliderWidth[colliderProp.ColliderType[i]]
				collider[i][j].Orientation = colliderProp.Orientation[i]
				if(physics ~= nil) then
					physics.addBody( collider[i][j], "static", { friction=0, bounce=0} )
				end
				collider[i][j].rotation = 90
				collider[i][j].Name = "collider_" .. i
				collider[i][j].CommonName = colliderProp.CommonName[colliderProp.ColliderType[i]]
			end
		end
	end
end
M.drawCollider = drawCollider

local function drawSwitchSystem(sceneGroup, switchSystem, switchSystemProp, physics)
	switchSystemProp.window.CurState = {}
	for i = 1,switchSystemProp.Num do
		switchSystem.switch[i] = display.newImageRect(sceneGroup, switchSystemProp.switch.Img, switchSystemProp.switch.Width, switchSystemProp.switch.Height)
		switchSystem.switch[i].x = switchSystemProp.switch.PosiX[i]
		switchSystem.switch[i].y = switchSystemProp.switch.PosiY[i]
		switchSystem.switch[i].SpiderEntered = false
		switchSystem.switch[i]:scale(switchSystemProp.switch.Scale, switchSystemProp.switch.Scale)
		switchSystem.switch[i]:setFillColor(switchSystemProp.Color[i][1], switchSystemProp.Color[i][2], switchSystemProp.Color[i][3], 1)
		
		switchSystem.window[i] = {}	
		switchSystemProp.window.CurState[i] = {}		
		for j = 1, 2 do
			switchSystem.window[i][j] = {}
			for k = 1, switchSystemProp.window.Num[i][j] do
				switchSystem.window[i][j][k] = display.newImageRect(sceneGroup, switchSystemProp.window.Img, switchSystemProp.window.Width, switchSystemProp.window.Height)
				if(switchSystemProp.window.Orientation[i][j] == 1) then
					switchSystem.window[i][j][k].x = switchSystemProp.window.PosiX[i][j] + (k - 1) * switchSystemProp.window.Width
					switchSystem.window[i][j][k].y = switchSystemProp.window.PosiY[i][j]
				else
					switchSystem.window[i][j][k].x = switchSystemProp.window.PosiX[i][j] 
					switchSystem.window[i][j][k].y = switchSystemProp.window.PosiY[i][j] + (k - 1) * switchSystemProp.window.Height
				end
				switchSystem.window[i][j][k].Name = "window_" .. i .. j
				switchSystem.window[i][j][k].CommonName = "window"
				switchSystemProp.window.CurState[i][j] = switchSystemProp.window.State[i][j]
				if(switchSystemProp.window.CurState[i][j] == 0) then
					switchSystem.window[i][j][k]:setFillColor( switchSystemProp.Color[i][1], switchSystemProp.Color[i][2], switchSystemProp.Color[i][3], 0.3 )
				else
					switchSystem.window[i][j][k]:setFillColor( switchSystemProp.Color[i][1], switchSystemProp.Color[i][2], switchSystemProp.Color[i][3], 1 )
					physics.addBody( switchSystem.window[i][j][k], "static", { friction=0, bounce=0} )
				end
			end
		end	
		switchSystem.window[i][1].pair = switchSystem.window[i][2]
		switchSystem.window[i][2].pair = switchSystem.window[i][1]
	end
end
M.drawSwitchSystem = drawSwitchSystem

local function drawEyes(sceneGroup, eyes, eyeProp, totalWidth, totalHeight)
	eyeProp.Sheet = graphics.newImageSheet("eyesheet.png", eyesheetInfo:getSheet())
	eyeProp.eye_movement = {}
	for i = 1, 4 do
		eyeProp.eye_movement[i] = 
		{
			{
				name = "eyeRun" .. i,
				frames = { math.fmod(i,4) + 1,math.fmod((i + 1),4) + 1,math.fmod((i + 2),4) + 1,math.fmod((i + 3),4) + 1 },
				--frames = { 1,2,3,4 },
				time = i * 800,
				loopCount = 0,
				loopDirection = "forward"
			}
		}
	end
	for i = 1, 16 do
		local x = math.random(0, totalHeight)
		local y = math.random(0, totalWidth)
		eyes[i] = display.newSprite(sceneGroup, eyeProp.Sheet, eyeProp.eye_movement[math.ceil(i/4)] )
		eyes[i].x = x
		eyes[i].y = y
		eyes[i].Size = math.random() * .1 + .05
		eyes[i]:scale(eyes[i].Size,eyes[i].Size)
		eyes[i]:setFillColor( 1, 1, 1, eyeProp.Opacity )
		eyes[i]:play()
	end
end

M.drawEyes = drawEyes

local function drawSpider(sceneGroup, spider, spiderProp, physics, hasSheet)
	spider[1] = display.newGroup()
	sceneGroup:insert(spider[1])
	spider[1].x = spiderProp.PosiX
	spider[1].y = spiderProp.PosiY
	-- sequences table
	spiderProp.spd_movement = {
    -- consecutive frames sequence
		{
			name = "normalRun",
			frames = { 1,2,3,4,5 },
			time = 800,
			loopCount = 0,
			loopDirection = "forward"
		}
	}
	spiderProp.bodySheet = graphics.newImageSheet("sheet.png", sheetInfo:getSheet())
	for i = 1,8 do
		spiderProp.leg[i] = display.newImageRect(spiderProp.LegImg, spiderProp.ArrowSize,spiderProp.ArrowSize  )
		spiderProp.leg[i].angle = i * 45
		spiderProp.leg[i].radAngle = (spiderProp.leg[i].angle + 135) * math.pi / 180
		spiderProp.leg[i].exists = true
		spiderProp.leg[i].rotAngle = (spiderProp.leg[i].angle + 315) * math.pi / 180
		spider[1]:insert( spiderProp.leg[i] )	
		spiderProp.leg[i].i = i
		spiderProp.leg[i].exists = spiderProp.LegExists[i]
		spiderProp.leg[i].rotation = spiderProp.leg[i].angle
		spiderProp.leg[i]:translate (spiderProp.ArrowDistance * math.cos(spiderProp.leg[i].rotAngle), spiderProp.ArrowDistance * math.sin(spiderProp.leg[i].rotAngle))
		
		if(spiderProp.leg[i].exists == 1) then
			spiderProp.leg[i]:setFillColor( 1, 1, 1, 1 )
		else
			spiderProp.leg[i]:setFillColor( 1, 1, 1, 0.1 )
		end
		
		if(i == 1 or i == 2 or i == 8) then
			spiderProp.leg[i].dirx = 1
		elseif (i == 4 or i == 5 or i == 6) then
			spiderProp.leg[i].dirx = -1
		else
			spiderProp.leg[i].dirx = 0
		end
		
		if(i == 2 or i == 3 or i == 4) then
			spiderProp.leg[i].diry = 1
		elseif (i == 6 or i == 7 or i == 8) then
			spiderProp.leg[i].diry = -1
		else
			spiderProp.leg[i].diry = 0
		end
	end
	spiderProp.leg[2].pair = spiderProp.leg[4]
	spiderProp.leg[4].pair = spiderProp.leg[2]
	if(hasSheet == 1)then
		spiderProp.body = display.newSprite(spiderProp.bodySheet, spiderProp.spd_movement )
		spiderProp.body:play()
		spiderProp.body:scale(spiderProp.MyScale,spiderProp.MyScale)
	else
		spiderProp.body = display.newImageRect(spiderProp.Img, 629, 710 )
		spiderProp.body:scale(spiderProp.MyScale * 0.7 ,spiderProp.MyScale * 0.7)
	end

	
	spider[1]:insert( spiderProp.body )
	for i = 1,8 do
		--print('spiderProp.leg[i].x' .. spiderProp.leg[i].x .. 'spiderProp.leg[i].y' .. spiderProp.leg[i].y)
		spiderProp.legSquare[i] = display.newRect(sceneGroup, spiderProp.leg[i].x, spiderProp.leg[i].y, spiderProp.ArrowSize * 4, spiderProp.ArrowSize * 4)
		spiderProp.legSquare[i]:setFillColor( 1, 1, 1, 0 )
		spiderProp.legSquare[i].leg = spiderProp.leg[i]
		spiderProp.legSquare[i].isHitTestable = true
		spider[1]:insert(spiderProp.legSquare[i])
	end
	--local offsetRectParams = { halfWidth=spiderProp.SpiderRadius, halfHeight=spiderProp.SpiderRadius, x=0, y=0, angle=0 }
	--spider[1].isFixedRotation = true
	
	if(physics ~= nil) then
		physics.addBody( spider[1], "dynamic", {radius = spiderProp.SpiderRadius * .9, friction=0, bounce=0})
	end
	spider[1].isBullet = true
end

M.drawSpider = drawSpider

local function drawGoal(sceneGroup, goal, goalProp, physics)
	goal[1] = display.newImageRect(sceneGroup, "goal.png", goalProp.Size,goalProp.Size  )
	goal[1].x = goalProp.x
	goal[1].y = goalProp.y
	goal[1].Name = "goal"
end

M.drawGoal = drawGoal

 
return M
