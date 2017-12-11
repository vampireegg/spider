
local M = {}
local function drawBorder(borderWidth, borders, totalWidth, totalHeight)
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
 
return M
