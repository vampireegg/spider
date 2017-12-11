

local M = {}

local function pushLeg(event )
	local leg = event.target	
	local vx, vy = spider:getLinearVelocity()
	if(vx == 0 and vy == 0) then
		leg:removeSelf()
		spider:applyLinearImpulse( 3 * math.cos(leg.radAngle), 3 * math.sin(leg.radAngle), event.source.spiderProp.body.x , event.source.spiderProp.body.y )
		spider.angularVelocity = 0
	end	
end
M.pushLeg = pushLeg
return M