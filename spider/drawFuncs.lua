
local sheetInfo = require("sheet")
local eyesheetInfo = require("eyesheet")
local M = {}
local function drawBorder(borders, totalWidth, totalHeight, borderProp)
	borders[0] = display.newRect( borderProp.borderWidth/2, totalWidth/2, borderProp.borderWidth, totalWidth)
	borders[0]:setFillColor( 1, 1, 1, 0 )
	
	borders[1] = display.newRect( totalHeight - borderProp.borderWidth/2,  totalWidth/2, borderProp.borderWidth, totalWidth)
	borders[1]:setFillColor( 1, 1, 1, 0 )
	
	borders[2] = display.newRect( totalHeight/2, borderProp.borderWidth/2, totalHeight, borderProp.borderWidth)
	borders[2]:setFillColor( 1, 1, 1, 0 )

	borders[3] = display.newRect( totalHeight/2, totalWidth - borderProp.borderWidth/2, totalHeight, borderProp.borderWidth)
	borders[3]:setFillColor( 1, 1, 1, 0 )
	
	for i = 0,3 do
		physics.addBody( borders[i], "static", { friction=0, bounce=0} )
		borders[i].Name = "borders_" .. i
	end
end

M.drawBorder = drawBorder

local function drawBackGround(bg, totalWidth, totalHeight)
	bg = display.newImageRect( "tree2.jpg", totalHeight, totalWidth )
	bg.x = totalHeight/2
	bg.y = totalWidth/2
	bg:setFillColor( 1, 1, 1, 0.45 )
end

M.drawBackGround = drawBackGround

local function drawCollider(collider, colliderProp)
	for i = 1,#(colliderProp.numColliders) do
		collider[i] = {}
		for j = 0, colliderProp.numColliders[i] - 1 do
			collider[i][j] = display.newImageRect( "collider.png", colliderProp.colliderWidth, colliderProp.colliderHeight  )
			collider[i][j].x = colliderProp.colliderGroupx[i] + j * colliderProp.colliderWidth
			collider[i][j].y = colliderProp.colliderGroupy[i]
			physics.addBody( collider[i][j], "static", { friction=0, bounce=0} )
			collider[i][j].Name = "collider_" .. i .. "_" .. j
		end
	end
end
M.drawCollider = drawCollider

local function drawEyes(eyes, eyeProp, totalWidth, totalHeight)
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
		eyes[i] = display.newSprite( eyeProp.Sheet, eyeProp.eye_movement[math.ceil(i/4)] )
		eyes[i].x = x
		eyes[i].y = y
		eyes[i].size = math.random() * .1 + .05
		eyes[i]:scale(eyes[i].size,eyes[i].size)
		eyes[i]:setFillColor( 1, 1, 1, .5 )
		eyes[i]:play()
	end
end

M.drawEyes = drawEyes

local function drawSpider(spider, spiderProp)
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
		spiderProp.leg[i] = display.newImageRect( "arrow.png", spiderProp.arrowsize,spiderProp.arrowsize  )
		spiderProp.leg[i].angle = i * 45
		spiderProp.leg[i].radAngle = (spiderProp.leg[i].angle + 135) * math.pi / 180
		spiderProp.leg[i].exists = true
		spiderProp.leg[i].rotAngle = (spiderProp.leg[i].angle + 315) * math.pi / 180
		spider:insert( spiderProp.leg[i] )	
		spiderProp.leg[i].i = i
		spiderProp.leg[i].rotation = spiderProp.leg[i].angle
		spiderProp.leg[i]:translate (spiderProp.arrowDistance * math.cos(spiderProp.leg[i].rotAngle), spiderProp.arrowDistance * math.sin(spiderProp.leg[i].rotAngle))
		
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

	spiderProp.body = display.newSprite( spiderProp.bodySheet, spiderProp.spd_movement )
	spiderProp.body:play()
	spiderProp.body:scale(spiderProp.scale,spiderProp.scale)
	spider:insert( spiderProp.body )
	for i = 1,8 do
		print('spiderProp.leg[i].x' .. spiderProp.leg[i].x .. 'spiderProp.leg[i].y' .. spiderProp.leg[i].y)
		spiderProp.legSquare[i] = display.newRect( spiderProp.leg[i].x, spiderProp.leg[i].y, spiderProp.arrowsize * 5, spiderProp.arrowsize * 5)
		spiderProp.legSquare[i]:setFillColor( 1, 1, 1, 0 )
		spiderProp.legSquare[i].leg = spiderProp.leg[i]
		spiderProp.legSquare[i].isHitTestable = true
		spider:insert(spiderProp.legSquare[i])
	end
	--local offsetRectParams = { halfWidth=spiderProp.spiderRadius, halfHeight=spiderProp.spiderRadius, x=0, y=0, angle=0 }
	--spider.isFixedRotation = true
	physics.addBody( spider, "dynamic", {radius = spiderProp.spiderRadius * .9, friction=0, bounce=0})
end

M.drawSpider = drawSpider

local function drawGoal(goal, goalProp)
	goal[0] = display.newImageRect( "goal.png", goalProp.size,goalProp.size  )
	goal[0].x = goalProp.x
	goal[0].y = goalProp.y
	--physics.addBody( goal[0], "dynamic", {friction=0, bounce=0})
	--goal[0].angularVelocity = 0
	goal[0].Name = "goal"
end

M.drawGoal = drawGoal
 
return M
