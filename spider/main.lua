-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here




local physics = require( "physics" )
local drawFuncs = require("drawFuncs")
local commonProp = require("commonProp")

local totalWidth = commonProp.total.Width
local totalHeight = commonProp.total.Height

physics.start()
physics.setGravity( 0, 0)

local bg
drawFuncs.drawBackGround(bg, totalWidth, totalHeight) 

local eyeProp = {}
local eyes = {}
drawFuncs.drawEyes(eyes, eyeProp, totalWidth, totalHeight)

local borderProp = {}
borderProp.borderWidth = commonProp.border.Width
local borders = {}
drawFuncs.drawBorder(borders, totalWidth, totalHeight, borderProp, physics)

local colliderProp = {}
colliderProp.MyScale = commonProp.collider.MyScale
colliderProp.colliderHeight = commonProp.collider.Height
colliderProp.colliderWidth = commonProp.collider.Width
colliderProp.colliderGroupx = {100}
colliderProp.colliderGroupy = {300}
colliderProp.numColliders = {5}
local collider = {}
drawFuncs.drawCollider(collider, colliderProp, physics)




local spiderProp = {}
local spider = display.newGroup()
spider.x = 220
spider.y = 150
spiderProp.MyScale = commonProp.spider.MyScale
spiderProp.ArrowSize = commonProp.spider.ArrowSize
spiderProp.BodySize = commonProp.spider.BodySize
spiderProp.ArrowDistance = commonProp.spider.ArrowDistance
spiderProp.SpiderRadius = commonProp.spider.SpiderRadius
spiderProp.leg = {}
spiderProp.legSquare = {}
drawFuncs.drawSpider(spider, spiderProp, physics)

local goalProp = {}
goalProp.size = 100
goalProp.x = totalHeight - goalProp.size - 5
goalProp.y = totalWidth - goalProp.size - 5
local goal = {}
drawFuncs.drawGoal(goal, goalProp, physics)

local lastLegTouched = -1

local function pushLeg(event )	
	local leg = event.target.leg
	print("touched" .. event.target.leg.i)
	
	local vx, vy = spider:getLinearVelocity()

	if(vx == 0 and vy == 0 and leg.removeSelf ~= nil) then
		leg:removeSelf()
		lastLegTouched = event.target.leg.i
		local rx = 3 * math.cos(leg.radAngle)
		local ry = 3 * math.sin(leg.radAngle)
		if(math.abs(rx) < 0.5)then
			rx = 0
		end
		if(math.abs(ry) < 0.5)then
			ry = 0
		end
		print("applying velocity " ..  rx .. "," .. ry .. " x = " .. spider.x .. " y = " .. spider.y )
		spider:applyLinearImpulse( rx, ry, 0 , 0 )
		spider.angularVelocity = 0
	end
end

local function shiftSpider( event )
	spider.x = spider.x + spiderProp.leg[lastLegTouched].dirx
	spider.y = spider.y + spiderProp.leg[lastLegTouched].diry
end

for i = 1,8 do
	spiderProp.legSquare[i]:addEventListener( "tap", pushLeg )
end

local function spiderCollided( self, event )
	print("collided with " .. event.other.Name .. " x = " .. self.x .." y = " .. self.y)
	spider.angularVelocity = 0
    spider:setLinearVelocity(0,0)
	timer.performWithDelay( 50, shiftSpider )
end
 
spider.collision = spiderCollided
spider:addEventListener( "collision" )

local function distance(obj1, obj2)
	local term1 = (obj1.x - obj2.x) * (obj1.x - obj2.x)
	local term2 = (obj1.y - obj2.y) * (obj1.y - obj2.y)
	return math.sqrt(term1 + term2)
end

local function on_frame( event )
	goal[0].rotation = goal[0].rotation + .2
	if(distance(spider,goal[0]) < 50) then
		print("reached goal")
		goal[0]:setFillColor( 1, 1, 1, 0 )
	end
	--print("goal[0].x = " .. goal[0].x .. " spider.x = " .. spider.x)
end 

Runtime:addEventListener( "enterFrame", on_frame )

