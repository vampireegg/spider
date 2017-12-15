-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here




local physics = require( "physics" )
local drawFuncs = require("drawFuncs")
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
 
 -- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )
local scene = composer.newScene()
physics.start()
physics.setGravity( 0, 0 )

local Level
local gameLoopTimer

local totalWidth
local totalHeight
local bgProp = {}
local bg = {}

local eyeProp = {}
local eyes = {}

local borderProp = {}
local borders = {}

local colliderProp = {}
local collider = {}

local spiderProp = {}
local spider = {}


local goalProp = {}
local goal = {}

local portalProp = {}
local portal = {}
local myTimers = {}

local lastLegTouched
local spiderReachedGoal
local legPhase
local legPhaseCounter
local needtoReload
local nextSpiderx
local nextSpidery
local SpiderPorting
local LastPortal
local LastPortalPair
local spiderMoveDirX
local spiderMoveDirY
local spiderPreCollisionDirX
local spiderPreCollisionDirY
local justCollided


local function pushLeg(event )	
	local leg = event.target.leg
	print("touched" .. event.target.leg.i)
	
	local vx, vy = spider[1]:getLinearVelocity()

	if(vx == 0 and vy == 0 and leg.exists == 1) then
		leg.exists = 0
		leg:setFillColor( 1, 1, 1, 0.1 )
		lastLegTouched = event.target.leg.i
		local rx = (spiderProp.SpiderRadius / 17.8) * math.cos(leg.radAngle)
		local ry = (spiderProp.SpiderRadius / 17.8) * math.sin(leg.radAngle)
		if(math.abs(rx) < 0.5)then
			rx = 0
		end
		if(math.abs(ry) < 0.5)then
			ry = 0
		end
		print("applying velocity " ..  rx .. "," .. ry .. " x = " .. spider[1].x .. " y = " .. spider[1].y )
		if(rx == 0) then
			spiderPreCollisionDirX = 0
		else
			spiderPreCollisionDirX = -rx / math.abs(rx)
		end
		if(ry == 0) then
			spiderPreCollisionDirY = 0
		else
			spiderPreCollisionDirY = -ry / math.abs(ry)
		end
		spider[1]:applyLinearImpulse( rx, ry, 0 , 0 )
		spider[1].angularVelocity = 0
	end
end

local function endGame()

    for k, v in pairs(myTimers) do
        timer.cancel(v)
    end

	display.remove( bg[1] )
	display.remove( spider[1] )
	display.remove( goal[1] )
	for i = 1, 16 do
		display.remove( eyes[i] )
	end
	for i = 1, 4 do
		display.remove( borders[i] )
	end
	for i = 1,#(colliderProp.numColliders) do
		for j = 1, colliderProp.numColliders[i] do
			display.remove(collider[i][j])
		end
	end
	if(portalProp.Exists == 1) then
		for i = 1,#(portalProp.Types) do
			for j = 1, 2 do
				display.remove(portal[i][j])
			end
		end
	end
	display.remove(sceneGroup)
    local options = 
	{
		effect = "crossfade",
		time = 800
	}
	 
	-- Go to the menu screen
	composer.gotoScene( "level" )
end

local function shiftSpiderByOne()
	spider[1].x = spider[1].x + spiderPreCollisionDirX
	spider[1].y = spider[1].y + spiderPreCollisionDirY
end

local function shiftSpiderByInDir()
	spider[1].x = spider[1].x + spiderMoveDirX * spiderProp.leg[lastLegTouched].dirx
	spider[1].y = spider[1].y + spiderMoveDirY * spiderProp.leg[lastLegTouched].diry
end

local function resetJustCollided( event )
	justCollided = false
end

