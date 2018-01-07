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
local sceneGroup

local scoreTable = {}
local progressTable = {}
local currentProgressTable = {}
local timeTable = {}

local totalWidth = {}
local totalHeight = {}


local bgProp = {}
local bg = {}

local nextMoveProp = {}
local nextMove = {}

local scoreboardProp = {}
local scoreboard = {}

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

local moveMarketProp = {}

local heartProp = {}
local heart = {}

local switchSystemProp = {}
local switchSystem = {}

local myTimers = {}
local lastCollidedWith = {}
local currentLegTapOrder = {}

local control = {}


local music = {}
local levelTable = {}


local function showAdd()
	if ( startapp.isLoaded( "interstitial" ) ) then
		startapp.show( "interstitial" )
	end
end


local function pushLeg(event )
	if(event.target == nil) then
		return
	end
	if(spider[1] == nil) then
		return
	end
	if(control.spiderReachedGoal == true) then
		return
	end
	local leg = event.target.leg
	print("touched" .. event.target.leg.i)
	
	local vx, vy = spider[1]:getLinearVelocity()

	if(vx == 0 and vy == 0 and leg.exists == 1 and control.show_1st_move == 0) then
		--audio.stop(legMusicChannel)
		--legMusicChannel = audio.play( legMusic, { channel=4, loops=0, duration = 3000, fadeout=2000 } )
		if(control.infiniteLegs == false) then
			leg.exists = 0
			leg:setFillColor( 1, 1, 1, 0.1 )
		end
		control.lastLegTouched = event.target.leg.i
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
			control.spiderPreCollisionDirX = 0
		else
			control.spiderPreCollisionDirX = -rx / math.abs(rx)
		end
		if(ry == 0) then
			control.spiderPreCollisionDirY = 0
		else
			control.spiderPreCollisionDirY = -ry / math.abs(ry)
		end
		spider[1]:applyLinearImpulse( rx, ry, 0 , 0 )
		spider[1].angularVelocity = 0
		lastCollidedWith.Name = ""
		control.legTapCount = control.legTapCount + 1
		currentLegTapOrder[control.legTapCount] = leg.i
		if (Level == 1) then
			if(currentLegTapOrder[control.legTapCount] ~= spiderProp.LegTapOrder[control.legTapCount]) then
				control.legTappedOutOfOrder = true
				bgProp.extra[3].ExtraImg:setFillColor (1,1,1, 1)
				bgProp.extra[1].ExtraImg:setFillColor (1,1,1, 0)
				bgProp.extra[2].ExtraImg:setFillColor (1,1,1, 0)
			else
				if((control.legTapCount == 1 or control.legTapCount == 2) and control.legTappedOutOfOrder == false) then
					bgProp.extra[control.legTapCount].ExtraImg:setFillColor (1,1,1, 0)
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
	
	if(control.spiderReachedGoal == true) then
		for i = 1, #scoreboard.scoreText do
			display.remove(scoreboard.scoreText[i])
		end
		-- for i = 1, #scoreboard.img do
			-- display.remove(scoreboard.img[i])
		-- end
		-- display.remove(scoreboard.line)
	end
	
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
	if(control.nextMoveExists == true) then
		display.remove(nextMove[1].txt)
		display.remove(nextMove[1].txt2)
		display.remove(nextMove[1].img)
		display.remove(nextMove[1])
	end
	display.remove(bgProp.reLoadButton)
	display.remove(bgProp.crossButton)
	display.remove(bgProp.reLoadButtonBox)
	display.remove(bgProp.crossButtonBox)
	display.remove( bg[1] )
	if(spider[1] ~= nil) then
		display.remove( spider[1] )
	end
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
	local file = io.open( control.filePath, "w" )
	if file then
		print("writing to file: " .. json.encode( levelTable ))
        file:write( json.encode( levelTable ) )
        io.close( file )
	else
		print("writing to file failed")
    end
	-- Go to the menu screen
	if(control.spiderReachedGoal == true) then
		print("going to dos_donts")
		composer.gotoScene( "dos_donts" , control.screenTransitionOptions)
	elseif(control.needtoCross == false) then
		print("going to level")
		composer.gotoScene( "level" , control.screenTransitionOptions)
	else
		composer.gotoScene( "select_level" , control.screenTransitionOptions)
	end
end

local function shiftSpiderByOne()
	spider[1].x = spider[1].x + control.spiderPreCollisionDirX
	spider[1].y = spider[1].y + control.spiderPreCollisionDirY
end

local function shiftSpiderByInDir()
	spider[1].x = spider[1].x + control.spiderMoveDirX * spiderProp.leg[control.lastLegTouched].dirx
	spider[1].y = spider[1].y + control.spiderMoveDirY * spiderProp.leg[control.lastLegTouched].diry
end


local function shiftSpider( event )
	print("shiftSpider called")
	shiftSpiderByOne()
end

local function moveSpiderInDirection()
	print("moveSpiderInDirection called")
	print("spiderProp.leg[control.lastLegTouched].dirx = " .. spiderProp.leg[control.lastLegTouched].dirx .. " spiderProp.leg[control.lastLegTouched].diry = " .. spiderProp.leg[control.lastLegTouched].diry)
	print("control.spiderPreCollisionDirX = " .. control.spiderPreCollisionDirX .. " control.spiderPreCollisionDirY = " .. control.spiderPreCollisionDirY)
	local rx = control.spiderMoveDirX * (spiderProp.SpiderRadius / 23) * control.spiderPreCollisionDirX
	local ry = control.spiderMoveDirY * (spiderProp.SpiderRadius / 23) * control.spiderPreCollisionDirY
	if(rx == 0) then
		control.spiderPreCollisionDirX = 0
	else
		control.spiderPreCollisionDirX = -rx / math.abs(rx)
	end
	if(ry == 0) then
		control.spiderPreCollisionDirY = 0
	else
		control.spiderPreCollisionDirY = -ry / math.abs(ry)
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
				control.spiderMoveDirX = -1
				control.spiderMoveDirY = 1
			else
				control.spiderMoveDirX = 1
				control.spiderMoveDirY = -1
			end
			
			myTimers[#myTimers+1] = timer.performWithDelay( 50, bounceSpider )
		end
		
		if (Level == 1 and event.other.CommonName == "border" and control.legTappedOutOfOrder == false) then
			bgProp.extra[2].ExtraImg:setFillColor (1,1,1, 1)
			if(control.spiderReachedGoal == true) then
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
	control.spiderMoveDirX = -1
	control.spiderMoveDirY = -1
	moveSpiderInDirection()
	control.SpiderPorting = 0
end

local function portSpider( event )
	spider[1].x = control.nextSpiderx
	spider[1].y = control.nextSpidery
	spider[1]:setLinearVelocity(0,0)
	if (music.portalMusicChannel ~= nil) then
		audio.stop(music.portalMusicChannel)
	end
	music.portalMusicChannel = audio.play( music.portalMusic, { channel=2, loops=0, duration = 3000, fadeout=2000 } )
	myTimers[#myTimers+1] = timer.performWithDelay( 50, moveSpider )
end

local function setNeedToReload(event)
	control.needtoReload = true
end

local function showNotiAndReload(num)
	notiProp.rect:setFillColor( 0.3, 0.3, 0.3, 0.7)
	noti[num]:setFillColor( 1, 1, 1, 1)
	myTimers[#myTimers+1] = timer.performWithDelay( 1000, setNeedToReload )
end

local function readFileIntoTable(filename)
	local path = system.pathForFile( filename, system.DocumentsDirectory )
	local file = io.open(path, "r" )
	if file then
		local contents = file:read( "*a" )
		io.close( file )
		local tablename = json.decode( contents )
		return tablename
	end
end

local function writeTableIntoFile(filename, tablename)
	local path = system.pathForFile( filename, system.DocumentsDirectory )
	local file = io.open( path, "w" )
	if file then
		--print("writing to file: " .. json.encode( tablename, { indent=true } ))
        file:write( json.encode( tablename ) )
        io.close( file )
	else
		print("writing to file failed")
    end
end

local function hideAll()
	--display.remove( spider[1] )
end

local function showScore()
	scoreTable = readFileIntoTable("score.json")
	
	if(timeTable["L" ..  Level].Completed == false) then
		timeTable["L" ..  Level].SpentTime = control.PrevSpentTime + os.difftime( os.time(), control.startingTime )
		timeTable["L" ..  Level].Completed = true
		writeTableIntoFile("time.json", timeTable)
	end
	timeTable = readFileIntoTable("time.json")
	if(timeTable == nil) then
		print("timeTable == nil")
		timeTable = {}
	end
	if(timeTable["L" ..  Level] == nil) then
		print("timeTable[\"L\" ..  Level] == nil")
		timeTable["L" ..  Level] = {}
		timeTable["L" ..  Level].SpentTime = control.PrevSpentTime + os.difftime( os.time(), control.startingTime )
		timeTable["L" ..  Level].Completed = true
	end
	
	control.LevelGold = levelProp[Level].goldMax
	control.LevelFreeMoves = levelProp[Level].freeMove
	control.LevelTime = levelProp[Level].goldMax * 1.1
	control.LevelMoves = #spiderProp.LegTapOrder
	
	control.CurrentUsedFreeMoves = control.UsedFreeMoves
	control.CurrentTime = timeTable["L" ..  Level].SpentTime
	control.CurrentMoves = #currentLegTapOrder
	

	if(scoreTable == nil) then
		print("scoreTable == nil")
		scoreTable = {}
	end
	if (scoreTable["L" ..  Level] == nil) then
		scoreTable["L" ..  Level] = {}
		
		control.JustCompletedLevel = true
		
		control.Score1stTime = 0
		control.Time1stTime = control.CurrentTime
		
		control.PrevScore = 0
		control.PrevGold = 0
		control.PrevFreeMoves = 0		
		control.PrevUsedFreeMoves = 0

	else
		control.JustCompletedLevel = false
		
		if(scoreTable["L" ..  Level].Score1stTime ~= nil) then
			control.Score1stTime = scoreTable["L" ..  Level].Score1stTime
		else
			control.Score1stTime = 0
		end
		
		if(scoreTable["L" ..  Level].Time1stTime ~= nil) then
			control.Time1stTime = scoreTable["L" ..  Level].Time1stTime
		else
			control.Time1stTime = 0
		end
		
		if(scoreTable["L" ..  Level].Score ~= nil) then
			control.PrevScore = scoreTable["L" ..  Level].Score
		else
			control.PrevScore = 0			
		end
		
		if(scoreTable["L" ..  Level].Gold ~= nil) then
			control.PrevGold = scoreTable["L" ..  Level].Gold
		else
			control.PrevGold = 0			
		end
		
		if(scoreTable["L" ..  Level].FreeMoves ~= nil) then
			control.PrevFreeMoves = scoreTable["L" ..  Level].FreeMoves
		else
			control.PrevFreeMoves = 0			
		end
		
		if(scoreTable["L" ..  Level].UsedFreeMoves ~= nil) then
			control.PrevUsedFreeMoves = scoreTable["L" ..  Level].UsedFreeMoves
		else
			control.PrevUsedFreeMoves = 0			
		end
	end
	
	print("control.PrevFreeMoves = " .. control.PrevFreeMoves) 
	
	
	local ScoreBasedOnMove = math.ceil(10 * control.LevelMoves / control.CurrentMoves) 
	local ScoreBasedOnTime
	if(control.Time1stTime < control.LevelTime) then
		ScoreBasedOnTime = 10
	else
		ScoreBasedOnTime = math.ceil(10 * control.LevelTime / control.Time1stTime)
	end
	control.CurrentUsedFreeMoves = control.CurrentUsedFreeMoves + control.PrevUsedFreeMoves
	local ScoreBasedOnFreeMoves = math.ceil(10 * control.CurrentUsedFreeMoves / control.LevelMoves)
	print("ScoreBasedOnMove = " .. ScoreBasedOnMove .. " ScoreBasedOnTime = " .. ScoreBasedOnTime .. " ScoreBasedOnFreeMoves = " .. ScoreBasedOnFreeMoves )
	control.CurrentScore = 0.4 * ScoreBasedOnMove + 0.6 *  ScoreBasedOnTime -  ScoreBasedOnFreeMoves
	control.CurrentScore = control.CurrentScore * control.LevelGold / 10
	if(control.CurrentScore < 0) then
		control.CurrentScore = 0
	end
	if(control.JustCompletedLevel == true) then
		control.Score1stTime = control.CurrentScore
	end
	
	control.CurrentGold = control.CurrentScore
	if(control.CurrentGold < control.PrevGold) then
		control.CurrentGold = control.PrevGold
	end
	control.EarnedGold = control.CurrentGold - control.PrevGold
	
	control.CurrentFreeMoves = control.LevelFreeMoves
	if(control.CurrentFreeMoves < 0) then
		control.CurrentFreeMoves = 0
	end
	if(control.CurrentFreeMoves < control.PrevFreeMoves) then
		control.CurrentFreeMoves = control.PrevFreeMoves
	end
	control.EarnedFreeMoves = control.CurrentFreeMoves - control.PrevFreeMoves
	
	
	
	--------------everything is ready in control, we need to insert them-------
	
	scoreTable["L" ..  Level].Score1stTime = control.Score1stTime
	scoreTable["L" ..  Level].Time1stTime = control.Time1stTime
	scoreTable["L" ..  Level].Score = control.CurrentScore
	scoreTable["L" ..  Level].Gold = control.CurrentGold
	scoreTable["L" ..  Level].FreeMoves = control.CurrentFreeMoves
	scoreTable["L" ..  Level].UsedFreeMoves = control.CurrentUsedFreeMoves
	

	control.totalGold = currentProgressTable.totalGold + control.EarnedGold
	control.totalFreeMove = currentProgressTable.totalFreeMove + control.EarnedFreeMoves
	
	
	
	progressTable.totalGold = control.totalGold
	progressTable.totalFreeMove = control.totalFreeMove
	
	scoreboardProp.UsedFreeMoves = control.CurrentUsedFreeMoves
	scoreboardProp.OptimalMoves = control.LevelMoves
	scoreboardProp.PlayerMoves = control.CurrentMoves
	scoreboardProp.SpentTime = control.Time1stTime
	scoreboardProp.Score = scoreTable["L" ..  Level].Score
	scoreboardProp.EarnedGold = control.EarnedGold
	scoreboardProp.EarnedFreeMoves = control.EarnedFreeMoves
	scoreboardProp.LevelGold = control.LevelGold
	scoreboardProp.StartPosiY = totalWidth[1]/2 - 200
	scoreboardProp.StartPosiX = totalHeight[1]/2
	scoreboardProp.rectColor = {levelProp[Level].dos_donts.Color[1] / 2.5, levelProp[Level].dos_donts.Color[2] / 2.8, levelProp[Level].dos_donts.Color[3] / 1.8, 1}
	scoreboardProp.rect = notiProp.rect
	
	hideAll()
	drawFuncs.drawScoreBoard(sceneGroup, scoreboard, scoreboardProp, totalWidth[1], totalHeight[1])
	
	
	writeTableIntoFile("score.json", scoreTable)
	writeTableIntoFile("progress.json", progressTable)
	
	notiProp.rect:addEventListener( "tap", endGame )
end

local function makeNextMoveVisible()
	local vx, vy = spider[1]:getLinearVelocity()
	if(control.nextMoveExists == true and control.spiderReachedGoal == false and currentProgressTable.totalFreeMove > 0) then
		nextMove[1].txt:setFillColor( 0.9, 0.9, 0.65, 1)
		nextMove[1].img:setFillColor(1, 1, 1, 1)
		nextMove[1].txt2.text =  currentProgressTable.totalFreeMove .. ""
		nextMove[1].txt2:setFillColor( 0.9, 0.9, 0.65, 1)
	end
	--control.MakingNextMoveVisible = false
end

local function makeNextMoveInVisible()
	if(control.nextMoveExists == true) then
		nextMove[1].txt:setFillColor( 0.9, 0.9, 0.65, 0)
		nextMove[1].img:setFillColor(1, 1, 1, 0)
		nextMove[1].txt2:setFillColor( 0.9, 0.9, 0.65, 0)
	end
end

local function on_frame( event )
	if(timeTable["L" ..  Level].Completed == false) then
		timeTable["L" ..  Level].SpentTime = control.PrevSpentTime + os.difftime( os.time(), control.startingTime )
		writeTableIntoFile("time.json", timeTable)
	end
	local vx, vy = spider[1]:getLinearVelocity()
	if(vx == 0 and vy == 0) then
		control.spiderStillCount = control.spiderStillCount + 1
	else
		control.spiderStillCount = 0
		control.nextMoveSensitive = 0 
	end
	if(control.spiderStillCount > 25) then
		control.nextMoveSensitive = 1
	end
	
	if(control.nextMoveExists == true and (currentProgressTable.totalGold >= control.moveCost o currentProgressTable.totalFreeMove ~= 0)) then
		makeNextMoveVisible()
	elseif(control.nextMoveExists == true) then
		makeNextMoveInVisible()
	end


	if(spider[1].x > totalHeight[1] + spiderProp.SpiderRadius or spider[1].y > totalWidth[1] + spiderProp.SpiderRadius
	or spider[1].x < -spiderProp.SpiderRadius or spider[1].y < -spiderProp.SpiderRadius) then
		spider[1]:setLinearVelocity( 0, 0 )
		showNotiAndReload(2)
	end
	
	if(distance(spider[1], bgProp.reLoadButton) < spiderProp.SpiderRadius * 1.2
	or distance(spider[1], bgProp.crossButton) < spiderProp.SpiderRadius * 1.2) then
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
		control.heartPhaseCounter = control.heartPhaseCounter + 1
		if(control.heartPhaseCounter > 30) then
				control.heartPhaseCounter = 0
				control.heartPhase = control.heartPhase * -1				
		end
		
		if(control.heartPhase == -1) then
			heartProp.Scale = 0.99
		else
			heartProp.Scale = 1/0.99
		end
		--print("control.heartPhase = " .. control.heartPhase .. " heartProp.Scale = " .. heartProp.Scale)
		for i = 1,#(heartProp.PosiX) do
			heart[i]:scale(heartProp.Scale, heartProp.Scale)
			if(distance(spider[1], heart[i]) <= spiderProp.SpiderRadius / 2) then
				spiderProp.leg[control.lastLegTouched].exists = 1
				spiderProp.leg[control.lastLegTouched]:setFillColor( 1, 0, 1, 1 )
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
							myTimers[#myTimers+1] = timer.performWithDelay( 200, function()
							physics.addBody( switchSystem.window[i][j][k], "static", { friction=0, bounce=0} )
							switchSystem.window[i][j][k]:setFillColor(switchSystemProp.Color[i][1], switchSystemProp.Color[i][2], switchSystemProp.Color[i][3], 1 )
							end)
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
					control.nextSpiderx = portal[i][j].pair.x
					control.nextSpidery = portal[i][j].pair.y
					portal[i][j].sensitive = 0
					portal[i][j].pair.sensitive = 0
					control.LastPortal = portal[i][j]
					control.LastPortalPair = control.LastPortal.pair
					lastCollidedWith.Name = ""
					print("portal, lastCollidedWith.Name = " .. lastCollidedWith.Name)
					control.SpiderPorting = 1
					myTimers[#myTimers+1] = timer.performWithDelay( 50, portSpider )
				end
			end
		end
	end
	if(control.LastPortal ~= nil and control.SpiderPorting == 0) then
		if(distance(spider[1], control.LastPortal) > spiderProp.SpiderRadius / 4.48) then
			control.LastPortal.sensitive = 1
		end
	end
	if(control.LastPortalPair ~= nil and control.SpiderPorting == 0) then
		if(distance(spider[1], control.LastPortalPair) > spiderProp.SpiderRadius / 4.48) then
			control.LastPortalPair.sensitive = 1
		end
	end
	if(distance(spider[1],goal[1]) < spiderProp.SpiderRadius / 4.48 and control.spiderReachedGoal == false) then
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
				showNotiAndReload(1)
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
			control.spiderReachedGoal = true
			showScore()
			--myTimers[#myTimers+1] = timer.performWithDelay( 100, endGame )
		end		
	end
	if(control.needtoReload == true or control.needtoCross == true) then
		--local vx, vy = spider[1]:getLinearVelocity()
		--if(vx == 0 and vy == 0) then
			Runtime:removeEventListener( "enterFrame", on_frame )
			myTimers[#myTimers+1] = timer.performWithDelay( 500, endGame )
		--end
	end
	local vx, vy = spider[1]:getLinearVelocity()
	if(vx == 0 and vy == 0) then
	control.legPhaseCounter = control.legPhaseCounter + 1
		if(control.legPhaseCounter == 10) then
			for i = 1, 8 do
				if(spiderProp.leg[i].exists == 1)then
					if(control.legPhase == 1) then
						spiderProp.leg[i].x = spiderProp.leg[i].x + spiderProp.leg[i].dirx
						spiderProp.leg[i].y = spiderProp.leg[i].y + spiderProp.leg[i].diry
					else
						spiderProp.leg[i].x = spiderProp.leg[i].x - spiderProp.leg[i].dirx
						spiderProp.leg[i].y = spiderProp.leg[i].y - spiderProp.leg[i].diry
					end
				end
			end
			control.legPhase = control.legPhase * -1
			control.legPhaseCounter = 0
		end
	end
end 

local function reLoad(event )
	control.needtoReload = true
end

local function cross(event )
	control.needtoCross = true
end

local function removemoveMarket()
	if(moveMarketProp.Group ~= nil) then
		display.remove(moveMarketProp.Group)
		control.moveMarketExists = 0
		Runtime:removeEventListener( "tap", removemoveMarket )
	end
end

local function buyMove(event)
	currentProgressTable.totalFreeMove = currentProgressTable.totalFreeMove + 1
	currentProgressTable.totalGold = currentProgressTable.totalGold - control.moveCost
	writeTableIntoFile("progress.json", currentProgressTable)
	removemoveMarket()
end

local function cancelBuyMove(event)
	removemoveMarket()
end

local function removemoveMarketConditionally(event)
	--if(event.target.Name ~= "nextMove" and event.target.Name ~= "moveMarketProp_tickButton") then
		removemoveMarket()
	--end
end

local function tapNextMove(event )
	print("next move tapped")
	if(control.nextMoveSensitive == 0 or (control.nextMoveTapTime ~= -1 and system.getTimer() - control.nextMoveTapTime < 1000)) then
		print("insensitive")
		return
	end
	if(currentProgressTable.totalFreeMove <= 0 and control.moveMarketExists == 0) then
		print("cant use free move")
		moveMarketProp.rectColor = {levelProp[Level].dos_donts.Color[1]/2, levelProp[Level].dos_donts.Color[2]/2, levelProp[Level].dos_donts.Color[3]/2}
		moveMarketProp.moveCost = control.moveCost
		moveMarketProp.gems = currentProgressTable.totalGold
		moveMarketProp.freemove = currentProgressTable.totalFreeMove
		drawFuncs.drawMoveMarket(sceneGroup, moveMarket, moveMarketProp, totalWidth[1], totalHeight[1])
		moveMarketProp.tickButton:addEventListener("tap", buyMove)
		moveMarketProp.crossButton:addEventListener("tap", cancelBuyMove)
		control.moveMarketExists = 1
		--myTimers[#myTimers+1] = timer.performWithDelay( 500,  function() Runtime:addEventListener( "tap", removemoveMarketConditionally ) end)
		--Runtime:addEventListener( "tap", removemoveMarketConditionally )
		return
	elseif (currentProgressTable.totalFreeMove <= 0) then
		return
	end
	control.nextMoveTapTime = system.getTimer()
	control.UsedFreeMoves = control.UsedFreeMoves + 1
	currentProgressTable.totalFreeMove = currentProgressTable.totalFreeMove - 1
	nextMove[1].txt2.text =  currentProgressTable.totalFreeMove .. ""
	writeTableIntoFile("progress.json", progressTable)
	local vx, vy = spider[1]:getLinearVelocity()
	
	if(vx == 0 and vy == 0) then
		local wrongMove = 0
		for i = 1, control.legTapCount do
			print("tapped: " .. currentLegTapOrder[i])
			if(currentLegTapOrder[i] ~= spiderProp.LegTapOrder[i]) then
					wrongMove = 1
			end
		end
		print("wrongMove = " .. wrongMove)
		if(wrongMove == 0) then
			local event = {}
			event.target = spiderProp.legSquare[spiderProp.LegTapOrder[control.legTapCount + 1]]
			if(control.show_1st_move == 1) then
				control.show_1st_move = 0
			end
			pushLeg(event )
		else
			control.nextMoveSensitive = 0
			composer.setVariable( "show_1st_move", 1 )
			showNotiAndReload(3)
		end
	end
	
end


function scene:create( event )
	Level = composer.getVariable("level")
	print("Level = " .. Level)
	
	
	totalWidth[1] = commonProp.total.Width
	totalHeight[1] = commonProp.total.Height
	
	levelType = levelProp[Level].levelType
	control.nextMoveExists = levelProp[Level].nextMoveExists
	
	currentProgressTable = readFileIntoTable("progress.json")
	if(currentProgressTable == nil) then
		currentProgressTable = {}
	end
	
	control.startingTime = os.time()
	timeTable = readFileIntoTable("time.json")
	if(timeTable == nil) then
		timeTable = {}
	end
	if(timeTable["L" ..  Level] == nil) then
		control.neverCompletedThisLevel = true
		timeTable["L" ..  Level] = {}
		timeTable["L" ..  Level].Completed = false
		timeTable["L" ..  Level].SpentTime = 1
	else
		if(timeTable["L" ..  Level].Completed == false) then
			control.neverCompletedThisLevel = true
		else
			control.neverCompletedThisLevel = false
		end
	end
	control.PrevSpentTime = timeTable["L" ..  Level].SpentTime
	writeTableIntoFile("time.json", timeTable)
	
	
	if(currentProgressTable.totalFreeMove == nil) then
		currentProgressTable.totalFreeMove = 0
	end
	
	if(currentProgressTable.totalGold == nil) then
		currentProgressTable.totalGold = 0
	end
	
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
	
	if(control.nextMoveExists == true) then
		nextMoveProp.Img = commonProp.nextMove.Img
		nextMoveProp.PosiX = levelProp[Level].nextMove.PosiX
		nextMoveProp.PosiY = levelProp[Level].nextMove.PosiY
		nextMoveProp.Width = commonProp.nextMove.Width
		nextMoveProp.Height = commonProp.nextMove.Height
		nextMoveProp.Scale = commonProp.nextMove.Scale
		nextMoveProp.Opacity = 1
		nextMoveProp.totalFreeMove = currentProgressTable.totalFreeMove
	end
	
	
	
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
	spiderProp.BodySize = 387 * spiderProp.MyScale
	spiderProp.ArrowDistance = 365 * spiderProp.MyScale
	spiderProp.SpiderRadius = spiderProp.ArrowSize + spiderProp.ArrowDistance
	spiderProp.PosiX = levelProp[Level].spider.PosiX
	spiderProp.PosiY = levelProp[Level].spider.PosiY
	spiderProp.LegExists = levelProp[Level].spider.LegExists
	spiderProp.LegTapOrder = levelProp[Level].spider.LegTapOrder
	spiderProp.LegImg = levelProp[Level].spider.LegImg
	spiderProp.Img = levelProp[Level].spider.BodyImg
	spiderProp.ImgWidth = levelProp[Level].spider.BodyImgWidth
	spiderProp.ImgHeight = levelProp[Level].spider.BodyImgHeight
	spiderProp.BodyRatio = levelProp[Level].spider.BodyRatio
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
	
	control.lastLegTouched = -1
	control.spiderReachedGoal = false
	control.legPhase = -1
	control.heartPhase = -1
	control.legPhaseCounter = 0
	control.heartPhaseCounter = 0
	control.needtoReload = false
	control.needtoCross= false
	control.nextSpiderx = 0
	control.nextSpidery = 0
	control.SpiderPorting = 0
	control.LastPortal = nil
	control.LastPortalPair = nil
	control.spiderMoveDirX = 0
	control.spiderMoveDirY = 0
	control.spiderPreCollisionDirX = 0
	control.spiderPreCollisionDirY = 0
	lastCollidedWith.Name = ""
	control.legTapCount = 0
	control.legTappedOutOfOrder = false
	control.MakingNextMoveVisible = false
	control.UsedFreeMoves = 0
	control.spiderStillCount = 0
	control.nextMoveSensitive = 1
	control.nextMoveTapTime = -1
	control.filePath = system.pathForFile( "level.json", system.DocumentsDirectory )
	control.moveCost = 300
	control.moveMarketExists = 0
	control.screenTransitionOptions = 
	{
		effect = "fade",
		time = 800
	}
	
	physics.pause()
    sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	drawFuncs.drawBackGround(sceneGroup, bg, totalWidth[1], totalHeight[1], bgProp)
	--drawFuncs.drawEyes(sceneGroup, eyes, eyeProp, totalWidth, totalHeight)
	if(levelType ~= 3) then
		drawFuncs.drawBorder(sceneGroup, borders, totalWidth[1], totalHeight[1], borderProp, physics)
	end
	if(levelType == 4) then
		control.infiniteLegs = true
	else
		control.infiniteLegs = false
	end
	drawFuncs.drawCollider(sceneGroup, collider, colliderProp, physics)
	drawFuncs.drawPortals(sceneGroup, portal, portalProp)
	if(levelProp[Level].heartExists == 1) then
		drawFuncs.drawHearts(sceneGroup, heart, heartProp)
	end
	drawFuncs.drawGoal(sceneGroup, goal, goalProp, physics)		
	drawFuncs.drawSpider(sceneGroup, spider, spiderProp, physics, 0)
	
	drawFuncs.drawButtons(sceneGroup, totalWidth[1], totalHeight[1], bgProp)
	if(levelProp[Level].switchSystemExists == 1) then
		drawFuncs.drawSwitchSystem(sceneGroup, switchSystem, switchSystemProp, physics)
	end
	if(control.nextMoveExists == true) then
		drawFuncs.drawNextMove(sceneGroup, nextMove, nextMoveProp)
	end
	drawFuncs.drawNotiFication(sceneGroup, noti, notiProp, totalWidth[1], totalHeight[1])
	if(currentProgressTable.totalGold < control.moveCost and currentProgressTable.totalFreeMove == 0) then
		makeNextMoveInVisible()
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
		
		for i = 1,8 do
			spiderProp.legSquare[i]:addEventListener( "tap", pushLeg )
		end
		bgProp.reLoadButton:addEventListener("tap", reLoad)
		bgProp.reLoadButtonBox:addEventListener("tap", reLoad)
		bgProp.crossButton:addEventListener("tap", cross)
		bgProp.crossButtonBox:addEventListener("tap", cross)
		
		if(control.nextMoveExists == true and control.nextMoveExists == true) then
			nextMove[1]:addEventListener("tap", tapNextMove)
		end
		
		control.show_1st_move = composer.getVariable( "show_1st_move")
		if(control.show_1st_move == 1) then
			composer.setVariable( "show_1st_move", 0)
			myTimers[#myTimers+1] = timer.performWithDelay( 300, tapNextMove )
		end
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
		if(control.needtoReload == false and (math.random() < 0.3  or control.UsedFreeMoves > 0)) then
			showAdd()
			startapp.load( "interstitial" )
		end
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



