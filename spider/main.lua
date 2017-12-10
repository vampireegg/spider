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

local bg = display.newImageRect( "bbg.png", totalHeight, totalWidth )
bg.x = totalHeight/2
bg.y = totalWidth/2
--bg:setFillColor( 1, 1, 1 )

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

local spiral = {}
for i = 1,10 do
	local x = math.random(0, totalHeight)
	local y = math.random(0, totalWidth)
	--spiral[i] = display.newImageRect( "spiral.png", 15,15  )
	--spiral[i].x = x
	--spiral[i].y = y
	--spiral[i]:setFillColor( 1, 1, 1, .7 )
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

local colliderSize = 100
local colliderWidth = 70
local colliderGroup = display.newGroup()
colliderGroup.x = 100
colliderGroup.y = 500
local collider = {}
local function drawCollider(n)
	for i = 1,n do
		collider[i] = display.newImageRect( "collider2.png", colliderSize,colliderSize  )
		collider[i].x = i * colliderWidth
		colliderGroup:insert(collider[i])
	end
end
drawCollider(4)

local leg = {}
for i = 1,8 do
	leg[i] = display.newImageRect( "arrow.png", 24,24  )
	leg[i].angle = i * 45
	leg[i].isBullet = true
	leg[i].radAngle = (leg[i].angle + 135) * math.pi / 180
	leg[i].exists = true
	leg[i].rotAngle = (leg[i].angle + 315) * math.pi / 180
	local distance = 105
	spider:insert( leg[i] )	
	
	leg[i].rotation = leg[i].angle
	leg[i]:translate (distance * math.cos(leg[i].rotAngle), distance * math.sin(leg[i].rotAngle))
	display.save( leg[i],{filename="cleg"..i..".png", baseDir="E:" } )
	
	
end

local body = display.newImageRect( "body2.png", 140, 140 )
spider:insert( body )
spider.isFixedRotation = true

local function pushLeg(event )
	local leg = event.target
	--local radAngle = leg.radAngle
	--leg.rotation = leg.angle
	--leg:setLinearVelocity( 50 * math.cos(leg.radAngle), 50 * math.sin(leg.radAngle))
	--leg:applyLinearImpulse( 5 * math.cos(leg.radAngle), 5 * math.sin(leg.radAngle), leg.x , leg.y )
	
	
	local vx, vy = spider:getLinearVelocity()
	if(vx == 0 and vy == 0)
	then
		leg:removeSelf()
		--spider:setLinearVelocity( 50 * math.cos(leg.radAngle), 50 * math.sin(leg.radAngle))
		spider:applyLinearImpulse( 3 * math.cos(leg.radAngle), 3 * math.sin(leg.radAngle), body.x , body.y )
		spider.angularVelocity = 0
	end
	
end

physics.start()
physics.setGravity( 0, 0)

--physics.addBody( body, "dynamic", {radius = 100} )
physics.addBody( spider, "dynamic", {radius = 90})

local colliderRectParams = { halfWidth=140, halfHeight=35, x=colliderGroup.x, y=colliderGroup.y, angle=0 }
physics.addBody( colliderGroup, "static", { friction=0, bounce=0} )

for i = 1,8 do
	--local offsetRectParams = { halfWidth=35, halfHeight=35, x=leg[i].x, y=leg[i].y, leg[i].angle }
	--physics.addBody( leg[i], "dynamic", { outline=leg[i] , bounce=0.4, density=3.0, friction=0.8} )
	--physics.addBody( leg[i], "dynamic" )
	leg[i]:addEventListener( "tap", pushLeg )
end

