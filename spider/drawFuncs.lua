
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
	end
end

M.drawBorder = drawBorder

local function drawBackGround(bg, totalWidth, totalHeight)
	bg = display.newImageRect( "bbg.png", totalHeight, totalWidth )
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
		physics.addBody( collider[i], "static", { friction=.5, bounce=0} )
	end
end
M.drawCollider = drawCollider

local function drawSpider(spider, spiderProp)
	for i = 1,8 do
		spiderProp.leg[i] = display.newImageRect( "arrow.png", spiderProp.arrowsize,spiderProp.arrowsize  )
		spiderProp.leg[i].angle = i * 45
		spiderProp.leg[i].radAngle = (spiderProp.leg[i].angle + 135) * math.pi / 180
		spiderProp.leg[i].exists = true
		spiderProp.leg[i].rotAngle = (spiderProp.leg[i].angle + 315) * math.pi / 180
		spider:insert( spiderProp.leg[i] )	
		
		spiderProp.leg[i].rotation = spiderProp.leg[i].angle
		spiderProp.leg[i]:translate (spiderProp.arrowDistance * math.cos(spiderProp.leg[i].rotAngle), spiderProp.arrowDistance * math.sin(spiderProp.leg[i].rotAngle))
	end
	spiderProp.body = display.newImageRect( "body2.png", spiderProp.bodysize, spiderProp.bodysize )
	spider:insert( spiderProp.body )
	for i = 1,8 do
		print('spiderProp.leg[i].x' .. spiderProp.leg[i].x .. 'spiderProp.leg[i].y' .. spiderProp.leg[i].y)
		spiderProp.legSquare[i] = display.newRect( spider.x + spiderProp.leg[i].x, spider.y + spiderProp.leg[i].y, spiderProp.arrowsize * 5, spiderProp.arrowsize * 5)
		spiderProp.legSquare[i]:setFillColor( 1, 1, 1, 0 )
		spiderProp.legSquare[i].leg = spiderProp.leg[i]
		spiderProp.legSquare[i].isHitTestable = true
	end
	spider.isFixedRotation = true
	physics.addBody( spider, "dynamic", {radius = spiderProp.spiderRadius * .9})
end

M.drawSpider = drawSpider
 
return M
