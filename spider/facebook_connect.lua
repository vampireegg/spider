
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local drawFuncs = require("drawFuncs")
local facebook = require( "plugin.facebook.v4a" )
local scene = composer.newScene()
local control = {}
local background


local Level
local bgProp = {}

local totalHeight
local totalWidth



local function gotoGame()

    composer.gotoScene( "dos_donts" , options)
end

local function facebookListener( event )
 
    if ( "fbinit" == event.name ) then
 
        print( "Facebook initialized" )
        facebook.login()
 
    elseif ( "fbconnect" == event.name ) then
 
        if ( "session" == event.type ) then
            -- Handle login event
            if ( "login" == event.phase ) then
                local shareParams = {
                    link = "https://play.google.com/store/apps/details?id=com.gmail.vampireegg.spider&hl=en",
                    title = "Lost in the Labyrinth"
                }
                facebook.showDialog( "link", shareParams )
            end
 
        elseif ( "dialog" == event.type ) then
            -- Handle dialog event
            print( event.response )
        end
    end
end
 


function scene:create( event )
 
	print("fb_connect")
	
	Level = composer.getVariable("level")
	
	
    local sceneGroup = self.view
	
	control.rectColor = {levelProp[Level].dos_donts.Color[1] / 2.5, levelProp[Level].dos_donts.Color[2] / 2.8, levelProp[Level].dos_donts.Color[3] / 1.8, 1}
    -- Code here runs when the scene is first created but has not yet appeared on screen
	
	totalWidth = commonProp.total.Width
	totalHeight = commonProp.total.Height
	

	
	-- Set the "fbinit" listener to be triggered when initialization is complete
	if(facebook ~= nil) then
		if(facebook.init ~= nil) then
			facebook.init( facebookListener )
		else
			print("facebook.init nil")
		end
	else
		print("facebook nil")
	end

 
	background = display.newRect(sceneGroup, totalHeight/2, totalWidth/2, totalHeight, totalWidth)
	background:setFillColor(control.rectColor[1], control.rectColor[2], control.rectColor[3], control.rectColor[4])

	background:addEventListener("tap", gotoGame)
	
	

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