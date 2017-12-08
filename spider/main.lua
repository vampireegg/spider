-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local mainScreenBoundaryX = 615
local totalWidth = 1066
local totalHeight = 600
local jsWidth = 800

local function drawShadowedLine(x, y, x1, y1, height, color, gradient)
	local line1 = display.newLine( x,y, x1, y1)
	line1:setStrokeColor( color.r, color.g, color.b )
	line1.strokeWidth = 1
	
	local myRectangle = display.newRoundedRect( x, y, x1-x, height, height/2)
	myRectangle.strokeWidth = 1
	myRectangle:setFillColor( gradient )

end

local function drawHelpBorder()
	local gradient = 
	{
		type="gradient",
		color1={ 0, 0, 0 }, color2={ .6, .6, .6 }, direction="down"
	}
	local color =
	{
		r = 0,
		g = 0,
		b = 0
	}
	drawShadowedLine(625,75,785,75, 4, color, gradient)

end

--Draw the background
local line1 = display.newLine( mainScreenBoundaryX-3,0,mainScreenBoundaryX-3,totalHeight )
line1:setStrokeColor( 0, 0, 0 )
line1.strokeWidth = 1

local line1 = display.newLine( mainScreenBoundaryX,0,mainScreenBoundaryX,totalHeight )
line1:setStrokeColor( 0, 0, 0 )
line1.strokeWidth = 1

drawHelpBorder()

