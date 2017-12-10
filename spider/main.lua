-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local mainScreenBoundaryX = 615
local totalWidth = 600
local totalHeight = 1066
local jsWidth = 800

local physics = require( "physics" )

local bg = display.newRect( totalHeight/2, totalWidth/2, totalHeight, totalWidth )
bg:setFillColor( 1, 1, 1 )

local HelpText ={
    '\n\n1. Meet Bumble Spider.\n\n' ..
		'2. Cut Legs.\n\n' ..
		'3. Reach the goal.\n\n' ..
		'3. Legs Fall off with time.\n\n',

    '\n\n1. No, You cannot cut legs while he is moving.\n\n',

    '\n\n1. Did you see the new colliders with grey boundaries? They are bouncy.\n\n' ..
		'2. Legs may fall in different orders in different levels.\n\n',

    '\n\n1. Meet Pizza Spider. He is stronger, his legs do not fall off. \n\n' ..
		'2. But you have to use up all his legs.\n\n',

    '\n\n1. Use the \'Spiral Bottle\' to rotate.\n\n' ..
		'2. Don\'t touch the glowing boundary.\n\n' ..
		'3. Competely cover the goal.',

    '\n\n1. This time, the web is alive :-P.\n\n',

    '',

    '\n\n1. Competely cover the goal. \n\n' ..
		'2. Use up all his legs.'
}
--leveltypes
local RaceAgainstTime = 0
local UseAllYourLegs = 1;

--goalTypes
local goalStatic = 0
local goalMoving = 1

--playerTypes
local playerNormal = 0
local playerPizza = 1

--colliderOrientation
local cHorizontal = 1
local cVertical = 2

--colliderBouncyNess
local cNonBouncy = 0
local cBouncy = 1

--colliderExplosiveNess
local cNonExplosive = 0
local cExplosive = 1

local Level ={}

Level[0] = {}
Level[0].levelType = RaceAgainstTime
Level[0].levelTitlePosition = 20

Level[0].goal = {}
Level[0].goal.type = goalStatic
Level[0].goal.y = 550
Level[0].goal.x = 550
Level[0].goal.distance = 20

Level[0].gPlayer = {}
Level[0].gPlayer.type = playerNormal
Level[0].gPlayer.x = 800
Level[0].gPlayer.y = 200
Level[0].gPlayer.nextleg = 0

Level[0].collider = {{10,400,260,270,cHorizontal,cNonBouncy,cNonExplosive}}

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


--drawHelpBorder()


local spider = display.newGroup()
spider.x = 300
spider.y = 300




local leg = {}
for i = 1,8 do
	leg[i] = display.newImageRect( "arrow.png", 70,70  )
	local angle = i * 45
	local radAngle = (angle + 315) * math.pi / 180
	local distance = 200
	spider:insert( leg[i] )	
	leg[i]:rotate (angle)
	leg[i]:translate (distance * math.cos(radAngle), distance * math.sin(radAngle))
	
	
end

local body = display.newImageRect( "body2.png", 200, 200 )
local scale = .7
spider:insert( body )
spider.xScale = scale
spider.yScale = scale

