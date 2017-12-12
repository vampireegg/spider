
local sheetInfo = require("sheet")
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
	bg = display.newImageRect( "bbg2.png", totalHeight, totalWidth )
	bg.x = totalHeight/2
	bg.y = totalWidth/2
end

M.drawBackGround = drawBackGround

local function drawCollider(collider, colliderProp)
	for i = 0, colliderProp.numColliders - 1 do
		collider[i] = display.newImageRect( "collider.png", colliderProp.colliderWidth, colliderProp.colliderHeight  )
		collider[i].x = colliderProp.colliderGroupx + i * colliderProp.colliderWidth
		collider[i].y = colliderProp. colliderGroupy
		collider[i].colliderRectParams = { halfWidth=colliderProp.colliderWidth/2, halfHeight=colliderProp.colliderHeight/2,
		x=colliderProp.colliderGroupx + collider[i].x , y=colliderProp.colliderGroupy + collider[i].y, angle=0 }
		physics.addBody( collider[i], "static", { friction=0, bounce=0} )
		collider[i].Name = "collider_" .. i
	end
end
M.drawCollider = drawCollider

local function drawSpider(spider, spiderProp)
	-- sequences table
	local spd_movement = {
    -- consecutive frames sequence
		{
			name = "normalRun",
			start = 1,
			count = 5,
			time = 8,
			loopCount = 0,
			loopDirection = "forward"
		}
	}
	local bodySheet = graphics.newImageSheet("sheet.png", sheetInfo:getSheet())
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

	spiderProp.body = display.newSprite( bodySheet, spd_movement )
	spiderProp.body:scale(.23,.23)
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
