-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- admob app id: ca-app-pub-3541871007849876~4925110585
-- admob ad unit id: ca-app-pub-3541871007849876/3951117876
--startapp ad id: 200202265


local physics = require( "physics" )
local drawFuncs = require("drawFuncs")
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local json = require( "json" )
local startapp = require( "plugin.startapp" )
 
 -- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )
local scene = composer.newScene()
physics.start()
physics.setGravity( 0, 0 )

local Level
local gameLoopTimer
local levelType

local totalWidth = {}
local totalHeight = {}


local bgProp = {}
local bg = {}

local reload_hereProp = {}
local reload_here = {}

local noti = {}
local notiProp = {}


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

local heartProp = {}
local heart = {}

local switchSystemProp = {}
local switchSystem = {}

local myTimers = {}
local lastCollidedWith = {}
local currentLegTapOrder = {}

local lastLegTouched
local spiderReachedGoal
local legPhase
local heartPhase
local legPhaseCounter
local heartPhaseCounter
local needtoReload
local needtoCross
local nextSpiderx
local nextSpidery
local SpiderPorting
local LastPortal
local LastPortalPair
local spiderMoveDirX
local spiderMoveDirY
local spiderPreCollisionDirX
local spiderPreCollisionDirY

local options
local filePath
local legTapCount
local legTappedOutOfOrder


local music = {}
local levelTable = {}


local function showAdd( event )
	if ( startapp.isLoaded( "interstitial" ) ) then
		startapp.show( "interstitial" )
	end
end

local function adListener( event )
	if ( event.phase == "init" ) then  -- Successful initialization
        print( event.provider )
		startapp.load( "interstitial" )
	elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
        print( event.type )
		
    elseif ( event.phase == "failed" ) then  -- The ad failed to load
        print( event.type )
        print( event.isError )
        print( event.response )
	elseif ( event.phase == "displayed" ) then  -- The ad was displayed/played
        print( event.type )
    elseif ( event.phase == "hidden" ) then  -- The ad was closed/hidden
        print( event.type )
    elseif ( event.phase == "clicked" ) then  -- The ad was clicked/tapped
        print( event.type )
    elseif ( event.phase == "reward" ) then  -- Rewarded video ad playback completed
        print( event.type )
    end
end

local function pushLeg(event )	
	local leg = event.target.leg
	print("touched" .. event.target.leg.i)
	
	local vx, vy = spider[1]:getLinearVelocity()

	if(vx == 0 and vy == 0 and leg.exists == 1) then
		--audio.stop(legMusicChannel)
		--legMusicChannel = audio.play( legMusic, { channel=4, loops=0, duration = 3000, fadeout=2000 } )
		leg.exists = 0
		leg:setFillColor( 1, 1, 1, 0.1 )
		lastLegTouched = event.target.leg.i
		local rx = (spiderProp.SpiderRadius / 23) * math.cos(leg.radAngle)
		local ry = (spiderProp.SpiderRadius / 23) * math.sin(leg.radAngle)
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
		lastCollidedWith.Name = ""
		legTapCount = legTapCount + 1
		if (Level == 1) then
			currentLegTapOrder[legTapCount] = leg.i
			if(currentLegTapOrder[legTapCount] ~= spiderProp.LegTapOrder[legTapCount]) then
				legTappedOutOfOrder = true
				bgProp.extra[3].ExtraImg:setFillColor (1,1,1, 1)
				bgProp.extra[1].ExtraImg:setFillColor (1,1,1, 0)
				bgProp.extra[2].ExtraImg:setFillColor (1,1,1, 0)
			else
				if((legTapCount == 1 or legTapCount == 2) and legTappedOutOfOrder == false) then
					bgProp.extra[legTapCount].ExtraImg:setFillColor (1,1,1, 0)
				end					
			end
		end
	end
	

end

local function endGame()
	audio.setVolume( 1/0.15, { channel=1 } )
	audio.stop(music.backgroundMusicChannel)
	music.backgroundMusicChannel = nil
	audio.dispose( music.backgroundMusicChannel )
    for k, v in pairs(myTimers) do
        timer.cancel(v)
    end
	
	display.remove(notiProp.rect)
	
	for i = 1, #notiProp.Img do
		display.remove(noti[i])
	end
	
	if (Level == 1) then
		for i = 1, #bgProp.extra do
			display.remove(bgProp.extra[i].ExtraImg)
		end
	end
	
	if(heartProp.Exists == 1) then
		for i = 1,#(heartProp.PosiX) do
			display.remove(heart[i])
		end
	end
	
	if(switchSystemProp.Exists == 1) then
		for i = 1,switchSystemProp.Num do
			display.remove(switchSystem.switch[i])
			for j = 1, 2 do
				for k = 1, switchSystemProp.window.Num[i][j] do
					display.remove(switchSystem.window[i][j][k])
				end
			end	
		end
	end
	display.remove(reload_here[1])
	display.remove(bgProp.reLoadButton)
	display.remove(bgProp.crossButton)
	display.remove(bgProp.reLoadButtonBox)
	display.remove(bgProp.crossButtonBox)
	display.remove( bg[1] )
	display.remove( spider[1] )
	display.remove( goal[1] )

	-- for i = 1, 16 do
		-- display.remove( eyes[i] )
	-- end
	if(levelType ~= 3) then
		for i = 1, 4 do
			display.remove( borders[i] )
		end
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

	local nextLevel = composer.getVariable("level")
	local maxCompletedLevel = composer.getVariable("max_completed_level")
	if(nextLevel > maxCompletedLevel) then
		maxCompletedLevel = nextLevel
	end
	composer.setVariable( "max_completed_level", maxCompletedLevel )
	
	levelTable[1] = maxCompletedLevel
	local file = io.open( filePath, "w" )
	if file then
		print("writing to file: " .. json.encode( levelTable ))
        file:write( json.encode( levelTable ) )
        io.close( file )
	else
		print("writing to file failed")
    end
	-- Go to the menu screen
	if(spiderReachedGoal == true) then
		print("going to dos_donts")
		composer.gotoScene( "dos_donts" , options)
	elseif(needtoCross == false) then
		print("going to level")
		composer.gotoScene( "level" , options)
	else
		composer.gotoScene( "select_level" , options)
	end
end

local function shiftSpiderByOne()
	spider[1].x = spider[1].x + spiderPreCollisionDirX
	spider[1].y = spider[1].y + spiderPreCollisionDirY
end

local function shiftSpiderByInDir()
	spider[1].x = spider[1].x + spiderMoveDirX * spiderProp.leg[lastLegTouched].dirx
	spider[1].y = spider[1].y + spiderMoveDirY * spiderProp.leg[lastLegTouched].diry
end


local function shiftSpider( event )
	print("shiftSpider called")
	shiftSpiderByOne()
end

local function moveSpiderInDirection()
	print("moveSpiderInDirection called")
	print("spiderProp.leg[lastLegTouched].dirx = " .. spiderProp.leg[lastLegTouched].dirx .. " spiderProp.leg[lastLegTouched].diry = " .. spiderProp.leg[lastLegTouched].diry)
	print("spiderPreCollisionDirX = " .. spiderPreCollisionDirX .. " spiderPreCollisionDirY = " .. spiderPreCollisionDirY)
	local rx = spiderMoveDirX * (spiderProp.SpiderRadius / 23) * spiderPreCollisionDirX
	local ry = spiderMoveDirY * (spiderProp.SpiderRadius / 23) * spiderPreCollisionDirY
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
	print("applyLinearImpulse rx = " .. rx .. " ry = " .. ry)
	spider[1]:applyLinearImpulse( rx, ry, 0 , 0 )
	spider[1].angularVelocity = 0
end

local function callSpiderInDirection( event )
	moveSpiderInDirection()
end

