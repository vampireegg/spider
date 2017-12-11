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

physics.start()
physics.setGravity( 0, 0)

local bg
drawFuncs.drawBackGround(bg, totalWidth, totalHeight) 

local borderProp = {}
borderProp.borderWidth = 2
local borders = {}
drawFuncs.drawBorder(borders, totalWidth, totalHeight, borderProp, physics)

local colliderProp = {}
colliderProp.colliderHeight = 35
colliderProp.colliderWidth = 70
colliderProp.colliderGroupx = 150
colliderProp.colliderGroupy = 400
colliderProp.numColliders = 5
local collider = {}
drawFuncs.drawCollider(collider, colliderProp, physics)


local spiderProp = {}
local spider = display.newGroup()
spider.x = 300
spider.y = 200
spiderProp.arrowsize = 24
spiderProp.bodysize = 140
spiderProp.arrowDistance = 105
spiderProp.spiderRadius = spiderProp.arrowDistance + spiderProp.arrowsize
spider.RectParams = { halfWidth = spiderProp.spiderRadius * .9, halfHeight = spiderProp.spiderRadius * .9, x=spider.x , y=spider.y, angle=0 }
spiderProp.leg = {}
drawFuncs.drawSpider(spider, spiderProp, physics)

local function pushLeg(event )
	local leg = event.target	
	local vx, vy = spider:getLinearVelocity()
	if(vx == 0 and vy == 0) then
		leg:removeSelf()
		--spider:setLinearVelocity( 50 * math.cos(leg.radAngle), 50 * math.sin(leg.radAngle))
		spider:applyLinearImpulse( 3 * math.cos(leg.radAngle), 3 * math.sin(leg.radAngle), spiderProp.body.x , spiderProp.body.y )
		spider.angularVelocity = 0
	end
end


for i = 1,8 do
	spiderProp.leg[i]:addEventListener( "tap", pushLeg )
end

