
local commonProp = require("commonProp")
local levelProp = require("levelProp")
local composer = require( "composer" )
local drawFuncs = require("drawFuncs")
local facebook = require( "plugin.facebook.v4a" )
local scene = composer.newScene()
local control = {}
local background


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
	
	control.Time1stTime = composer.getVariable("Time1stTime")
	control.Completed_level = composer.getVariable("Completed_level")
	control.UsedFreeMoves = composer.getVariable("UsedFreeMoves")
	local Scale = 0.04
	
    local sceneGroup = self.view
	
	control.rectColor = {levelProp[control.Completed_level].dos_donts.Color[1] / 2.5, levelProp[control.Completed_level].dos_donts.Color[2] / 2.8, 
	levelProp[control.Completed_level].dos_donts.Color[3] / 1.8, 1}
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
	
	
	local posiX = totalHeight/2
	local posiY = totalWidth/2 - 200
	
	background.txt = {}
	background.txt[1] = display.newText( "Congratulations ", posiX, posiY,  "comic.ttf", 36 )
	background.txt[1]:setFillColor( 0.9, 0.9, 0.65, 1)
	sceneGroup:insert(background.txt[1])
	
	posiY = posiY + 100
	
	background.txt[2] = display.newText( "You completed the Hard Level " .. control.Completed_level .. " in " .. control.Time1stTime .. " seconds, challenge friends on FaceBook?", posiX, posiY,  "comic.ttf", 16 )
	background.txt[2]:setFillColor( 0.9, 0.9, 0.65, 1)
	sceneGroup:insert(background.txt[2])

	background:addEventListener("tap", gotoGame)
	
	posiY = posiY + 100
	
	background.txt[3] = display.newText( "Confirm: ", posiX - 50, posiY,  "comic.ttf", 20 )
	background.txt[3]:setFillColor( 0.6, 0.6, 1, 1)
	sceneGroup:insert(background.txt[3])
	
	background.facebookButton = display.newImageRect( sceneGroup, "fb_button.png", 1920, 1040 )
	background.facebookButton.x = background.txt[3].x + background.txt[3].width/2 + 20
	background.facebookButton.y = posiY
	background.facebookButton:scale(Scale, Scale)
	
	posiY = posiY + 100
	
	background.txt[4] = display.newText( "Cancel : ", posiX - 50, posiY,  "comic.ttf", 20 )
	background.txt[4]:setFillColor( 0.9, 0.9, 0.3, 1)
	sceneGroup:insert(background.txt[4])
	
	background.crossButton = display.newImageRect( sceneGroup, "cross2.png", 70, 65 )
	background.crossButton.x = background.txt[4].x + background.txt[4].width/2 + 20
	background.crossButton.y = posiY
	background.crossButton:scale(.5, .5)
	
	

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