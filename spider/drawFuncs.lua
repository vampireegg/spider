
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
	
end

M.drawBackGround = drawBackGround

local function drawButtons(sceneGroup, totalWidth, totalHeight, bgProp)
	bgProp.reLoadButton = display.newImageRect( sceneGroup, "reload2.png", 30, 30 )
	bgProp.reLoadButton.x = totalHeight - 80
	bgProp.reLoadButton.y =  50
	bgProp.reLoadButton:scale(0.9,0.9)
	
	bgProp.crossButton = display.newImageRect( sceneGroup, "cross2.png", 30, 30 )
	bgProp.crossButton.x = totalHeight - 40
	bgProp.crossButton.y =  50
	bgProp.crossButton:scale(0.8,0.8)
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

local function drawCollider(sceneGroup, collider, colliderProp, physics)
	for i = 1,#(colliderProp.numColliders) do
		collider[i] = {}
		if(colliderProp.Orientation[i] == 1) then
			for j = 1, colliderProp.numColliders[i] do
				collider[i][j] = display.newImageRect(sceneGroup, colliderProp.Img[colliderProp.ColliderType[i]], colliderProp.colliderWidth[colliderProp.ColliderType[i]], colliderProp.colliderHeight  )
				collider[i][j].x = colliderProp.colliderGroupx[i] + (j - 1) * colliderProp.colliderWidth[colliderProp.ColliderType[i]]
				collider[i][j].y = colliderProp.colliderGroupy[i]
				physics.addBody( collider[i][j], "static", { friction=0, bounce=0} )
				collider[i][j].Name = "collider_" .. i .. "_" .. j
				collider[i][j].CommonName = colliderProp.CommonName[colliderProp.ColliderType[i]]
			end
		else
			for j = 1, colliderProp.numColliders[i] do
				collider[i][j] = display.newImageRect(sceneGroup, colliderProp.Img[colliderProp.ColliderType[i]], colliderProp.colliderWidth[colliderProp.ColliderType[i]], colliderProp.colliderHeight  )
				collider[i][j].x = colliderProp.colliderGroupx[i] 
				collider[i][j].y = colliderProp.colliderGroupy[i] + (j - 1) * colliderProp.colliderWidth[colliderProp.ColliderType[i]]
				collider[i][j].rotation = 90
				physics.addBody( collider[i][j], "static", { friction=0, bounce=0} )
				collider[i][j].Name = "collider_" .. i .. "_" .. j
				collider[i][j].CommonName = colliderProp.CommonName[colliderProp.ColliderType[i]]
			end
		end
	end
end
M.drawCollider = drawCollider

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

local function drawSpider(sceneGroup, spider, spiderProp, physics)
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
		spiderProp.leg[i] = display.newImageRect(sceneGroup, "arrow.png", spiderProp.ArrowSize,spiderProp.ArrowSize  )
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
	spiderProp.body = display.newSprite(sceneGroup, spiderProp.bodySheet, spiderProp.spd_movement )
	spiderProp.body:play()
	spiderProp.body:scale(spiderProp.MyScale,spiderProp.MyScale)
	spider[1]:insert( spiderProp.body )
	for i = 1,8 do
		print('spiderProp.leg[i].x' .. spiderProp.leg[i].x .. 'spiderProp.leg[i].y' .. spiderProp.leg[i].y)
		spiderProp.legSquare[i] = display.newRect(sceneGroup, spiderProp.leg[i].x, spiderProp.leg[i].y, spiderProp.ArrowSize * 5, spiderProp.ArrowSize * 5)
		spiderProp.legSquare[i]:setFillColor( 1, 1, 1, 0 )
		spiderProp.legSquare[i].leg = spiderProp.leg[i]
		spiderProp.legSquare[i].isHitTestable = true
		spider[1]:insert(spiderProp.legSquare[i])
	end
	--local offsetRectParams = { halfWidth=spiderProp.SpiderRadius, halfHeight=spiderProp.SpiderRadius, x=0, y=0, angle=0 }
	--spider[1].isFixedRotation = true
	physics.addBody( spider[1], "dynamic", {radius = spiderProp.SpiderRadius * .9, friction=0, bounce=0})
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