local function shiftSpider( event )
	print("shiftSpider called")
	shiftSpiderByOne()
	myTimers[#myTimers+1] = timer.performWithDelay( 100, resetJustCollided )
end

local function moveSpiderInDirection()
	print("spiderProp.leg[lastLegTouched].dirx = " .. spiderProp.leg[lastLegTouched].dirx .. " spiderProp.leg[lastLegTouched].diry = " .. spiderProp.leg[lastLegTouched].diry)
	print("spiderPreCollisionDirX = " .. spiderPreCollisionDirX .. " spiderPreCollisionDirY = " .. spiderPreCollisionDirY)
	local rx = spiderMoveDirX * (spiderProp.SpiderRadius / 17.8) * spiderPreCollisionDirX
	local ry = spiderMoveDirY * (spiderProp.SpiderRadius / 17.8) * spiderPreCollisionDirY
	if(rx == 0) then
		spiderPreCollisionDirX = 0
	else
		spiderPreCollisionDirX = -rx / math.abs(rx)
	end
	if(ry == 0) then
		spiderPreCollisionDirY = 0
	else
		spiderPreCollisionDirY = -ry / math.abs(ry)
	end
	spider[1]:applyLinearImpulse( rx, ry, 0 , 0 )
	spider[1].angularVelocity = 0
	myTimers[#myTimers+1] = timer.performWithDelay( 100, resetJustCollided )
end

local function callSpiderInDirection( event )
	moveSpiderInDirection()
end

local function bounceSpider( event )
	shiftSpiderByOne()
	myTimers[#myTimers+1] = timer.performWithDelay( 50, callSpiderInDirection )
end




local function spiderCollided( self, event )
	print("collided with " .. event.other.Name .. " x = " .. self.x .." y = " .. self.y .. " CommonName = " .. event.other.CommonName)
	if(justCollided == false) then
		print("Inside collided with " .. event.other.Name .. " x = " .. self.x .." y = " .. self.y .. " CommonName = " .. event.other.CommonName)
		justCollided = true
		spider[1].angularVelocity = 0
		spider[1]:setLinearVelocity(0,0)
		if(event.other.CommonName ~= "bouncer") then
			myTimers[#myTimers+1] = timer.performWithDelay( 50, shiftSpider )
		else
			if(event.other.Orientation == 1) then
				spiderMoveDirX = 1
				spiderMoveDirY = -1
			else
				spiderMoveDirX = -1
				spiderMoveDirY = 1
			end
			
			myTimers[#myTimers+1] = timer.performWithDelay( 50, bounceSpider )
		end
	end
end
 

local function distance(obj1, obj2)
	local term1 = (obj1.x - obj2.x) * (obj1.x - obj2.x)
	local term2 = (obj1.y - obj2.y) * (obj1.y - obj2.y)
	return math.sqrt(term1 + term2)
end



local function moveSpider( event )
	spiderMoveDirX = -1
	spiderMoveDirY = -1
	moveSpiderInDirection()
	SpiderPorting = 0
end

local function portSpider( event )
	spider[1].x = nextSpiderx
	spider[1].y = nextSpidery
	myTimers[#myTimers+1] = timer.performWithDelay( 50, moveSpider )
end

local function on_frame( event )
	if(distance(spider[1], bgProp.reLoadButton) < spiderProp.SpiderRadius * 1.22
	or distance(spider[1], bgProp.crossButton) < spiderProp.SpiderRadius) then
		bgProp.reLoadButton:setFillColor( 1, 1, 1, 0 )
		bgProp.crossButton:setFillColor( 1, 1, 1, 0 )
	else
		bgProp.reLoadButton:setFillColor( 1, 1, 1, 1 )
		bgProp.crossButton:setFillColor( 1, 1, 1, 1 )
	end
	goal[1].rotation = goal[1].rotation + .2
	
	if (portalProp.Exists == 1) then
		for i = 1,#(portalProp.Types) do
			for j = 1, 2 do
				portal[i][j].rotation = portal[i][j].rotation  + 5
				--print("distance = " .. distance(spider[1], portal[i][j]) .. " i  = " .. i .. " j = " .. j .. " sensitive = " .. portal[i][j].sensitive)
				if(distance(spider[1], portal[i][j]) <= spiderProp.SpiderRadius / 4.48 and portal[i][j].sensitive == 1) then
					nextSpiderx = portal[i][j].pair.x
					nextSpidery = portal[i][j].pair.y
					portal[i][j].sensitive = 0
					portal[i][j].pair.sensitive = 0
					LastPortal = portal[i][j]
					LastPortalPair = LastPortal.pair
					SpiderPorting = 1
					myTimers[#myTimers+1] = timer.performWithDelay( 50, portSpider )
				end
			end
		end
	end
	if(LastPortal ~= nil and SpiderPorting == 0) then
		if(distance(spider[1], LastPortal) > spiderProp.SpiderRadius / 4.48) then
			LastPortal.sensitive = 1
		end
	end
	if(LastPortalPair ~= nil and SpiderPorting == 0) then
		if(distance(spider[1], LastPortalPair) > spiderProp.SpiderRadius / 4.48) then
			LastPortalPair.sensitive = 1
		end
	end
	if(distance(spider[1],goal[1]) < spiderProp.SpiderRadius / 4.48 and spiderReachedGoal == false) then
		print("reached goal")
		goal[1]:setFillColor( 1, 1, 1, 0 )
		spiderReachedGoal = true
		Runtime:removeEventListener( "enterFrame", on_frame )
		if(Level < #levelProp) then
			composer.setVariable( "level", Level + 1 )
		else
			composer.setVariable( "level", 1 )
		end
		myTimers[#myTimers+1] = timer.performWithDelay( 1000, endGame )
		
	end
	if(needtoReload == true) then
		local vx, vy = spider[1]:getLinearVelocity()
		if(vx == 0 and vy == 0) then
			Runtime:removeEventListener( "enterFrame", on_frame )
			myTimers[#myTimers+1] = timer.performWithDelay( 500, endGame )
		end
	end
	local vx, vy = spider[1]:getLinearVelocity()
	if(vx == 0 and vy == 0) then
	legPhaseCounter = legPhaseCounter + 1
		if(legPhaseCounter == 10) then
			for i = 1, 8 do
				if(spiderProp.leg[i].exists == 1)then
					if(legPhase == 1) then
						spiderProp.leg[i].x = spiderProp.leg[i].x + spiderProp.leg[i].dirx
						spiderProp.leg[i].y = spiderProp.leg[i].y + spiderProp.leg[i].diry
					else
						spiderProp.leg[i].x = spiderProp.leg[i].x - spiderProp.leg[i].dirx
						spiderProp.leg[i].y = spiderProp.leg[i].y - spiderProp.leg[i].diry
					end
				end
			end
			legPhase = legPhase * -1
			legPhaseCounter = 0
		end
	end
end 

local function reLoad(event )
	needtoReload = true
end


function scene:create( event )
	Level = composer.getVariable("level")
	print("Level = " .. Level)
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	
	bgProp.Img = levelProp[Level].bg.Img
	bgProp.Opacity = levelProp[Level].bg.Opacity
	
	borderProp.borderWidth = commonProp.border.Width
	borderProp.CommonName = commonProp.border.CommonName
	
	eyeProp.Opacity = levelProp[Level].eye.Opacity
	
	colliderProp.MyScale = commonProp.collider.MyScale
	colliderProp.colliderHeight = commonProp.collider.Height
	colliderProp.colliderWidth = commonProp.collider.Width
	colliderProp.colliderGroupx = levelProp[Level].collider.GroupX
	colliderProp.colliderGroupy = levelProp[Level].collider.GroupY
	colliderProp.numColliders = levelProp[Level].collider.Num
	colliderProp.Orientation = levelProp[Level].collider.Orientation
	colliderProp.ColliderType = levelProp[Level].collider.ColliderType
	colliderProp.Img = commonProp.collider.Img
	colliderProp.CommonName = commonProp.collider.CommonName
	
	spiderProp.MyScale = levelProp[Level].spider.MyScale
	spiderProp.ArrowSize = 83.5 * spiderProp.MyScale
	spiderProp.BodySize = 487 * spiderProp.MyScale
	spiderProp.ArrowDistance = 365 * spiderProp.MyScale
	spiderProp.SpiderRadius = spiderProp.ArrowSize + spiderProp.ArrowDistance
	spiderProp.PosiX = levelProp[Level].spider.PosiX
	spiderProp.PosiY = levelProp[Level].spider.PosiY
	spiderProp.LegExists = levelProp[Level].spider.LegExists
	spiderProp.leg = {}
	spiderProp.legSquare = {}
	
	goalProp.Size = commonProp.goal.Size
	goalProp.x = levelProp[Level].goal.PosiX
	goalProp.y = levelProp[Level].goal.PosiY
	
	portalProp.Size = commonProp.portal.Size
	portalProp.Img = commonProp.portal.Img
	portalProp.Types = levelProp[Level].portal.Types
	portalProp.PosiX = levelProp[Level].portal.PosiX
	portalProp.PosiY = levelProp[Level].portal.PosiY
	portalProp.Exists = levelProp[Level].portal.Exists
	
	lastLegTouched = -1
	spiderReachedGoal = false
	legPhase = -1
	legPhaseCounter = 0
	needtoReload = false
	nextSpiderx = 0
	nextSpidery = 0
	SpiderPorting = 0
	LastPortal = nil
	LastPortalPair = nil
	spiderMoveDirX = 0
	spiderMoveDirY = 0
	spiderPreCollisionDirX = 0
	spiderPreCollisionDirY = 0
	justCollided = false
	
	physics.pause()
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	drawFuncs.drawBackGround(sceneGroup, bg, totalWidth, totalHeight, bgProp)
	drawFuncs.drawEyes(sceneGroup, eyes, eyeProp, totalWidth, totalHeight)
	drawFuncs.drawBorder(sceneGroup, borders, totalWidth, totalHeight, borderProp, physics)
	drawFuncs.drawCollider(sceneGroup, collider, colliderProp, physics)
	drawFuncs.drawPortals(sceneGroup, portal, portalProp)
	drawFuncs.drawSpider(sceneGroup, spider, spiderProp, physics)
	drawFuncs.drawGoal(sceneGroup, goal, goalProp, physics)	
	drawFuncs.drawButtons(sceneGroup, totalWidth, totalHeight, bgProp)

	for i = 1,8 do
			spiderProp.legSquare[i]:addEventListener( "tap", pushLeg )
	end
	bgProp.reLoadButton:addEventListener("tap", reLoad)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		print("show called")
		physics.start()
		
		Runtime:addEventListener( "enterFrame", on_frame )
		spider[1].collision = spiderCollided
		spider[1]:addEventListener( "collision" )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		physics.pause()
		composer.removeScene( "level" )

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene



