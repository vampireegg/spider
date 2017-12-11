local HelpText ={
    '\n\n1. Meet Bumble Spider.\n\n' ..
		'2. Cut Legs.\n\n' ..
		'3. Reach the goal.\n\n' ..
		'3. Legs Fall off with time.\n\n',

    '\n\n1. No, You cannot cut legs while he is moving.\n\n',

    '\n\n1. Did you see the new colliders with grey boundaries? They are bouncy.\n\n' ..
		'2. Legs may fall in different orders in different levels.\n\n',

    '\n\n1. Meet Pizza Spider. He is stronger, his legs do not fall off. \n\n' ..
		'2. But you have to use up all his legs.\n\n',

    '\n\n1. Use the \'Spiral Bottle\' to rotate.\n\n' ..
		'2. Don\'t touch the glowing boundary.\n\n' ..
		'3. Competely cover the goal.',

    '\n\n1. This time, the web is alive :-P.\n\n',

    '',

    '\n\n1. Competely cover the goal. \n\n' ..
		'2. Use up all his legs.'
}
--leveltypes
local RaceAgainstTime = 0
local UseAllYourLegs = 1;

--goalTypes
local goalStatic = 0
local goalMoving = 1

--playerTypes
local playerNormal = 0
local playerPizza = 1

--colliderOrientation
local cHorizontal = 1
local cVertical = 2

--colliderBouncyNess
local cNonBouncy = 0
local cBouncy = 1

--colliderExplosiveNess
local cNonExplosive = 0
local cExplosive = 1

local Level ={}

Level[0] = {}
Level[0].levelType = RaceAgainstTime
Level[0].levelTitlePosition = 20

Level[0].goal = {}
Level[0].goal.type = goalStatic
Level[0].goal.y = 550
Level[0].goal.x = 550
Level[0].goal.distance = 20

Level[0].gPlayer = {}
Level[0].gPlayer.type = playerNormal
Level[0].gPlayer.x = 800
Level[0].gPlayer.y = 200
Level[0].gPlayer.nextleg = 0

Level[0].collider = {{10,400,260,270,cHorizontal,cNonBouncy,cNonExplosive}}


local spiral = {}
for i = 1,10 do
	local x = math.random(0, totalHeight)
	local y = math.random(0, totalWidth)
	-- spiral[i] = display.newImageRect( "spiral.png", 20,20  )
	-- spiral[i].x = x
	-- spiral[i].y = y
	-- spiral[i]:setFillColor( 1, 1, 1, .2 )
end