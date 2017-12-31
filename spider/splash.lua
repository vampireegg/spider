
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local drawFuncs = require("drawFuncs")
local scene = composer.newScene()


local Level
local bgProp = {}
local colliderProp = {}
local collider = {}
local totalHeight
local totalWidth
local counter
local collideCounter
local numCollider
local counterResetter

local backgroundMusic
local backgroundMusicChannel

local function gotoGame()
	audio.stop( backgroundMusicChannel)
	audio.stop(backgroundMusicChannel)
	local options = {
		effect = "fade",
		time = 800
	}
    composer.gotoScene( "select_level" , options)
end

local function on_frame( event )
	counter = counter + 1
	if(counter == counterResetter) then
		collideCounter = collideCounter + 1
		counter = 0
		counterResetter = counterResetter - 1
	end
	if (collideCounter > 0 and collideCounter <= numCollider) then
		collider[1][collideCounter]:setFillColor( 1, 1, 1, 1)
	end
	if(collideCounter == numCollider) then
		Runtime:removeEventListener( "enterFrame", on_frame )
		timer.performWithDelay( 100, gotoGame )
	end
end

function scene:create( event )
 
	print("splash")
	numCollider = 14
	counterResetter = 18
	
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	
	bgProp.Img = commonProp.splash.Img

	
	
 
	
    local background = display.newImageRect( sceneGroup, bgProp.Img, totalHeight, totalWidth )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	
	
	
	--background:addEventListener( "tap", gotoGame )
	
	
	colliderProp.MyScale = commonProp.collider.MyScale / 1.5
	colliderProp.colliderHeight = commonProp.collider.Height / 1.5
	colliderProp.colliderWidth = {}
	colliderProp.colliderWidth[1] = commonProp.collider.Width[1] / 1.5
	colliderProp.colliderGroupx = {300}
	colliderProp.colliderGroupy = {590}
	colliderProp.numColliders = {numCollider}
	colliderProp.Orientation = {1}
	colliderProp.ColliderType = {1}
	colliderProp.Img = commonProp.collider.Img
	colliderProp.CommonName = commonProp.collider.CommonName
	
	drawFuncs.drawCollider(sceneGroup, collider, colliderProp, nil)
	
	for i = 1,numCollider do
		collider[1][i]:setFillColor( 1, 1, 1, 0)
	end
	counter = 1
	collideCounter = 0
	
	backgroundMusic = audio.loadStream( "start.mp3" )
	backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )
	
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		Runtime:addEventListener( "enterFrame", on_frame )
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
		composer.removeScene( "splash" )

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