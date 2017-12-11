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
local drawFuncs = require("drawFuncs")

local bg = display.newImageRect( "bbg.png", totalHeight, totalWidth )
bg.x = totalHeight/2
bg.y = totalWidth/2

local borderWidth = 2
local borders = {}
drawFuncs.drawBorder(borderWidth, borders, totalWidth, totalHeight)


local spider = display.newGroup()
spider.x = 300
spider.y = 200

local colliderHeight = 35
local colliderWidth = 70
--local colliderGroup = display.newGroup()
colliderGroupx = 150
colliderGroupy = 400
local collider = {}
local function drawCollider(n)
	for i = 0,n - 1 do
		collider[i] = display.newImageRect( "collider.png", colliderWidth,colliderHeight  )
		collider[i].x = colliderGroupx + i * colliderWidth
		collider[i].y = colliderGroupy
		--colliderGroup:insert(collider[i])
		collider[i].colliderRectParams = { halfWidth=colliderWidth/2, halfHeight=colliderHeight/2, x=colliderGroupx + collider[i].x , y=colliderGroupy + collider[i].y, angle=0 }
	end
	--colliderGroup.width = colliderWidth * n
end
drawCollider(5)
local arrowsize = 24
local bodysize = 140
local arrowDistance = 105
local spiderRadius = arrowDistance + arrowsize
local leg = {}
for i = 1,8 do
	leg[i] = display.newImageRect( "arrow.png", arrowsize,arrowsize  )
	leg[i].angle = i * 45
	leg[i].isBullet = true
	leg[i].radAngle = (leg[i].angle + 135) * math.pi / 180
	leg[i].exists = true
	leg[i].rotAngle = (leg[i].angle + 315) * math.pi / 180
	spider:insert( leg[i] )	
	
	leg[i].rotation = leg[i].angle
	leg[i]:translate (arrowDistance * math.cos(leg[i].rotAngle), arrowDistance * math.sin(leg[i].rotAngle))
	display.save( leg[i],{filename="cleg"..i..".png", baseDir="E:" } )
	
	
end

local body = display.newImageRect( "body2.png", bodysize, bodysize )
spider:insert( body )
spider.isFixedRotation = true

local function pushLeg(event )
	local leg = event.target
	--local radAngle = leg.radAngle
	--leg.rotation = leg.angle
	--leg:setLinearVelocity( 50 * math.cos(leg.radAngle), 50 * math.sin(leg.radAngle))
	--leg:applyLinearImpulse( 5 * math.cos(leg.radAngle), 5 * math.sin(leg.radAngle), leg.x , leg.y )
	
	
	local vx, vy = spider:getLinearVelocity()
	if(vx == 0 and vy == 0) then
		leg:removeSelf()
		--spider:setLinearVelocity( 50 * math.cos(leg.radAngle), 50 * math.sin(leg.radAngle))
		spider:applyLinearImpulse( 3 * math.cos(leg.radAngle), 3 * math.sin(leg.radAngle), body.x , body.y )
		spider.angularVelocity = 0
	end
	
end

spider.RectParams = { halfWidth=spiderRadius * .9, halfHeight=spiderRadius * .9, x=spider.x , y=spider.y, angle=0 }

physics.start()
physics.setGravity( 0, 0)

--physics.addBody( spider, "dynamic", { box = spider.RectParams})
physics.addBody( spider, "dynamic", {radius = spiderRadius * .9})

--local colliderRectParams = { halfWidth=140, halfHeight=35, x=colliderGroup.x, y=colliderGroup.y, angle=0 }
--physics.addBody( colliderGroup, "static", { friction=0, bounce=0} )
for i = 0,4 do
	physics.addBody( collider[i], "static", { friction=.5, bounce=0} )
end
for i = 0,3 do
	physics.addBody( borders[i], "static", { friction=0, bounce=0} )
end

for i = 1,8 do
	--local offsetRectParams = { halfWidth=35, halfHeight=35, x=leg[i].x, y=leg[i].y, leg[i].angle }
	--physics.addBody( leg[i], "dynamic", { outline=leg[i] , bounce=0.4, density=3.0, friction=0.8} )
	--physics.addBody( leg[i], "dynamic" )
	leg[i]:addEventListener( "tap", pushLeg )
end

