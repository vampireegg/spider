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

local lastLegTouched
local spiderReachedGoal



local function pushLeg(event )	
	local leg = event.target.leg
	print("touched" .. event.target.leg.i)
	
	local vx, vy = spider[1]:getLinearVelocity()

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
		print("applying velocity " ..  rx .. "," .. ry .. " x = " .. spider[1].x .. " y = " .. spider[1].y )
		spider[1]:applyLinearImpulse( rx, ry, 0 , 0 )
		spider[1].angularVelocity = 0
	end
end

local function shiftSpider( event )
	spider[1].x = spider[1].x + spiderProp.leg[lastLegTouched].dirx
	spider[1].y = spider[1].y + spiderProp.leg[lastLegTouched].diry
end



local function spiderCollided( self, event )
	print("collided with " .. event.other.Name .. " x = " .. self.x .." y = " .. self.y)
	spider[1].angularVelocity = 0
    spider[1]:setLinearVelocity(0,0)
	timer.performWithDelay( 50, shiftSpider )
end
 

local function distance(obj1, obj2)
	local term1 = (obj1.x - obj2.x) * (obj1.x - obj2.x)
	local term2 = (obj1.y - obj2.y) * (obj1.y - obj2.y)
	return math.sqrt(term1 + term2)
end

local function endGame()
	
	display.remove( spider[1] )
    local options = 
	{
		effect = "fade",
		time = 800
	}
	 
	-- Go to the menu screen
	composer.setVariable( "level", 2 )
	composer.gotoScene( "level" )
end

local function on_frame( event )
	goal[0].rotation = goal[0].rotation + .2
	if(distance(spider[1],goal[0]) < 20 and spiderReachedGoal == false) then
		print("reached goal")
		goal[0]:setFillColor( 1, 1, 1, 0 )
		spiderReachedGoal = true
		Runtime:removeEventListener( "enterFrame", on_frame )
		timer.performWithDelay( 2000, endGame )
	end
	--print("goal[0].x = " .. goal[0].x .. " spider[1].x = " .. spider[1].x)
end 


function scene:create( event )
	Level = composer.getVariable("level")
	print("Level = " .. Level)
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	borderProp.borderWidth = commonProp.border.Width
	
	colliderProp.MyScale = commonProp.collider.MyScale
	colliderProp.colliderHeight = commonProp.collider.Height
	colliderProp.colliderWidth = commonProp.collider.Width
	colliderProp.colliderGroupx = levelProp[Level].collider.GroupX
	colliderProp.colliderGroupy = levelProp[Level].collider.GroupY
	colliderProp.numColliders = levelProp[Level].collider.Num
	
	spiderProp.MyScale = commonProp.spider.MyScale
	spiderProp.ArrowSize = commonProp.spider.ArrowSize
	spiderProp.BodySize = commonProp.spider.BodySize
	spiderProp.ArrowDistance = commonProp.spider.ArrowDistance
	spiderProp.SpiderRadius = commonProp.spider.SpiderRadius
	spiderProp.PosiX = levelProp[Level].spider.PosiX
	spiderProp.PosiY = levelProp[Level].spider.PosiY
	spiderProp.leg = {}
	spiderProp.legSquare = {}
	
	goalProp.Size = commonProp.goal.Size
	goalProp.x = levelProp[Level].goal.PosiX
	goalProp.y = levelProp[Level].goal.PosiY
	
	lastLegTouched = -1
	spiderReachedGoal = false
	
	physics.pause()
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	drawFuncs.drawBackGround(sceneGroup, bg, totalWidth, totalHeight)
	drawFuncs.drawEyes(sceneGroup, eyes, eyeProp, totalWidth, totalHeight)
	drawFuncs.drawBorder(sceneGroup, borders, totalWidth, totalHeight, borderProp, physics)
	drawFuncs.drawCollider(sceneGroup, collider, colliderProp, physics)
	drawFuncs.drawSpider(sceneGroup, spider, spiderProp, physics)
	drawFuncs.drawGoal(sceneGroup, goal, goalProp, physics)

	for i = 1,8 do
			spiderProp.legSquare[i]:addEventListener( "tap", pushLeg )
	end
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



