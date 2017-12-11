
local M = {}
local function drawBorder(borders, totalWidth, totalHeight, borderWidth)
	borders[0] = display.newRect( borderWidth/2, totalWidth/2, borderWidth, totalWidth)
	borders[0]:setFillColor( 1, 1, 1, 0 )
	
	borders[1] = display.newRect( totalHeight - borderWidth/2,  totalWidth/2, borderWidth, totalWidth)
	borders[1]:setFillColor( 1, 1, 1, 0 )
	
	borders[2] = display.newRect( totalHeight/2, borderWidth/2, totalHeight, borderWidth)
	borders[2]:setFillColor( 1, 1, 1, 0 )

	borders[3] = display.newRect( totalHeight/2, totalWidth - borderWidth/2, totalHeight, borderWidth)
	borders[3]:setFillColor( 1, 1, 1, 0 )
end

M.drawBorder = drawBorder

local function drawBackGround(bg, totalWidth, totalHeight)
	bg = display.newImageRect( "bbg.png", totalHeight, totalWidth )
	bg.x = totalHeight/2
	bg.y = totalWidth/2
end

M.drawBackGround = drawBackGround

local function drawCollider(collider, numColliders, colliderWidth, colliderHeight, colliderGroupx, colliderGroupy)
	for i = 0,numColliders - 1 do
		collider[i] = display.newImageRect( "collider.png", colliderWidth,colliderHeight  )
		collider[i].x = colliderGroupx + i * colliderWidth
		collider[i].y = colliderGroupy
		collider[i].colliderRectParams = { halfWidth=colliderWidth/2, halfHeight=colliderHeight/2, x=colliderGroupx + collider[i].x , y=colliderGroupy + collider[i].y, angle=0 }
	end
end
M.drawCollider = drawCollider
 
return M
