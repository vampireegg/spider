
local sheetInfo = require("sheet")
local eyesheetInfo = require("eyesheet")
local M = {}
local function drawBorder(sceneGroup, borders, totalWidth, totalHeight, borderProp)
	borders[0] = display.newRect(sceneGroup, borderProp.borderWidth/2, totalWidth/2, borderProp.borderWidth, totalWidth)
	borders[0]:setFillColor( 1, 1, 1, 0 )
	
	borders[1] = display.newRect(sceneGroup, totalHeight - borderProp.borderWidth/2,  totalWidth/2, borderProp.borderWidth, totalWidth)
	borders[1]:setFillColor( 1, 1, 1, 0 )
	
	borders[2] = display.newRect(sceneGroup, totalHeight/2, borderProp.borderWidth/2, totalHeight, borderProp.borderWidth)
	borders[2]:setFillColor( 1, 1, 1, 0 )

	borders[3] = display.newRect(sceneGroup, totalHeight/2, totalWidth - borderProp.borderWidth/2, totalHeight, borderProp.borderWidth)
	borders[3]:setFillColor( 1, 1, 1, 0 )
	
	for i = 0,3 do
		physics.addBody( borders[i], "static", { friction=0, bounce=0} )
		borders[i].Name = "borders_" .. i
	end
end

M.drawBorder = drawBorder

local function drawBackGround(sceneGroup, bg, totalWidth, totalHeight)
	bg[1] = display.newImageRect( sceneGroup, "tree2.jpg", totalHeight, totalWidth )
	bg[1].x = totalHeight/2
	bg[1].y = totalWidth/2
	bg[1]:setFillColor( 1, 1, 1, 0.45 )
end

M.drawBackGround = drawBackGround

local function drawCollider(sceneGroup, collider, colliderProp)
	for i = 1,#(colliderProp.numColliders) do
		collider[i] = {}
		for j = 0, colliderProp.numColliders[i] - 1 do
			collider[i][j] = display.newImageRect(sceneGroup, "collider.png", colliderProp.colliderWidth, colliderProp.colliderHeight  )
			collider[i][j].x = colliderProp.colliderGroupx[i] + j * colliderProp.colliderWidth
			collider[i][j].y = colliderProp.colliderGroupy[i]
			physics.addBody( collider[i][j], "static", { friction=0, bounce=0} )
			collider[i][j].Name = "collider_" .. i .. "_" .. j
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
				frames = { math.fmod(i,4),math.fmod((i + 1),4),math.fmod((i + 2),4),math.fmod((i + 3),4) },
				--frames = { 1,2,3,4 },
				time = i * 400,
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
		eyes[i]:setFillColor( 1, 1, 1, .5 )
		eyes[i]:play()
	end
end

M.drawEyes = drawEyes

local function drawSpider(sceneGroup, spider, spiderProp)
	spider[1] = display.newGroup(sceneGroup)
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
		spiderProp.leg[i].rotation = spiderProp.leg[i].angle
		spiderProp.leg[i]:translate (spiderProp.ArrowDistance * math.cos(spiderProp.leg[i].rotAngle), spiderProp.ArrowDistance * math.sin(spiderProp.leg[i].rotAngle))
		
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

local function drawGoal(sceneGroup, goal, goalProp)
	goal[0] = display.newImageRect(sceneGroup, "goal.png", goalProp.Size,goalProp.Size  )
	goal[0].x = goalProp.x
	goal[0].y = goalProp.y
	--physics.addBody( goal[0], "dynamic", {friction=0, bounce=0})
	--goal[0].angularVelocity = 0
	goal[0].Name = "goal"
end

M.drawGoal = drawGoal
 
return M