local function bounceSpider( event )
	print("bounceSpider called")
	shiftSpiderByOne()
	myTimers[#myTimers+1] = timer.performWithDelay( 50, callSpiderInDirection )
end




local function spiderCollided( self, event )
	print("collided with " .. event.other.Name .. " x = " .. self.x .." y = " .. self.y .. " CommonName = " .. event.other.CommonName .. " time = " .. system.getTimer())
	if(lastCollidedWith.Name ~= event.other.Name) then
		print("Inside collided with " .. event.other.Name .. " x = " .. self.x .." y = " .. self.y .. " CommonName = " .. event.other.CommonName)
		lastCollidedWith.Name = event.other.Name
		spider[1].angularVelocity = 0
		spider[1]:setLinearVelocity(0,0)
		if(event.other.CommonName ~= "bouncer") then
			--audio.stop(music.collideMusicChannel)
			music.collideMusicChannel = audio.play( music.collideMusic, { channel=3, loops=0, duration = 3000, fadeout=2000 } )
			myTimers[#myTimers+1] = timer.performWithDelay( 50, shiftSpider )
		else
			print("event.other.Orientation " .. event.other.Orientation)
			--audio.stop(music.bounceMusicChannel)
			music.bounceMusicChannel = audio.play( music.bounceMusic, { channel=6, loops=0, duration = 3000, fadeout=2000 } )
			if(event.other.Orientation == 1) then
				spiderMoveDirX = -1
				spiderMoveDirY = 1
			else
				spiderMoveDirX = 1
				spiderMoveDirY = -1
			end
			
			myTimers[#myTimers+1] = timer.performWithDelay( 50, bounceSpider )
		end
		
		if (Level == 1 and event.other.CommonName == "border" and legTappedOutOfOrder == false) then
			bgProp.extra[2].ExtraImg:setFillColor (1,1,1, 1)
			if(spiderReachedGoal == true) then
				bgProp.extra[1].ExtraImg:setFillColor (1,1,1, 0)
				bgProp.extra[2].ExtraImg:setFillColor (1,1,1, 0)
				bgProp.extra[3].ExtraImg:setFillColor (1,1,1, 0)
			end
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
	spider[1]:setLinearVelocity(0,0)
	if (music.portalMusicChannel ~= nil) then
		audio.stop(music.portalMusicChannel)
	end
	music.portalMusicChannel = audio.play( music.portalMusic, { channel=2, loops=0, duration = 3000, fadeout=2000 } )
	myTimers[#myTimers+1] = timer.performWithDelay( 50, moveSpider )
end

local function setNeedToReload(event)
	needtoReload = true
end

local function on_frame( event )
	if(spider[1].x > totalHeight[1] + spiderProp.SpiderRadius or spider[1].y > totalWidth[1] + spiderProp.SpiderRadius
	or spider[1].x < -spiderProp.SpiderRadius or spider[1].y < -spiderProp.SpiderRadius) then
		spider[1]:setLinearVelocity( 0, 0 )
		notiProp.rect:setFillColor( 0.3, 0.3, 0.3, 0.7)
		noti[2]:setFillColor( 1, 1, 1, 1)
		myTimers[#myTimers+1] = timer.performWithDelay( 1000, setNeedToReload )
	end
	if(distance(spider[1], bgProp.reLoadButton) < spiderProp.SpiderRadius
	or distance(spider[1], bgProp.crossButton) < spiderProp.SpiderRadius) then
		local legCount = 0
		for i = 1, 8 do
			if(spiderProp.leg[i].exists == 1) then
				legCount = legCount + 1
			end
		end
		if (legCount > 0) then
			bgProp.reLoadButton:setFillColor( 1, 1, 1, 0 )
			bgProp.crossButton:setFillColor( 1, 1, 1, 0 )
			bgProp.crossButtonBox.isHitTestable = false
		else
			bgProp.reLoadButton:setFillColor( 1, 1, 1, 1 )
			bgProp.crossButton:setFillColor( 1, 1, 1, 1 )
			bgProp.crossButtonBox.isHitTestable = true
		end
	else
		bgProp.reLoadButton:setFillColor( 1, 1, 1, 1 )
		bgProp.crossButton:setFillColor( 1, 1, 1, 1 )
		bgProp.crossButtonBox.isHitTestable = true
	end
	goal[1].rotation = goal[1].rotation + .2
	
	if(heartProp.Exists == 1) then
		heartPhaseCounter = heartPhaseCounter + 1
		if(heartPhaseCounter > 30) then
				heartPhaseCounter = 0
				heartPhase = heartPhase * -1				
		end
		
		if(heartPhase == -1) then
			heartProp.Scale = 0.99
		else
			heartProp.Scale = 1/0.99
		end
		--print("heartPhase = " .. heartPhase .. " heartProp.Scale = " .. heartProp.Scale)
		for i = 1,#(heartProp.PosiX) do
			heart[i]:scale(heartProp.Scale, heartProp.Scale)
			if(distance(spider[1], heart[i]) <= spiderProp.SpiderRadius / 2) then
				spiderProp.leg[lastLegTouched].exists = 1
				spiderProp.leg[lastLegTouched]:setFillColor( 1, 0, 1, 1 )
				music.heartMusicChannel = audio.play( music.heartMusic, { channel=7, loops=0, duration = 3000, fadeout=2000 } )
			end
		end
	end
	
	if(switchSystemProp.Exists == 1) then
		for i = 1,switchSystemProp.Num do
			if(distance(spider[1], switchSystem.switch[i]) <= spiderProp.SpiderRadius / 2 and switchSystem.switch[i].SpiderEntered == false) then
				print("spider near switch")
				music.windowMusicChannel = audio.play( music.windowMusic, { channel=8, loops=0, duration = 3000, fadeout=2000 } )
				switchSystem.switch[i].SpiderEntered = true
				switchSystem.switch[i]:scale(-1,1)
				for j = 1, 2 do
					if(switchSystemProp.window.CurState[i][j] == 0) then
						switchSystemProp.window.CurState[i][j] = 1
						for k = 1, switchSystemProp.window.Num[i][j] do
							physics.addBody( switchSystem.window[i][j][k], "static", { friction=0, bounce=0} )
							switchSystem.window[i][j][k]:setFillColor(switchSystemProp.Color[i][1], switchSystemProp.Color[i][2], switchSystemProp.Color[i][3], 1 )
						end
					else
						switchSystemProp.window.CurState[i][j] = 0
						for k = 1, switchSystemProp.window.Num[i][j] do
							physics.removeBody( switchSystem.window[i][j][k])
							switchSystem.window[i][j][k]:setFillColor(switchSystemProp.Color[i][1], switchSystemProp.Color[i][2], switchSystemProp.Color[i][3], 0.3 )
						end
					end
				end
			elseif (distance(spider[1], switchSystem.switch[i]) > spiderProp.SpiderRadius / 2) then
				switchSystem.switch[i].SpiderEntered = false
			end
		end
	end
	
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
					lastCollidedWith.Name = ""
					print("portal, lastCollidedWith.Name = " .. lastCollidedWith.Name)
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
		local goalFlag = false
		if(levelType ~=2) then
			goalFlag = true
		else
			local legCount = 0
			for i = 1, 8 do
				if(spiderProp.leg[i].exists == 1) then
					legCount = legCount + 1
				end
			end
			if(legCount == 0) then
				goalFlag = true
			else				
				goalFlag = false
				notiProp.rect:setFillColor( 0.3, 0.3, 0.3, 0.7)
				noti[1]:setFillColor( 1, 1, 1, 1)
				myTimers[#myTimers+1] = timer.performWithDelay( 1000, setNeedToReload )
			end
		end
		
		if(goalFlag == true) then
			music.goalMusicChannel = audio.play( music.goalMusic, { channel=5, loops=0, duration = 3000, fadeout=2000 } )
			goal[1]:setFillColor( 1, 1, 1, 0 )
			
			Runtime:removeEventListener( "enterFrame", on_frame )
			if(Level < #levelProp) then
				composer.setVariable( "level", Level + 1 )
			else
				composer.setVariable( "level", 1 )
			end
			spiderReachedGoal = true
			myTimers[#myTimers+1] = timer.performWithDelay( 100, endGame )
		end		
	end
	if(needtoReload == true or needtoCross == true) then
		--local vx, vy = spider[1]:getLinearVelocity()
		--if(vx == 0 and vy == 0) then
			Runtime:removeEventListener( "enterFrame", on_frame )
			myTimers[#myTimers+1] = timer.performWithDelay( 500, endGame )
		--end
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

local function cross(event )
	needtoCross = true
end


function scene:create( event )
	Level = composer.getVariable("level")
	print("Level = " .. Level)
	startapp.init( adListener, { appId="200202265", enableReturnAds = true } )
	
	totalWidth[1] = commonProp.total.Width
	totalHeight[1] = commonProp.total.Height
	
	levelType = levelProp[Level].levelType
	
	bgProp.Img = levelProp[Level].bg.Img
	bgProp.Opacity = levelProp[Level].bg.Opacity
	bgProp.ExtraImgExists = levelProp[Level].bg.ExtraImgExists
	bgProp.ExtraImg = levelProp[Level].bg.ExtraImg
	bgProp.ExtraImgX = levelProp[Level].bg.ExtraImgX
	bgProp.ExtraImgY = levelProp[Level].bg.ExtraImgY
	bgProp.ExtraImgWidth = levelProp[Level].bg.ExtraImgWidth
	bgProp.ExtraImgHeight = levelProp[Level].bg.ExtraImgHeight
	bgProp.ExtraImgScale = levelProp[Level].bg.ExtraImgScale
	bgProp.ExtraImgOpacity = levelProp[Level].bg.ExtraImgOpacity
	
	reload_hereProp.Img = commonProp.reload_here.Img
	reload_hereProp.PosiX = commonProp.reload_here.PosiX
	reload_hereProp.PosiY = commonProp.reload_here.PosiY
	reload_hereProp.Width = commonProp.reload_here.Width
	reload_hereProp.Height = commonProp.reload_here.Height
	reload_hereProp.Scale = commonProp.reload_here.Scale
	reload_hereProp.Opacity = 0
	
	
	
	borderProp.borderWidth = commonProp.border.Width
	borderProp.CommonName = commonProp.border.CommonName
	
	-- eyeProp.Opacity = levelProp[Level].eye.Opacity
	
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
	spiderProp.LegTapOrder = levelProp[Level].spider.LegTapOrder
	spiderProp.LegImg = "arrow.png"
	spiderProp.leg = {}
	spiderProp.legSquare = {}
	
	goalProp.Size = commonProp.goal.Size
	goalProp.x = levelProp[Level].goal.PosiX
	goalProp.y = levelProp[Level].goal.PosiY
	
	notiProp.Img = commonProp.noti.Img
	notiProp.PosiX = commonProp.noti.PosiX
	notiProp.PosiY = commonProp.noti.PosiY
	notiProp.Width = commonProp.noti.Width
	notiProp.Height = commonProp.noti.Height
	notiProp.Scale = commonProp.noti.Scale
	notiProp.Opacity = commonProp.noti.Opacity
	notiProp.RectOpacity = commonProp.noti.RectOpacity
	
	portalProp.Size = commonProp.portal.Size
	portalProp.Img = commonProp.portal.Img
	portalProp.Types = levelProp[Level].portal.Types
	portalProp.PosiX = levelProp[Level].portal.PosiX
	portalProp.PosiY = levelProp[Level].portal.PosiY
	portalProp.Exists = levelProp[Level].portal.Exists
	
	heartProp.Size = commonProp.heart.Size
	heartProp.Img = commonProp.heart.Img
	if(levelProp[Level].heartExists == 1) then
		heartProp.PosiX = levelProp[Level].heart.PosiX
		heartProp.PosiY = levelProp[Level].heart.PosiY
		heartProp.Exists = 1
		heartProp.Scale = 1
	else
		heartProp.Exists = 0
	end
	
	if(levelProp[Level].switchSystemExists == 1) then
		switchSystemProp.Exists = 1
		switchSystemProp.Color = levelProp[Level].switchSystem.Color
		switchSystemProp.Num = levelProp[Level].switchSystem.Num
		switchSystemProp.switch = {}
		switchSystemProp.switch.Img = commonProp.switchSystem.switch.Img
		switchSystemProp.switch.Width = commonProp.switchSystem.switch.Width
		switchSystemProp.switch.Height = commonProp.switchSystem.switch.Height
		switchSystemProp.switch.Scale = commonProp.switchSystem.switch.Scale
		switchSystemProp.switch.PosiX = levelProp[Level].switchSystem.switch.PosiX
		switchSystemProp.switch.PosiY = levelProp[Level].switchSystem.switch.PosiY
		
		switchSystemProp.window = {}
		switchSystemProp.window.Img = commonProp.switchSystem.window.Img
		switchSystemProp.window.Width = commonProp.switchSystem.window.Width
		switchSystemProp.window.Height = commonProp.switchSystem.window.Height
		switchSystemProp.window.Scale = commonProp.switchSystem.window.Scale
		switchSystemProp.window.PosiX = levelProp[Level].switchSystem.window.PosiX
		switchSystemProp.window.PosiY = levelProp[Level].switchSystem.window.PosiY
		switchSystemProp.window.Num = levelProp[Level].switchSystem.window.Num
		switchSystemProp.window.State = levelProp[Level].switchSystem.window.State
		switchSystemProp.window.Orientation = levelProp[Level].switchSystem.window.Orientation
		
		switchSystem.switch = {}
		switchSystem.window = {}
	else
		switchSystemProp.Exists = 0
	end
	
	music.backgroundMusic = audio.loadStream( "jungle.mp3" )
	music.portalMusic = audio.loadStream( "beam.mp3" )
	music.collideMusic = audio.loadStream( "thud.mp3" )
	--legMusic = audio.loadStream( "kick.mp3" )
	music.goalMusic = audio.loadStream( "tada.mp3" )
	music.bounceMusic = audio.loadStream( "spin.mp3" )
	music.heartMusic = audio.loadStream( "magic.mp3" )
	music.windowMusic = audio.loadStream( "door.mp3" )
	
		
	-- Play the background music on channel 1, loop infinitely, and fade in over 5 seconds 
	music.backgroundMusicChannel = audio.play( music.backgroundMusic, { channel=1, loops=-1, fadein=5000 } )
	audio.setVolume( 0.15, { channel=1 } )
	
	lastLegTouched = -1
	spiderReachedGoal = false
	legPhase = -1
	heartPhase = -1
	legPhaseCounter = 0
	heartPhaseCounter = 0
	needtoReload = false
	needtoCross= false
	nextSpiderx = 0
	nextSpidery = 0
	SpiderPorting = 0
	LastPortal = nil
	LastPortalPair = nil
	spiderMoveDirX = 0
	spiderMoveDirY = 0
	spiderPreCollisionDirX = 0
	spiderPreCollisionDirY = 0
	lastCollidedWith.Name = ""
	legTapCount = 0
	legTappedOutOfOrder = false
	filePath = system.pathForFile( "level.json", system.DocumentsDirectory )
	options = 
	{
		effect = "fade",
		time = 800
	}
	
	physics.pause()
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	drawFuncs.drawBackGround(sceneGroup, bg, totalWidth[1], totalHeight[1], bgProp)
	--drawFuncs.drawEyes(sceneGroup, eyes, eyeProp, totalWidth, totalHeight)
	if(levelType ~= 3) then
		drawFuncs.drawBorder(sceneGroup, borders, totalWidth[1], totalHeight[1], borderProp, physics)
	end
	drawFuncs.drawCollider(sceneGroup, collider, colliderProp, physics)
	drawFuncs.drawPortals(sceneGroup, portal, portalProp)
	if(levelProp[Level].heartExists == 1) then
		drawFuncs.drawHearts(sceneGroup, heart, heartProp)
	end
	
	drawFuncs.drawSpider(sceneGroup, spider, spiderProp, physics, 1)
	drawFuncs.drawGoal(sceneGroup, goal, goalProp, physics)	
	drawFuncs.drawButtons(sceneGroup, totalWidth[1], totalHeight[1], bgProp)
	drawFuncs.drawReloadHere(sceneGroup, reload_here, reload_hereProp)
	drawFuncs.drawNotiFication(sceneGroup, noti, notiProp, totalWidth[1], totalHeight[1])
	
	if(levelProp[Level].switchSystemExists == 1) then
		drawFuncs.drawSwitchSystem(sceneGroup, switchSystem, switchSystemProp, physics)
	end

	for i = 1,8 do
			spiderProp.legSquare[i]:addEventListener( "tap", pushLeg )
	end
	
	
	bgProp.reLoadButton:addEventListener("tap", reLoad)
	bgProp.reLoadButtonBox:addEventListener("tap", reLoad)
	bgProp.crossButton:addEventListener("tap", cross)
	bgProp.crossButtonBox:addEventListener("tap", cross)
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
		myTimers[#myTimers+1] = timer.performWithDelay( 300, showAdd )
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



