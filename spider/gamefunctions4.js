window.onload = function() {
    initGame();
}
var gCanvas = null;
var gContext = null;
var dummyCanvas, dummyContext;
var backgroundCanvas, backgroundContext;
var gKeys = [];
var bgcolor = '#222222';
var mousex =-100;
var mousey=-100;

var bgLoaded = 0;

//level
var MaxLevel = 7;
var nextLevel = 0;
var currentlevel = 0;
var currentMaxLevel = 0;
var firstTimeInALevel = 1;
var firstTimeInLevelScreen = 1;
var firstTimeInInitLevel = 1;

var goal = {x:0,y:0,speedIncrement:10,boxDiameter:100,movedirx:0,movediry:0,type:0,willcollide:1,collitionwith:-1};
var endLevelTimer = 100;
var goalDistance = 30;

var mainScreenBoundaryX = 615;


var gPlayer = {x:0,y:0,speedIncrement:10,diameter:0,boxDiameter:0,movedirx:0,movediry:0,willcollide:1,collitionwith:-1};

var StartScreen = 0, ChooseLevel = 1, InLevel =2, EndLevel = 3, LevelScreen = 4, LevelInitScreen = 5;
var gamePhase = 0;


//keyboard keys
var leftarrow = 37;
var uparrow = 38;
var rightarrow = 39;
var downarrow = 40;
var pause = 19;
var space = 32;


//legs
var hasleg = new Array(1,1,1,1, 1,1,1,1);
var legxdir = new Array(1,1,0,-1, -1,-1,0,1);
var Legydir = new Array(0,1,1,1, 0,-1,-1,-1);
var nextleg = 0;
var gNextLegTime = 100;
var nextlegtime = 100;
var RaceAgainstTime = 0, UseAllYourLegs = 1;
var levelType = 0;

//bubles
var bubleGrdArray1 = new Array();
var bubleGrdArray2 = new Array();
var bubbleArray = new Array();

//StartScreen
var heightinc =-1;
gPlayer.diameter = 120;

//collider
var collider = new Array(); //1 means horizontal, 2 means vertical


//Bottle
var bottleExists = new Array();
var bottleType = new Array();
var bottleUsageTime = new Array();
var selectedBottle = 0;
var spiralClickedTime = -1;

//buttons
var reloadX = 750, reLoadY = 45;
var crossX = 660, crossY = 45;

var gpainaudio;


var timer =0;

var nLevelInitScreenImage = [2,1,0,0,0,0,0,0];

var HelpText =[
    '\n\n1. Meet Bumble Spider.\n\n' +
		'2. Cut Legs.\n\n' +
		'3. Reach the goal.\n\n' +
		'3. Legs Fall off with time.\n\n',

    '\n\n1. No, You cannot cut legs while he is moving.\n\n',

    '\n\n1. Did you see the new colliders with grey boundaries? They are bouncy.\n\n' +
		'2. Legs may fall in different orders in different levels.\n\n',

    '\n\n1. Meet Pizza Spider. He is stronger, his legs do not fall off. \n\n' +
		'2. But you have to use up all his legs.\n\n',

    '\n\n1. Use the \'Spiral Bottle\' to rotate.\n\n' +
		'2. Don\'t touch the glowing boundary.\n\n' +
		'3. Competely cover the goal.',

    '\n\n1. This time, the web is alive :-P.\n\n',

    '',

    '\n\n1. Competely cover the goal. \n\n' +
		'2. Use up all his legs.',
];
var levelTitlePosition = 20;
var LevelTitle = [
    "1. Bioptici Bumblespidee",

    "2. Almost Seven Up",

    "3. Sticus Elastica",

    "4. Em'tanglement Theory",

    "5. Duplex Curvis",

    "6. Sentinelis Aranea",

    "7. Theorem of Lance Vance Dance",

    "8. Symmetrycity"
];

function gameLoop()
{

    setTimeout(gameLoop, (1000 / 30));
	if(gamePhase == LevelInitScreen)
	{
		drawLevelInitScreen(currentlevel);
		return;
	}
    if(gamePhase == StartScreen)
    {
        drawStartScreen();
        return;
    }
    else if(gamePhase == EndLevel)
    {
        drawEndLevel();
        if(endLevelTimer >=0)
        {
            endLevelTimer -= 4;
        }
        if(endLevelTimer <= 0)
        {
            if(nextLevel<MaxLevel)
            {
                nextLevel++;
            }
            gamePhase = InLevel;
            initLevel(nextLevel);
        }
        return;
    }
    else if (gamePhase == LevelScreen)
    {
        drawLevelScreen();
        return;
    }
    //if(hasanyleg() == 0)
    //{
    // initLevel(nextLevel);
    //}

    if(mousex < mainScreenBoundaryX)
    {
        gCanvas.style.cursor = 'none';
    }
    else
    {
        gCanvas.style.cursor = 'auto'
    }

    if(isPlayerInGoal())
    {
        gamePhase = EndLevel;
        endLevelTimer = 100;
    }

    timer++;

    //drawPlayer();

    if(levelType == RaceAgainstTime && timer % 3 == 0)
    {
        nextlegtime--;
    }

    if (levelType == RaceAgainstTime  && nextlegtime == 0 && hasanyleg() == 1)
    {
        if(hasleg[nextleg]==1) {
            playCrySound();
            winkingtime = 0;
        }
        nextlegtime=gNextLegTime;
        hasleg[nextleg] = 0;

        var msg = 'removing leg ' + nextleg;
        writeMessage(msg);

        nextleg++;
        if(nextleg == 8)
        {
            nextleg = 0;
        }

    }

    if (winkingtime >= 0) {
        winkingtime++;
    }
    if (winkingtime >= 20) {
        winkingtime = -1;
    }
    //setTimeout(gameLoop, (1000 / 30)); // Execute Game Loop at 30FPS

    /*
     if (gKeys.indexOf(leftarrow) != -1) {
     gPlayer.x -= gPlayer.speedIncrement; // Move Left 1
     drawPlayer();
     }
     if (gKeys.indexOf(rightarrow) != -1) {
     gPlayer.x += gPlayer.speedIncrement; // Move Right 1
     drawPlayer();
     }
     if (gKeys.indexOf(uparrow) != -1) {
     gPlayer.y -= gPlayer.speedIncrement; // Move Left 1
     drawPlayer();
     }
     if (gKeys.indexOf(downarrow) != -1) {
     gPlayer.y += gPlayer.speedIncrement; // Move Right 1
     drawPlayer();
     }
     */
    if (gKeys.indexOf(pause) != -1) {
        // Pause Game
    }
    if (gKeys.indexOf(space) != -1) {
        //fireBullet(gPlayer.x,gPlayer.y);
    }

    changePosition(gPlayer);
    if(goal.type == 1)
    {
        changePosition(goal);
    }

    redrawAll();
}

function getMousePos( evt) {
    var rect = gcanvas.getBoundingClientRect();
    return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
    };
}

function mouseclicked(e)
{
    //var message = 'Mouse position: ' + e.pageX + ',' + e.pageY;
    var message = 'Mouse position: ' + e.clientX + ',' + e.clientY;
    writeMessage(message);

    var rect = gCanvas.getBoundingClientRect();
    mousex = e.clientX - rect.left;
    mousey = e.clientY - rect.top;

    if(gamePhase == StartScreen)
    {
        //gCanvas.width/2-70,gCanvas.height/2+120,140,20

        if(mousex >= gCanvas.width/2-70 && mousex <= gCanvas.width/2-70+140 //Old Game Button Clicked
            && mousey >= gCanvas.height/2+120 && mousey <= gCanvas.height/2+120+20)
        {
            nextLevel = Number(localStorage.getItem("level"));
            if(nextLevel == NaN)
            {
                nextLevel = 0;
            }
            gamePhase = InLevel;
            heightinc = -1;
            initLevel(nextLevel);
            return false;
        }
        else if(mousex >= gCanvas.width/2-70 && mousex <= gCanvas.width/2-70+140 //New Game Button Clicked
            && mousey >= gCanvas.height/2+145 && mousey <= gCanvas.height/2+145+20)
        {
            localStorage.removeItem("level");
            nextLevel = 0;
            gamePhase = InLevel;
            heightinc = -1;

            initLevel(nextLevel);
            return false;
        }
        else if(mousex >= gCanvas.width/2-70 && mousex <= gCanvas.width/2-70+140 
            && mousey >= gCanvas.height/2+170 && mousey <= gCanvas.height/2+170+20)
        {
			nextLevel = Number(localStorage.getItem("level"));
            if(nextLevel == NaN)
            {
                nextLevel = 0;
            }
			heightinc = -1;
            gamePhase = LevelScreen;
			firstTimeInLevelScreen = 1;
        }
        else if(Math.sqrt(sqr(mousex - gCanvas.width/2) + sqr(mousey - gCanvas.height/2)) < 160) //Spider Clicked
        {
			nextLevel = Number(localStorage.getItem("level"));
            if(nextLevel == NaN)
            {
                nextLevel = 0;
            }
            gamePhase = InLevel;
            heightinc = -1;
            initLevel(nextLevel);
            return false;
        }
    }
    else if (gamePhase == InLevel)
    {
        if(Math.sqrt(sqr(mousex - reloadX) + sqr(mousey - reLoadY)) < 20)
        {
			var currentlevel = Number(localStorage.getItem("currentlevel"));
            initLevel(currentlevel);
            return false;
        }
        if(Math.sqrt(sqr(mousex - crossX) + sqr(mousey - crossY)) < 20)
        {
            gPlayer.diameter = 110;
            hasleg = [1,1,1,1, 1,1,1,1];
            gamePhase = StartScreen;
            return false;
        }
    }
	else if (gamePhase == LevelScreen)
	{
		var level = getclickedleg (mousex,mousey,1);
		if(level>=0)
		{
			gamePhase = InLevel;
			initLevel(level);
			return false;
		}
		if(Math.sqrt(sqr(mousex - reloadX) + sqr(mousey - reLoadY)) < 20)
        {
            initLevel(nextLevel);
            return false;
        }
        if(Math.sqrt(sqr(mousex - crossX) + sqr(mousey - crossY)) < 20)
        {
            gPlayer.diameter = 110;
            hasleg = [1,1,1,1, 1,1,1,1];
            gamePhase = StartScreen;
            return false;
        }
		return false;		
	}
	else if (gamePhase == LevelInitScreen)
	{
		gamePhase = InLevel;
	}


    getclickedleg (mousex,mousey);
    getSelectedBottle (mousex,mousey);
    return false;
}

function getSelectedBottle(mousex,mousey)
{
    if(mousey<70)
    {
        for (var i=0; i<bottleExists.length; i++)
        {
            if(bottleExists[i] && mousex>i*100 && mousex < (i+1) * 100)
            {
                selectedBottle = i;
            }
        }
    }
}


function drawReloadButton()
{

    var x = reloadX, y = reLoadY;
    gContext.save();
    gContext.beginPath();
    gContext.arc(x , y, 15, (45/360)* 2*Math.PI, 2 * Math.PI, false);
    gContext.lineWidth = 4;
    gContext.strokeStyle = '#888888';
    gContext.stroke();
    gContext.closePath();
    gContext.restore();
}

function drawHelpBorder()
{

    gContext.save();

    gContext.beginPath();
    gContext.shadowOffsetX = 2;
    gContext.shadowOffsetY = 2;
    gContext.shadowBlur = 2;
    gContext.shadowColor = '#777777';

    gContext.moveTo(625,75);
    gContext.lineTo(785,75);
    gContext.lineWidth =2;



    gContext.strokeStyle = '#000000';
    gContext.stroke();
    gContext.closePath();

    gContext.restore();
}


function drawCrossButton()
{
    var x = crossX, y = crossY;
    gContext.save();
    gContext.beginPath();
    drawlineNoStroke(crossX-15,crossY-15,crossX+15,crossY+15);
    drawlineNoStroke(crossX+15,crossY-15,crossX-15,crossY+15);

    gContext.lineWidth = 4;
    gContext.strokeStyle = '#888888';
    gContext.stroke();
    gContext.closePath();
    gContext.restore();
}



function initLevel(level)
{
	var maxCompletedLevel = Number(localStorage.getItem("level"));
	if(level>maxCompletedLevel)
	{
		localStorage.setItem("currentlevel", level);
		localStorage.setItem("level", level);
	}
	else
	{
		localStorage.setItem("currentlevel", level);
	}
    gPlayer.diameter =70;
    gPlayer.boxDiameter =90;

    firstTimeInALevel = 1;

    currentlevel = level;
    spiralClickedTime = -1;

	bgLoaded = 0;

    hasleg = [1,1,1,1, 1,1,1,1];

    nextlegtime = 100;

    gPlayer.willcollide = 1;
    goal.willcollide = 1;

    selectedBottle = 0;

    goal.boxDiameter = 100;
	
	gNextLegTime = 100;
	
	goalDistance = 20;
	
	firstTimeInInitLevel = 1;
	
	for(var i=0; i<20; i++)
	{
		var bubble = {x: Math.floor(Math.random() * 600), y: Math.floor(100 + Math.random()* 500), time: Math.floor(Math.random()* 200)};
		bubbleArray[i] = bubble;
	}

    if(level == 0)
    {

        levelType = RaceAgainstTime;
        goal.type = 0;
        levelTitlePosition = 20;
        nextleg =0;
        gPlayer.x = 80;
        gPlayer.y = 200;
        collider = [[10,400,260,270,1,0,0]]; //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy
        bottleExists = [1];
        bottleUsageTime = [0];
		bottleType = [1];
        goal.x=550;
        goal.y=550;
        goalDistance = 20;
    }

    if(level == 1)
    {
        levelType = RaceAgainstTime;
        goal.type = 0;
        levelTitlePosition = 20;
        nextleg =0;
        gPlayer.x = 180;
        gPlayer.y = 200;
        collider = [[10,290,260,270,1,0,0] , [300,590,400,410,1,0,0]]; //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy
        bottleExists = [1];
        bottleUsageTime = [0];
		bottleType = [1];
        goal.x=550;
        goal.y=550;
        goalDistance = 20;
    }
    if(level == 2)
    {
        levelType = RaceAgainstTime;
        goal.type = 0;
        levelTitlePosition = 520;
        nextleg = 2;
        gPlayer.x = 80;
        gPlayer.y = 300;
        collider = [[10,300,360,370,1,0,0] , [310,320,190,370,2,1,0], [10,180,160,170,1,0,0], [150,590,480,490,1,0,0]]; //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy
        bottleExists = [1];
        bottleUsageTime = [0];
		bottleType = [1];
        goal.x=50;
        goal.y=550;
        goalDistance = 20;
    }
    if(level == 3)
    {
        levelType = UseAllYourLegs;
        goal.type = 0;
        levelTitlePosition = 470;
        nextleg = 2;
        gPlayer.x = 155;
        gPlayer.y = 535;
        //collider = [[247,257,325,590,2,1]];
        collider = [[247,257,325,590,2,1,0],[450,460,525,590,2,1,0]]; //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy
        bottleExists = [1];
        bottleUsageTime = [0];
		bottleType = [1];
        goal.x=365;
        //goal.y=450;
        goal.y=540;
        goalDistance = 20;
    }
    if(level == 4)
    {
        /*
        goal.type = 0;
        levelTitlePosition = 20;
        nextleg = 4;
        gPlayer.x = 550;
        gPlayer.y = 400;
        //collider = [[150,255,240,250,1,0]];
        collider = [[150,255,240,250,1,0,0],[250,260,90,225,2,0,0],[370,380,90,225,2,0,0]]; //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy
        bottleExists = [1, 1];
        bottleUsageTime = [0, 1];
        goal.x=310;
        //goal.y=330;
        goal.y=140;
        */

        levelType = RaceAgainstTime;
        goal.type = 0;
        levelTitlePosition = 20;
        nextleg = 4;
        gPlayer.x = 540;
        gPlayer.y = 500;
        collider = [[110,130,290,300,1,0,0],[10,600,80,90,1,0,1],[593,603,90,600,2,0,1]]; //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy
        bottleExists = [1, 1];
        bottleUsageTime = [0, 1];
		bottleType = [1, 2];
        goal.x=260;
        goal.y=460;
        goal.boxDiameter = 60;
        goalDistance = 10;

    }
    if(level == 5)
    {
        levelType = RaceAgainstTime;
        goal.type = 1;
        levelTitlePosition = 20;
        nextleg =0;
        gPlayer.x = 60;
        gPlayer.y = 365;
        collider = [[10,430,420,430,1,0,0],[420,430,390,420,2,0,0],[420,430,100,130,2,0,0]]; //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy
        bottleExists = [1, 1];
        bottleUsageTime = [0, 1];
		bottleType = [1, 2];
        goal.x=550;
        goal.y=550;
        goalDistance = 20;

    }
    if(level == 6)
    {
        levelType = RaceAgainstTime;
        goal.type = 1;
        levelTitlePosition = 20;
        nextleg =0;
        gPlayer.x = 270;
        gPlayer.y = 410;
        collider = [[220,520,120,130,1,1,0],[220,520,300,310,1,1,0],[220,520,480,490,1,1,0],[20,30,130,470,2,0,1]];
        //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy,explosive/not
        bottleExists = [1];
        bottleUsageTime = [0];
		bottleType = [1, 2];
        goal.x=550;
        goal.y=220;
        goalDistance = 20;
    }
    if(level == 7)
    {
		/*
        goal.type = 1;
        levelTitlePosition = 20;
        nextleg =0;
        gPlayer.x = 100;
        gPlayer.y = 130;
        collider = [[10,20,100,300,2,0,0],[185,195,100,140,2,0,0],[185,195,260,300,2,0,0],[10,195,300,310,1,0,0],[300,420,140,150,1,0,0]];
        //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy,explosive/not
        bottleExists = [1, 1];
        bottleUsageTime = [0, 1];
        goal.x=550;
        goal.y=150;
		*/

        levelType = UseAllYourLegs;
		goal.type = 0;
        levelTitlePosition = 510;
        nextleg =0;
        gPlayer.x = 210;
        gPlayer.y = 540;
        collider = [[295,305,350,400,2,0,1]];
        //left,rigt,top,bottom,vertical/horizontal,bouncy/non-bouncy,explosive/not
        bottleExists = [1];
        bottleUsageTime = [0];
		bottleType = [1];
        goal.x=390;
        goal.y=410;
		goal.boxDiameter = 60;
        goalDistance = 10;
    }

     /*
     goal.type = 1;
     levelTitlePosition = 20;
     nextleg =0;
     gPlayer.x = 550;
     gPlayer.y = 130;
     collider = [[220,600,310,320,1,0],[220,230,190,220,2,0],[220,230,440,460,2,0]];
     bottleExists = [1, 1];
     bottleUsageTime = [0, 1];
     goal.x=550;
     goal.y=550;
     */
	 //gamePhase = LevelInitScreen;	 
	 gamePhase = InLevel;	 
}



function drawPolygon(polyX,polyY)
{
    var i;
    gContext.beginPath();
    //gContext.lineWidth = 2;
    gContext.moveTo(polyX[0],polyY[0]);
    for(i=0;i<polyX.length-1;i++)
    {
        gContext.lineTo(polyX[i+1],polyY[i+1]);
    }
    gContext.lineTo(polyX[0],polyY[0]);
    gContext.closePath();

}


function drawSpiderBody(context,x,y, radius,color)
{

    var offset = 50;

    /*
     * save() allows us to save the canvas context before
     * defining the clipping region so that we can return
     * to the default state later on
     */
    context.save();
    context.beginPath();
    context.arc(x, y, radius, 0, 2 * Math.PI, false);
    context.clip();

    if(color === undefined )
    {
        var myYellow = /*'#ffffff';*/'#F2FA82';

    }
    else
    {
        myYellow = color;
    }


	if(levelType == RaceAgainstTime)
	{

		context.beginPath();
		context.arc(x , y, radius, 0, 2 * Math.PI, false);
		context.fillStyle = myYellow;
		context.fill();

		context.beginPath();
		context.arc(x, y - radius *.3, radius, 0, 2 * Math.PI, false);
		context.fillStyle = '#111111';
		context.fill();

		context.beginPath();
		context.arc(x, y - radius *.5, radius, 0, 2 * Math.PI, false);
		context.fillStyle = myYellow;
		context.fill();

		context.beginPath();
		context.arc(x, y - radius*1, radius , 0, 2 * Math.PI, false);
		context.fillStyle = '#111111';
		context.fill();
		
		context.beginPath();
		context.arc(x, y - radius*1.2, radius , 0, 2 * Math.PI, false);
		context.fillStyle = myYellow;
		context.fill();

		context.beginPath();
		context.arc(x, y - radius*1.5, radius *.9 , 0, 2 * Math.PI, false);
		context.fillStyle = '#111111';
		context.fill();

		context.beginPath();
		context.arc(x, y - radius*1.65, radius *.9 , 0, 2 * Math.PI, false);
		context.fillStyle = myYellow;
		context.fill();
	}
	else if (levelType == UseAllYourLegs)
	{
		var myRed = '#db7c2b';
		var myRed2 = '#bb7c2b';
		var myDark = '#5a7c76';
		var myDark2 = '#221111';
		


        var grd2=gContext.createRadialGradient(x, y, radius-10,
            x,y,radius );
        grd2.addColorStop(0,myDark2);
        grd2.addColorStop(1,myRed);

        
		context.beginPath();
		context.arc(x , y, radius, 0, 2 * Math.PI, false);
		gContext.fillStyle=grd2;
		context.fill();
		
		context.beginPath();
		context.arc(x , y, radius - 10, 0, 2 * Math.PI, false);
		context.fillStyle = myYellow;
		context.fill();
		
		context.beginPath();
		context.arc(x , y, radius, 0, 2 * Math.PI, false);
		context.strokeStyle = 'black';
		context.stroke();
		
		var len = radius - 10;
		
		for(var i=0;i<6;i++)
		{
			var theta=  i* Math.PI/3;			
			gContext.moveTo(gPlayer.x, gPlayer.y);
			gContext.lineTo(gPlayer.x + len * Math.cos(theta), gPlayer.y + len * Math.sin(theta));
		}
		context.strokeStyle = myDark2;
		context.stroke();
		
		len = radius - 18;
		for(var i=0;i<6;i++)
		{
			var theta=  i* Math.PI/3 + Math.PI/6;	

			context.beginPath();
			context.arc(gPlayer.x + len * Math.cos(theta) , gPlayer.y + len * Math.sin(theta), 3, 0, 2 * Math.PI, false);
			context.fillStyle = myDark;
			context.fill();			
		}
		
		/*context.beginPath();
		context.arc(x , y, radius - 20, 0, 2 * Math.PI, false);
		context.fillStyle = myRed2;
		context.fill();*/

	}

    /*
     * restore() restores the canvas context to its original state
     * before we defined the clipping region
     */
    context.restore();
    context.beginPath();

}


function drawSpiralNoStroke(x,y)
{
    var angle;
    var posx, posy;

    gContext.save();

    for (var i=0; i< 250; i++)
    {
        angle = 0.1 * i;
        posx=x+(1+angle)*Math.cos(angle);
        posy=y+(1+angle)*Math.sin(angle);
        if(i==0)
        {
            gContext.moveTo(posx, posy);
        }
        else
        {
            gContext.lineTo(posx, posy);
        }
    }

    gContext.restore();
}

function drawBottle(i,x,y,doRotate)
{
    if(bottleType[i] == 1)
    {

        var Shrinkfactor =1;
        gContext.save();

        var theta = 0;

        if(doRotate==1)
        {
            Shrinkfactor = .5;
            theta = Math.PI/4;
        }

        gContext.lineWidth = 2*Shrinkfactor;
        var ctheta = Math.cos(theta);



        var polyX =[x-6 * Shrinkfactor*ctheta,x-30 *Shrinkfactor*ctheta,x+30 *Shrinkfactor*ctheta,x+6 *Shrinkfactor*ctheta];
        var polyY =[y-20 *Shrinkfactor*ctheta,y+20 *Shrinkfactor*ctheta,y+20 *Shrinkfactor*ctheta,y-20 *Shrinkfactor*ctheta];
        drawPolygon(polyX,polyY);


        var mygreen = '#66F62C';
        var mygreen2 = '#BDF4A7';

        var grd2=gContext.createRadialGradient(x, y, 5*Shrinkfactor,
            x,y,20*Shrinkfactor );
        grd2.addColorStop(0,mygreen);
        grd2.addColorStop(1,mygreen2);

        gContext.fillStyle=grd2;
        gContext.fill();


        gContext.save();

        gContext.shadowOffsetX = 2*Shrinkfactor;
        gContext.shadowOffsetY = 2*Shrinkfactor;
        gContext.shadowBlur = 2*Shrinkfactor;
        gContext.shadowColor = '#4d4d4d';


        gContext.strokeStyle = '#000000';
        //gContext.stroke();

        gContext.restore();

        var polyX =[x-2*Shrinkfactor*ctheta,x-6*Shrinkfactor*ctheta,x+6*Shrinkfactor*ctheta,x+2*Shrinkfactor*ctheta];
        var polyY =[y-28*Shrinkfactor*ctheta,y-20*Shrinkfactor*ctheta,y-20*Shrinkfactor*ctheta,y-28*Shrinkfactor*ctheta];
        drawPolygon(polyX,polyY);

        gContext.strokeStyle = '#000000';
        //gContext.stroke();

        gContext.fillStyle='#151515';
        gContext.fill();

        var j;

        for(j=-1;j<=1;j+=2)
        {
            var polyX =[x+5*j*Shrinkfactor*ctheta,x+7*j*Shrinkfactor*ctheta,x+3*j*Shrinkfactor*ctheta];
            var polyY =[y-4*Shrinkfactor*ctheta,y,y];
            drawPolygon(polyX,polyY);

            gContext.strokeStyle = '#000000';
            gContext.stroke();
        }


        var polyX =[x+2*Shrinkfactor*ctheta,x-2*Shrinkfactor*ctheta,x];
        var polyY =[y+4*Shrinkfactor*ctheta,y+4*Shrinkfactor*ctheta,y+8*Shrinkfactor*ctheta];
        drawPolygon(polyX,polyY);

        gContext.strokeStyle = '#000000';
        gContext.stroke();

        gContext.fillStyle='#cccccc';
        gContext.fill();
        gContext.restore();

    }
    else if (bottleType[i] == 2)
    {
        gContext.save();
        gContext.shadowOffsetX = 0;
        gContext.shadowOffsetY = 0;
        gContext.shadowBlur = 4;
        gContext.shadowColor = '#F5F3BA';
        drawSpiralNoStroke(x,y);
        gContext.strokeStyle = '#000000';
        gContext.stroke();

        for(var j=-1; j<=1; j+=2)
        {
            gContext.beginPath();
            gContext.arc(x + 15*j, y - 20, 6, 0, 2 * Math.PI, false);


            gContext.fillStyle='black';
            gContext.fill();

            gContext.lineWidth = 2;
            gContext.strokeStyle='black';

            gContext.closePath();
            gContext.stroke();
        }


        gContext.restore();
        wrapText(gContext,''+bottleUsageTime[1],x+30,y-25, 500, 200, 'centre','8px Gretoon');
    }
}



function drawBottles()
{
    var i;
    for(i=0;i<bottleExists.length;i++)
    {
        if(bottleExists[i]==1)
        {
            drawBottle(i,50 + i*100,40,0);

            var x,y;
            if (bottleType[selectedBottle] == 1)
            {
                if(mousex <= mainScreenBoundaryX-13)
                {
                    //getMousePos();
                    if(mousex>mainScreenBoundaryX-13)
                    {
                        x=mainScreenBoundaryX-13;
                    }
                    /*else if (mousex<0)
                     {
                     x = 5;
                     }*/
                    else
                    {
                        x=mousex;
                    }

                    if(mousey>580)
                    {
                        y=580+ 28*.5;
                    }
                    /*else if (mousey<5)
                     {
                     y = 5+ 28*.5;
                     }*/
                    else
                    {
                        y=mousey + 28*.5;
                    }
                    gContext.save();
                    gContext.translate(x,y);
                    gContext.rotate(-Math.PI/8);
                    drawBottle(selectedBottle,0,0,1);
                    gContext.restore();
                }
            }
            else if (bottleType[selectedBottle] == 2)
            {
                spiralClickedTime = 0;

                bottleUsageTime [selectedBottle]--;
                if(bottleUsageTime [selectedBottle]<=0)
                {
                    bottleExists[selectedBottle]=0;
                }
                selectedBottle = 0;
                redrawAll();
            }

        }
    }
}

function initGame()
{

    gCanvas = document.getElementById('canvas');
    gContext = gCanvas.getContext('2d');
    backgroundCanvas = document.getElementById('backgroundCanvas');
    backgroundContext = backgroundCanvas.getContext('2d');
    /*dummyCanvas = document.createElement('canvas');
    dummyCanvas.width = gCanvas.width;
    dummyCanvas.height = gCanvas.height;
    dummyContext = dummyCanvas.getContext('2d');*/



    nextLevel = Number(localStorage.getItem("level"));
    if(nextLevel == NaN)
    {
        nextLevel =0;
    }

    gCanvas.addEventListener('mousedown',canvasFocus,false);
    gCanvas.addEventListener('keydown',canvasKeyDown,false);
    gCanvas.addEventListener('keyup',canvasKeyUp,false);
    gCanvas.addEventListener('mousemove', function(e)
    {
        var rect = gCanvas.getBoundingClientRect();
        mousex = e.clientX - rect.left;
        mousey = e.clientY - rect.top;
    }, false);
    gCanvas.addEventListener('click',mouseclicked, false);

    gpainaudio = document.createElement('audio');
    gpainaudio.src = 'youch3.wav';
    gpainaudio.id ="painaudio";


    playSound('heartbeat-01a.mp3');

    gameLoop();
}

function drawUpBorder()
{
    gContext.save();

    gContext.beginPath();
    gContext.shadowOffsetX = 2;
    gContext.shadowOffsetY = 2;
    gContext.shadowBlur = 2;
    gContext.shadowColor = '#4d4d4d';

    gContext.moveTo(5,70);
    gContext.lineTo(595,70);
    gContext.lineWidth =2;



    gContext.strokeStyle = '#000000';
    gContext.stroke();
    gContext.closePath();

    gContext.restore();
}


function wrapText(context, text, x, y, maxWidth, lineHeight, position,font,color)
{
    if(typeof(position)==='undefined') position = "top";
    if(typeof(font)==='undefined')  context.font = "16px Gretoon";
    if(typeof(color)==='undefined')  context.fillStyle = '#bbbbbb';
    var cars = text.split("\n");
    context.save();

    context.lineWidth = 1;
    context.shadowOffsetX = 0;
    context.shadowOffsetY = 0;
    context.shadowBlur = 3;
    context.shadowColor = '#4d4d4d';

    //context.style.textShadow = '3px|3px|0px|#2c2e38';

    context.fillStyle = color;

    context.textBaseline = position;
    context.font = font;
    //context.font = "16px Verdana";

    for (var ii = 0; ii < cars.length; ii++) {

        var line = "";
        var words = cars[ii].split(" ");

		var LineNo = 1;
        for (var n = 0; n < words.length; n++) 
		{
            var testLine = line + words[n] + " ";
            var metrics = context.measureText(testLine);
            var testWidth = metrics.width;

            if (testWidth > maxWidth -13) {
				if(LineNo == 1)
				{
					context.fillText(line, x, y);
				}
				else
				{
					context.fillText(line, x + 13, y);
				}
                line = words[n] + " ";
                y += lineHeight;
				LineNo ++;
            }
            else {
                line = testLine;
            }
        }

		if(LineNo == 1)
		{
			context.strokeText(line, x, y);
			context.fillText(line, x, y+1);
		}
		else
		{
			context.strokeText(line, x + 13, y);
			context.fillText(line, x + 13, y+1);
		}
        //context.fillText(line, x + 15, y+1);

        y += lineHeight;
    }
    context.restore();
}

function drawHelpText (text)
{
    gContext.font = "16px Arial";
    gContext.fillStyle = '#cccccc';
    //gContext.fillText(text, 610, 25);
    wrapText(gContext,text,mainScreenBoundaryX + 8, 70,180,20,'top','12px Arial');
    gContext.closePath();
}

function drawLevelTitle(title)
{

    gContext.fillStyle = '#999999';
    wrapText(gContext,title,levelTitlePosition,gCanvas.height-30, 500, 200, 'centre','12px Gretoon',gContext.fillStyle );
    //drawline(mainScreenBoundaryX + 5,140,gCanvas.width-5,140,gContext.fillStyle);
}

function writeMessage( message) {
    /*
     //var context = gcanvas.getContext('2d');
     gContext.beginPath();
     gContext.clearRect(0, 0, 300, 50);
     gContext.fillStyle=bgcolor;
     gContext.fillRect(0, 0, 300, 50);
     gContext.font = "16px Arial";
     gContext.fillStyle = '#888888';
     gContext.fillText(message, 10, 25);
     gContext.closePath();
     */
}


function canvasFocus(e)
{
    if(e.type == 'mousedown')
    {
        gCanvas.focus();
        var mousepos=getMousePos(e);
        var message = 'Mouse position: ' + e.clientX + ',' + e.clientY;
        writeMessage(message);
        return false;

    }
    return true;
}



function hasanyleg()
{
    var i;
    for(i=0;i<8;i++)
    {
        if(hasleg[i]==1)
        {
            return 1;
        }
    }
    return 0;
}

function between(a,b1,b2)
{
    var min, max;
    if(b1<b2)
    {
        min = b1;
        max = b2;
    }
    else
    {
        min = b2;
        max = b1;
    }
    if(min<=a && a<=max) {
        return true;
    }
    else
    {
        return false;
    }

}

function willcollidewith(i,character)
{

    var playerrightwall = character.x + character.boxDiameter/2;
    var playerleftwall = character.x - character.boxDiameter/2;
    var playertopwall = character.y - character.boxDiameter/2;
    var playerbottomwall = character.y + character.boxDiameter/2;

    var coliiderleftwall = collider[i][0];
    var coliiderrightwall = collider[i][1];
    var coliidertopwall = collider[i][2];
    var coliiderbottomwall = collider[i][3];

    var collidedist;


    if(between(coliiderbottomwall,
        playertopwall,
        playertopwall + character.movediry * character.speedIncrement
    ))
    {
        collidedist = Math.abs(coliiderbottomwall - playertopwall);
        var collitionxleft= playerleftwall + character.movedirx * collidedist;
        var collitionxright = playerrightwall + character.movedirx * collidedist;
        if(between(collitionxleft,coliiderleftwall,coliiderrightwall)
            ||(between(collitionxright,coliiderleftwall,coliiderrightwall))

            ||(between(coliiderleftwall,collitionxleft,collitionxright))
            ||(between(coliiderrightwall,collitionxleft,collitionxright))
            )
        {
			character.y = coliiderbottomwall + character.boxDiameter/2 +1;
            character.movediry = 1;
            return true;
        }
    }

    else if(between(coliidertopwall,
        playerbottomwall,
        playerbottomwall + character.movediry * character.speedIncrement
    ))
    {
        collidedist = Math.abs(coliidertopwall - playerbottomwall);
        var collitionxleft= playerleftwall + character.movedirx * collidedist;
        var collitionxright = playerrightwall + character.movedirx * collidedist;
        if(between(collitionxleft,coliiderleftwall,coliiderrightwall)
            ||(between(collitionxright,coliiderleftwall,coliiderrightwall))

            ||(between(coliiderleftwall,collitionxleft,collitionxright))
            ||(between(coliiderrightwall,collitionxleft,collitionxright))
            )
        {
			character.y = coliidertopwall - character.boxDiameter/2 -1;
            character.movediry = -1;
            return true;
        }
    }

    else if(between(coliiderleftwall,
        playerrightwall,
        playerrightwall + character.movedirx * character.speedIncrement
    ))
    {
        collidedist = Math.abs(coliiderleftwall - playerrightwall);
        var collitionytop = playertopwall + character.movediry * collidedist;
        var collitionybottom = playerbottomwall + character.movediry * collidedist;
        if(between(collitionytop,coliidertopwall,coliiderbottomwall)
            ||(between(collitionybottom,coliidertopwall,coliiderbottomwall))

            ||(between(coliidertopwall,collitionytop,collitionybottom))
            ||(between(coliiderbottomwall,collitionytop,collitionybottom))
            )
        {
			character.x = coliiderleftwall - character.boxDiameter/2 -1;
            character.movedirx = -1;
            return true;
        }
    }

    else if(between(coliiderrightwall,
        playerleftwall,
        playerleftwall + character.movedirx * character.speedIncrement
    ))
    {
        collidedist = Math.abs(coliiderrightwall - playerleftwall);
        var collitionytop = playertopwall + character.movediry * collidedist;
        var collitionybottom = playerbottomwall + character.movediry * collidedist;
        if(between(collitionytop,coliidertopwall,coliiderbottomwall)
            ||(between(collitionybottom,coliidertopwall,coliiderbottomwall))

            ||(between(coliidertopwall,collitionytop,collitionybottom))
            ||(between(coliiderbottomwall,collitionytop,collitionybottom))
            )
        {
			character.x = coliiderrightwall + character.boxDiameter/2 +1;
            character.movedirx = 1;
            return true;
        }
    }


}

function detectcollition(character)
{

    //gPlayer.x += gPlayer.movedirx * gPlayer.speedIncrement;
    var i,j;
    for(i=0;i<collider.length;i++)
    {
        if(willcollidewith(i,character))
        {
            character.willcollide =1;
            if(collider[i][5]==1)
            {
                character.willcollide = 0;
            }
            if(collider[i][6]==1 && character == gPlayer)
            {
                for(j=0;j<8;j++)
                {
                    hasleg[j] = 0;
                }
            }
            character.collitionwith =i;
            return true;
        }
    }
    return false;

}



function Distancepointline(x, y, x1, y1, x2, y2) {

    var A = x - x1;
    var B = y - y1;
    var C = x2 - x1;
    var D = y2 - y1;

    var dot = A * C + B * D;
    var lensq = C * C + D * D;
    var param = dot / lensq;

    var xx, yy;

    if (param < 0 || (x1 == x2 && y1 == y2)) {
        xx = x1;
        yy = y1;
    }
    else if (param > 1) {
        xx = x2;
        yy = y2;
    }
    else {
        xx = x1 + param * C;
        yy = y1 + param * D;
    }

    var dx = x - xx;
    var dy = y - yy;

    var distance = Math.sqrt(dx * dx + dy * dy);
    writeMessage("Distance is:" + distance);
    return distance;
}

function sqr(x)
{
    return x * x;

}

function Distancepointpoint(x1, y1, x2, y2)
{
    return Math.sqrt(sqr(x1-x2)+sqr(y1-y2));
}



function getclickedleg (x1,y1, isLevelScreen)
{
    if(gPlayer.willcollide==0)
        return -1;
    var theta =0;
    var len = gPlayer.diameter/2 *1.5;
    var len2 = gPlayer.diameter/2 ;

    var i=1;
    for(i=0;i<8;i++)
    {
        if(isLevelScreen==1 || hasleg[i]==1)
        {
            theta= i* Math.PI/4;

            var linestartx = gPlayer.x + len2 * Math.cos(theta);;
            var linestarty = gPlayer.y + len2 * Math.sin(theta);;
            var linestart ={ x:gPlayer.x, y:gPlayer.y};

            var lineendx = gPlayer.x + len * Math.cos(theta);
            var lineendy = gPlayer.y + len * Math.sin(theta);
            var lineend ={x:gPlayer.x, y:gPlayer.y};

            var pointpos = {x:x1,y:y1};



            //if(DistanceFromLine(x1,y1,linestartx, linestarty, lineendx, lineendy) < 5)
            //if(distToSegment(pointpos,linestart,lineend)<5)
            if(Distancepointline(x1,y1,linestartx, linestarty, lineendx, lineendy) < 15 &&
                Distancepointpoint(x1,y1,gPlayer.x,gPlayer.y)>=gPlayer.diameter/2-15)
            {
				if(isLevelScreen != 1)
				{
                    if(spiralClickedTime >= 0)
                    {
                        return -1;
                    }
					hasleg[i] =0;
					gPlayer.willcollide =0;
					//drawPlayer();
					writeMessage('leg ' + i +' clicked');
					gPlayer.movedirx = -legxdir[i];
					gPlayer.movediry = -Legydir[i];

                    playCrySound();
                    winkingtime = 0;
					if(goal.type == 1 && goal.willcollide == 1 && detectcollition(gPlayer)== false)
					{
						goal.willcollide =0;
						goal.movedirx = legxdir[i];
						goal.movediry = Legydir[i];
					}
					return i;
				}
				else
				{
					if(i <= nextLevel)
					{
						return i;
					}
					else
					{
						return -1;
					}
				}               
            }
        }
    }
    return -1;
}

var winkingtime = -1;

function drawcollider(i)
{
    gContext.save();
    gContext.beginPath();
    var topleftx;
    var toplefty;
    var width;
    var height;
    if(collider[i][4]==1)
    {
        topleftx = collider[i][0];
        toplefty = collider[i][2] + (collider[i][3]-collider[i][2]) /4;
        width = (collider[i][1]-collider[i][0]);
        height = (collider[i][3]-collider[i][2])/2;
        


        gContext.lineWidth = 2;
        if(collider[i][5]==0)
        {
			gContext.strokeStyle = 'black';
			gContext.fillStyle = '#555555';
        }
        else
        {
            gContext.strokeStyle = '#555555';
            gContext.fillStyle = 'black';
        }
        if(collider[i][6]==1)
        {
            gContext.shadowOffsetX = 0;
            gContext.shadowOffsetY = 0;
            gContext.shadowBlur = 4;
            gContext.shadowColor = '#888888';
        }
		gContext.fillRect(topleftx, toplefty, width, height);
		gContext.strokeRect(topleftx, toplefty, width, height);
		

        var j;
		gContext.strokeStyle = '#000000';
		gContext.fillStyle = '#000000';
        for(j=topleftx +10; j<=topleftx + width -5; j+=20)
        {
			if(collider[i][6]==0)
			{
				gContext.moveTo(j,collider[i][2]-1);
				gContext.lineTo(j,collider[i][3]+1);
			}
			else
			{
				var polyX = [j-2,j+2,j];
				var polyY = [collider[i][2]+2,collider[i][2]+2,collider[i][2]-5];
				drawPolygon(polyX,polyY);				
				gContext.stroke();				
				gContext.fill();
				
				polyX = [j-2,j+2,j];
				polyY = [collider[i][3]-2,collider[i][3]-2,collider[i][3]+5];
				drawPolygon(polyX,polyY);				
				gContext.stroke();
				gContext.fill();
			}
        }
        gContext.stroke();
    }
    else
    {
        topleftx = collider[i][0] + (collider[i][1]-collider[i][0]) /4;
        toplefty = collider[i][2];
        width = (collider[i][1]-collider[i][0])/2;
        height = (collider[i][3]-collider[i][2]);
        

        gContext.lineWidth = 2;
        if(collider[i][5]==0)
        {
			gContext.strokeStyle = 'black';
			gContext.fillStyle = '#555555';
        }
        else
        {
            gContext.strokeStyle = '#555555';
            gContext.fillStyle = 'black';
        }
		
        if(collider[i][6]==1)
        {
            gContext.shadowOffsetX = 0;
            gContext.shadowOffsetY = 0;
            gContext.shadowBlur = 4;
            gContext.shadowColor = '#888888';
        }
		gContext.fillRect(topleftx, toplefty, width, height);
		gContext.strokeRect(topleftx, toplefty, width, height);
		
		
        var j;
		gContext.strokeStyle = '#000000';
		gContext.fillStyle = '#000000';
        for(j=toplefty +10; j<=toplefty + height -5; j+=20)
        {
			if(collider[i][6]==0)
			{
				gContext.moveTo(collider[i][0]-1,j);
				gContext.lineTo(collider[i][1]+1,j);
			}
			else
			{
				var polyY = [j-2,j+2,j];
				var polyX = [collider[i][0]+2,collider[i][0]+2,collider[i][0]-7];
				drawPolygon(polyX,polyY);				
				gContext.stroke();				
				gContext.fill();
				
				polyY = [j-2,j+2,j];
				polyX = [collider[i][1]-2,collider[i][1]-2,collider[i][1]+7];
				drawPolygon(polyX,polyY);				
				gContext.stroke();
				gContext.fill();
			}
        }
        gContext.stroke();

    }

    gContext.closePath();
    gContext.restore();
}

function drawColliders()
{
    var i,j;
    for(i=0;i<collider.length;i++)
    {
        drawcollider(i);
    }
}

function playSound(filename/*,duration*/)
{
    var a = document.createElement('audio');
    a.id ='bgsound';
    a.src = filename;
    document.body.appendChild(a);
    a.addEventListener('ended', function() {
        this.currentTime = 0;
        this.play();
    }, false);
    a.volume = 1;
    a.play();
    /*
     setTimeout(function() {
     document.body.removeChild(a);
     },duration);
     */
}

function playCrySound()
{

    document.body.appendChild(gpainaudio);
    gpainaudio.play();

    /*setTimeout(function()
    {
        //gpainaudio.stop();
        document.body.removeChild(gpainaudio);
    },2000);*/

}
var imageObj = new Image();
function redrawAll()
{
    if(firstTimeInALevel == 1)
    {
		gContext.globalAlpha = 1;
        var tempContext = gContext;
		
		gContext = backgroundContext;
		
		gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
		
        gContext.fillStyle='#151515';
        gContext.fillRect(mainScreenBoundaryX,0,200,gCanvas.height);
        
       

        drawline(mainScreenBoundaryX-3,0,mainScreenBoundaryX-3,gCanvas.height,'#000000');
        drawline(mainScreenBoundaryX,0,mainScreenBoundaryX,gCanvas.height,'#000000');
        drawHelpBorder();
        drawReloadButton();
        drawCrossButton();
        drawHelpText(HelpText[currentlevel]);

        
        gContext.clearRect(0,0,mainScreenBoundaryX,gCanvas.height);
        gContext.fillStyle=bgcolor;
        gContext.fillRect(0,0,mainScreenBoundaryX,gCanvas.height);
        
        
        if(bgLoaded == 0)
        {
        	imageObj.src = './Background/' + (currentlevel + 1) + '.jpg';
			
			imageObj.onload = function()
			{
				firstTimeInALevel = 1;
				bgLoaded = 1;
				//alert('image loaded');
			};
			
        }
        gContext.drawImage(imageObj, 0, 0);	
		

        drawColliders();
        drawLevelTitle(LevelTitle[currentlevel]);
        if(goal.type == 0)
        {
            drawSpiderWeb(goal.x,goal.y);
        }
        drawUpBorder();
        gContext = tempContext;
        firstTimeInALevel = 0;
        		
    }


    gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
    gContext.globalAlpha = 0;
    gContext.fillStyle=bgcolor;
    gContext.fillRect(0,0,gCanvas.width,gCanvas.height);
    gContext.globalAlpha = 1;
    if(goal.type == 1)
    {
        drawSpiderWeb(goal.x,goal.y);
    }
    drawPlayer();
	//drawStickFigure(300,300);
    drawBottles();
    drawLegIndicator();
    drawBubbles();
}


function drawBubbles()
{
	gContext.save();
	gContext.strokeStyle = '#000000';
	gContext.shadowOffsetX = 0;
    gContext.shadowOffsetY = 0;
    gContext.shadowBlur = 4;
    gContext.shadowColor = '#dddddd';
    gContext.strokeStyle = '#eeeeee';
	//gContext.fillStyle = '#eeeeee';*/
	for(var i=0; i<15; i++)
	{
		var bubbleRadius = 3;
		
		gContext.lineWidth = 2;
		
		var x = bubbleArray[i].x;
		var y = bubbleArray[i].y;
		var x1 = x;
		var y1 = y;
		
		if(mousex != x)
	    {
	         x1 = x + 2*(mousex - x)/Math.abs((mousex - x));
	    }
	   
	
	    if(mousey != y)
	    {
	         y1 = y + 2*(mousey - y)/Math.abs((mousey - y));
	    }


        if(bubbleArray[i].time%5 == 0)
        {
            gContext.shadowColor = "rgb("+(bubbleArray[i].time*1 + 70)+ "," +(bubbleArray[i].time*1 + 70) + "," + (bubbleArray[i].time*1 + 70)+")";



            bubleGrdArray1[i]=gContext.createRadialGradient(x1-bubbleRadius, y1, bubbleRadius*.5 , x1-bubbleRadius, y1, bubbleRadius);
            bubleGrdArray1[i].addColorStop(0,"#000000");
            bubleGrdArray1[i].addColorStop(1,"rgb("+(bubbleArray[i].time*1 + 50)+ "," +(bubbleArray[i].time*1 + 50) + "," + (bubbleArray[i].time + 50)+")");

            bubleGrdArray2[i]=gContext.createRadialGradient(x1+bubbleRadius, y1, bubbleRadius*.5 , x1+bubbleRadius, y1, bubbleRadius);
            bubleGrdArray2[i].addColorStop(0,"#000000");
            bubleGrdArray2[i].addColorStop(1,"rgb("+(bubbleArray[i].time*1 + 50)+ "," +(bubbleArray[i].time*1 + 50) + "," + (bubbleArray[i].time + 50)+")");
        }

		
		bubbleArray[i].time --;


        //if(bubbleArray[i].time%5 == 0)
        {
            if (x % 5 != 0) {
                gContext.fillStyle = bubleGrdArray1[i];
                gContext.beginPath();
                gContext.arc(x - bubbleRadius, y, bubbleRadius, 0, 2 * Math.PI, false);
                //gContext.stroke();
                gContext.fill();
                gContext.fillStyle = bubleGrdArray2[i];
                gContext.closePath();
                gContext.beginPath();
                gContext.arc(x + bubbleRadius, y, bubbleRadius, 0, 2 * Math.PI, false);
                //gContext.stroke();
                gContext.fill();
                gContext.closePath();
            }
            else {
                gContext.fillStyle = bubleGrdArray1[i];
                polyX = [x - bubbleRadius, x - bubbleRadius * 2, x];
                polyY = [y + bubbleRadius, y - bubbleRadius, y - bubbleRadius];
                drawPolygon(polyX, polyY);
                gContext.fill();

                gContext.fillStyle = bubleGrdArray2[i];
                polyX = [x + bubbleRadius, x + bubbleRadius * 2, x];
                polyY = [y + bubbleRadius, y - bubbleRadius, y - bubbleRadius];
                drawPolygon(polyX, polyY);
                gContext.fill();
            }
        }
    	
	    
	    /*gContext.fillStyle = "rgb("+(40)+ "," +(40) + "," + (40)+")";
	    gContext.beginPath();
	    gContext.arc(x-bubbleRadius/2, y, bubbleRadius/2, 0, 2 * Math.PI, false);	
	    gContext.stroke();	
	    gContext.fill();
	    gContext.closePath();
	    gContext.beginPath();
	    gContext.arc(x+bubbleRadius/2, y, bubbleRadius/2, 0, 2 * Math.PI, false);	
	    gContext.stroke();	
	    gContext.fill();
	    gContext.closePath();*/
	    
	    
	    
	    if(bubbleArray[i].time <= 0 || 
	    	(Math.sqrt(sqr(gPlayer.x - x)+ sqr(gPlayer.y -y)) <= gPlayer.boxDiameter/2)||
	    	(Math.sqrt(sqr(mousex - x)+ sqr(mousey -y)) <= gPlayer.boxDiameter/2)
	    	)
	    {
	    	var bubble = {x: Math.floor(Math.random() * 600), y: Math.floor(100 + Math.random()* 500), time: Math.floor(Math.random()* 20)*10};
			bubbleArray[i] = bubble;
	    }
		
	}
	gContext.restore();
}

function drawLevelInitScreen(level)
{
	if(firstTimeInInitLevel == 1)
    {
		gContext.globalAlpha = 1;
		var tempContext = gContext;
		
		gContext = backgroundContext;
		
		gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
		
		gContext.fillStyle='#151515';
		gContext.fillRect(mainScreenBoundaryX,0,200,gCanvas.height);

		drawline(mainScreenBoundaryX-3,0,mainScreenBoundaryX-3,gCanvas.height,'#000000');
		drawline(mainScreenBoundaryX,0,mainScreenBoundaryX,gCanvas.height,'#000000');
		drawHelpBorder();
		drawReloadButton();
		drawCrossButton();
		drawHelpText(HelpText[currentlevel]);

		
		gContext.clearRect(0,0,mainScreenBoundaryX,gCanvas.height);
		gContext.fillStyle=bgcolor;
		gContext.fillRect(0,0,mainScreenBoundaryX,gCanvas.height);

		drawColliders();
		drawLevelTitle(LevelTitle[currentlevel]);
		
		drawSpiderWeb(goal.x,goal.y);
		
		drawUpBorder();
		
		drawPlayer();
		drawBottles();
		drawLegIndicator();
		
		gContext = tempContext;
			
			
		gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
		gContext.globalAlpha = .5;
		gContext.fillStyle=bgcolor;
		gContext.fillRect(0,0,gCanvas.width,gCanvas.height);
		
		gContext.fillStyle='#888888';
		gContext.fillRect(0,200,gCanvas.width,160);
		
		gContext.globalAlpha = 1;
		var imageWidth = 180;
		var numImages = nLevelInitScreenImage[currentlevel];
		var ImageStartPos = (gCanvas.width - numImages*imageWidth)/2;
		var i;
		var imageObj = new Array(numImages);
		for(i=0; i<numImages; i++)
		{
			/*var oFReader = new FileReader();
			imageObj[i] = new Image();
			oFReader.readAsDataURL('./'+currentlevel+''+i+'.png');

			oFReader.onload = function (oFREvent) {
				imageObj[i].src = oFREvent.target.result;
			};*/
		
			imageObj[i] = new Image();
			imageObj[i].src = './'+currentlevel+''+i+'.png';
			
			imageObj[i].onload = function()
			{
				firstTimeInInitLevel = 1;
			};
			gContext.drawImage(imageObj[i], ImageStartPos + i*imageWidth, 202);
			
			
		}
		
		firstTimeInInitLevel = 0;
	}
    /*var imageObj = new Image();


    imageObj.onload = function()
    {
        gContext.drawImage(imageObj, 300, 300);
    };
    imageObj.src = 'icon.png';*/
}

function drawLevelScreen()
{

	if(firstTimeInLevelScreen == 1)
    {
		gContext.globalAlpha = 1;
		var tempContext = gContext;
		
		gContext = backgroundContext;
		
		gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
		
		gContext.fillStyle='#151515';
		gContext.fillRect(mainScreenBoundaryX,0,200,gCanvas.height);

		drawline(mainScreenBoundaryX-3,0,mainScreenBoundaryX-3,gCanvas.height,'#000000');
		drawline(mainScreenBoundaryX,0,mainScreenBoundaryX,gCanvas.height,'#000000');
		drawHelpBorder();
		drawReloadButton();
		drawCrossButton();
		var HelpText = '\n\n1. Currently there are only eight levels. If you guys like my game, the full version will ' +
            'contain many more levels as well as a back story and a scoring system. Enjoy :-)\n\n';
		drawHelpText(HelpText);

		gContext.clearRect(0,0,mainScreenBoundaryX,gCanvas.height);
		gContext.fillStyle=bgcolor;
		gContext.fillRect(0,0,mainScreenBoundaryX,gCanvas.height);

		gPlayer.x = mainScreenBoundaryX/2;
		gPlayer.y = 70+ (gCanvas.height - 70)/2 -20;

		gPlayer.diameter = 120;
		gPlayer.boxDiameter = 180;
		drawUpBorder();
		drawPlayer('grey');
		
		var len = gPlayer.diameter/2 *1.7;
		for(i=0;i<8;i++)
		{
			var theta= i* Math.PI/4;
			var letterX = gPlayer.x + len * Math.cos(theta);
			var letterY = gPlayer.y + len * Math.sin(theta);
			
			if(i<=nextLevel)
			{
				wrapText(gContext,''+ (i+1),letterX,letterY, 500, 200, 'centre','8px Gretoon');
			}
			else
			{
				wrapText(gContext,''+ (i+1),letterX,letterY, 500, 200, 'centre','8px Gretoon','black');
			}
		}
		
		gContext = tempContext;
		
		gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
		gContext.globalAlpha = 0;
		gContext.fillStyle=bgcolor;
		gContext.fillRect(0,0,gCanvas.width,gCanvas.height);
		gContext.globalAlpha = 1;
		
		firstTimeInLevelScreen = 00;
	}
}

function drawStartScreen()
{
    gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
    gContext.fillStyle='#222222';


    gPlayer.x = gCanvas.width/2;
    gPlayer.y = gCanvas.height/2 -20;
    gContext.fillRect(0,0,gCanvas.width,gCanvas.height);
    drawPlayer();
    if(gPlayer.diameter<=110 || gPlayer.diameter>=130)
    {
        heightinc*=-1;
    }
    wrapText(gContext,"Save The Last Spider",gCanvas.width/2-70,gCanvas.height/2+100, 500, 200, 'centre');

    gContext.strokeStyle = '#444444';
    gContext.strokeRect(gCanvas.width/2-70,gCanvas.height/2+120,140,20);
    wrapText(gContext,"Old Game",gCanvas.width/2-20,gCanvas.height/2+132, 500, 200, 'centre','10px Gretoon');
    gContext.strokeRect(gCanvas.width/2-70,gCanvas.height/2+145,140,20);
    wrapText(gContext,"New Game",gCanvas.width/2-22,gCanvas.height/2+157, 500, 200, 'centre','10px Gretoon');
    gContext.strokeRect(gCanvas.width/2-70,gCanvas.height/2+170,140,20);
    wrapText(gContext,"Levels",gCanvas.width/2-13,gCanvas.height/2+182, 500, 200, 'centre','10px Gretoon');
    gPlayer.diameter += heightinc;


}



function changePosition(character)
{


    detectcollition(character);
    if(character.willcollide == 0)
    {

        if (character.x + character.movedirx * character.speedIncrement - character.boxDiameter/2 >= 15 &&
            character.x + character.movedirx * character.speedIncrement + character.boxDiameter/2  <= mainScreenBoundaryX-15)
        {
            character.x += character.movedirx * character.speedIncrement;
        }
        else
        {
			if(character.x + character.movedirx * character.speedIncrement - character.boxDiameter/2 < 0)
			{
				character.x = 15 + character.boxDiameter/2;
			}
			if(character.x + character.movedirx * character.speedIncrement + character.boxDiameter/2  > mainScreenBoundaryX-15)
			{
				character.x = mainScreenBoundaryX - character.boxDiameter/2 -15;
			}
            character.willcollide=1;
            character.movedirx=0;
            character.movediry=0;

        }
        if (character.y + character.movediry * character.speedIncrement -  character.boxDiameter/2 >= 80 &&
            character.y + character.movediry * character.speedIncrement +  character.boxDiameter/2 <= gCanvas.height -10)
        {
            character.y += character.movediry * character.speedIncrement;
        }
        else
        {
			if(character.y + character.movediry * character.speedIncrement -  character.boxDiameter/2 < 80)
			{
				character.y = 80 + character.boxDiameter/2;
			}
			if(character.y + character.movediry * character.speedIncrement +  character.boxDiameter/2 > gCanvas.height -10 )
			{
				character.y = gCanvas.height - character.boxDiameter/2 -10;
			}
            character.willcollide=1;
            character.movedirx=0;
            character.movediry=0;
        }

    }
    else
    {
        character.movedirx=0;
        character.movediry=0;
    }


}

function drawSpiderWeb(x,y)
{
    gContext.save();
    var len = goal.boxDiameter/2;
    var i, theta;
    var ninety = Math.PI/2;
    var twoseventy = 3*Math.PI/2;
    gContext.beginPath();
    gContext.lineWidth = 2;
    var color;
    if(goal.type === 0)
    {
        color = '#ffffff';
    }
    else
    {
        color = '#555555';
        gContext.shadowOffsetX = 0;
        gContext.shadowOffsetY = 0;
        gContext.shadowBlur = 4;
        gContext.shadowColor = '#E1A7C0';
    }
    for(i=0;i<5;i++)
    {
        //if(hasleg[i]==1)
        {
            theta= i* 2*Math.PI/5;

            drawlineNoStroke(x + len *.3 * Math.cos(theta), y + len *.3 * Math.sin(theta),
                    x + len * Math.cos(theta), y + len * Math.sin(theta),
                color);

            var j, theta2;
            theta2 = theta + Math.PI/5;
            for(j=1;j<5;j++)
            {
                var midx = x + j*len/6.25 * Math.cos(theta2);
                var midy = y + j*len/6.25 * Math.sin(theta2);
                drawlineNoStroke(midx + len/6.25*(j) * Math.cos(ninety+theta2), midy + len/6.25*(j) * Math.sin(ninety+theta2),
                        midx + len/6.25*(j) * Math.cos(twoseventy+theta2), midy + len/6.25*(j) * Math.sin(twoseventy+theta2),
                    color);
            }

        }

    }

    gContext.closePath();

    gContext.stroke();


    gContext.restore();

}



function isPlayerInGoal()
{
    if(levelType == UseAllYourLegs)
    {
        if(hasanyleg())
        {
            return false;
        }
    }
    if(Math.sqrt(sqr(gPlayer.x-goal.x)+sqr(gPlayer.y-goal.y))<goalDistance)
    {
        return true;
    }
    return false;
}

function drawEndLevel()
{
    gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
    gContext.fillStyle='#000000';
    var text = "Home, Sweet Home :-)";

    gContext.fillRect(0,0,gCanvas.width,gCanvas.height);
    wrapText(gContext,text,gCanvas.width/2-100, gCanvas.height/2,gCanvas.width,30,"centre");

}


function drawEllipse(ctx, x, y, w, h)
{
    var kappa = .5522848,
        ox = (w / 2) * kappa, // control point offset horizontal
        oy = (h / 2) * kappa, // control point offset vertical
        xe = x + w,           // x-end
        ye = y + h,           // y-end
        xm = x + w / 2,       // x-middle
        ym = y + h / 2;       // y-middle

    ctx.beginPath();
    ctx.moveTo(x, ym);
    ctx.bezierCurveTo(x, ym - oy, xm - ox, y, xm, y);
    ctx.bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym);
    ctx.bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye);
    ctx.bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym);
    //ctx.closePath(); // not used correctly, see comments (use to close off open path)
    ctx.stroke();
}

function drawEllipseByCenter(ctx, cx, cy, w, h)
{
    drawEllipse(ctx, cx - w/2.0, cy - h/2.0, w, h);
}
function drawline (startx, starty, endx, endy, color)
{
    gContext.beginPath();
    gContext.moveTo(startx,starty);
    gContext.lineTo(endx,endy);
    gContext.strokeStyle = color;
    gContext.stroke();
    gContext.closePath();
}

function drawlineNoStroke (startx, starty, endx, endy, color)
{

    gContext.moveTo(startx,starty);
    gContext.lineTo(endx,endy);
    gContext.strokeStyle = color;
}

function drawEye(xloc, yloc, i,rad)
{

    if(mousex != xloc)
    {
        var xlocgrd = xloc + 2*(mousex - xloc)/Math.abs((mousex - xloc));
    }
    else
    {
        var xlocgrd = xloc;
    }

    if(mousey != yloc)
    {
        var ylocgrd = yloc + 2*(mousey - yloc)/Math.abs((mousey - yloc));
    }
    else
    {
        var ylocgrd = yloc;
    }
      
	if(levelType == RaceAgainstTime)
	{
		var grd2=gContext.createRadialGradient(xlocgrd, ylocgrd, gPlayer.diameter *.5*rad,xloc,yloc,gPlayer.diameter*rad );
		grd2.addColorStop(0,"#111111");
		grd2.addColorStop(1,"#ffffff");

		var grd3=gContext.createRadialGradient(xlocgrd, ylocgrd, gPlayer.diameter *.7*rad,xloc,yloc,gPlayer.diameter*rad );
		grd3.addColorStop(0,"#111111");
		grd3.addColorStop(1,"#ffffff");
	}
	else
	{
		var grd2=gContext.createRadialGradient(xlocgrd, ylocgrd, gPlayer.diameter *.5*rad,xloc,yloc,gPlayer.diameter*rad );
		grd2.addColorStop(0,"#111111");
		grd2.addColorStop(1,"#e4e990");

		var grd3=gContext.createRadialGradient(xlocgrd, ylocgrd, gPlayer.diameter *.7*rad,xloc,yloc,gPlayer.diameter*rad );
		grd3.addColorStop(0,"#111111");
		grd3.addColorStop(1,"#e4e990");
	}


	
    gContext.beginPath();
	if(levelType == RaceAgainstTime)
	{
		drawEllipseByCenter(gContext,xloc,yloc,gPlayer.diameter *1.5*rad,gPlayer.diameter *2*rad);
	}
	else
	{
		polyX = [xloc - gPlayer.diameter *1.5 *rad/2, xloc + gPlayer.diameter *1.5 *rad/2, xloc];
		polyY = [yloc - gPlayer.diameter *1.5 *rad/2, yloc - gPlayer.diameter *1.5 *rad/2, yloc + gPlayer.diameter *1.5*rad/2];
		drawPolygon(polyX,polyY);
		gContext.lineWidth = 2;
		gContext.strokeStyle = 'black';
		gContext.stroke();
	}
    gContext.lineWidth = 1;
    if(winkingtime<0)
    {
        gContext.fillStyle = grd2;//'#ffffff';
    }
    else
    {
        gContext.fillStyle = grd3 //'#bbbbbb';
    }
    gContext.fill();
    gContext.closePath();
}

var stickAngle = -1.5;
var stickAngleSpeed = -1; 
var stickAngle2 = -1;
var stickAngleSpeed2 = -1;
function drawStickFigure(x,y)
{
	gContext.save();
	var headRadius = 10;
	gContext.strokeStyle = '#000000';
	gContext.fillStyle = '#000000';
	gContext.lineWidth = 1;
	
	gContext.shadowOffsetX = 0;
    gContext.shadowOffsetY = 0;
    gContext.shadowBlur = 4;
    gContext.shadowColor = '#dddddd';
	
	
	//Head
	gContext.beginPath();
    gContext.arc(x, y, headRadius, 0, 2 * Math.PI, false);	
    gContext.stroke();	
    //gContext.fill();
    gContext.closePath();
	
	//Body
	gContext.moveTo(x, y + headRadius);
    gContext.lineTo(x - headRadius, y + headRadius * 5);
	gContext.stroke();
	
	//Left Hand
	gContext.save();
	gContext.translate(x, y + headRadius);
	gContext.rotate(stickAngle + Math.PI / 4);
	
	gContext.moveTo(0, 0);
	gContext.lineTo(0, headRadius * 3);
	gContext.stroke();
	
	gContext.save();
	gContext.translate(0, headRadius * 3);
	gContext.moveTo(0, 0);
	gContext.lineTo(headRadius * 3, 0);
	gContext.stroke();
	gContext.restore();
	
	gContext.restore();
	
	//Right Hand
	gContext.save();
	gContext.translate(x, y + headRadius);
	gContext.rotate(stickAngle2 + Math.PI / 4);
	
	gContext.moveTo(0, 0);
	gContext.lineTo(0, headRadius * 3);
	gContext.stroke();
	
	gContext.save();
	gContext.translate(0, headRadius * 3);
	gContext.moveTo(0, 0);
	gContext.lineTo(headRadius * 3, 0);
	gContext.stroke();
	gContext.restore();
	
	gContext.restore();
	
	if (stickAngle >= 0 || stickAngle <= -2)
	{
		stickAngleSpeed*=-1;
	}
	stickAngle += stickAngleSpeed*.2;
	
	if (stickAngle2 >= 0 || stickAngle2 <= -2)
	{
		stickAngleSpeed2*=-1;
	}
	stickAngle2 += stickAngleSpeed2*.2;
	
	gContext.restore();
}

function drawPlayer(color)
{

    gContext.save();



    gContext.lineWidth = 3;
    gContext.moveTo(gPlayer.x, gPlayer.y);
    var i=0;
    var j=0;

    gContext.shadowOffsetX = 0;
    gContext.shadowOffsetY = 0;
    gContext.shadowBlur = 6;
    gContext.shadowColor = '#ffffff';
    gContext.strokeStyle = '#000000';
    gContext.fillStyle = '#000000';

	
	var len = gPlayer.diameter/2 *1.7;
    if(spiralClickedTime >= 45)
    {
        var temp = hasleg[7];
        for(var i=7;i>=0;i--)
        {
            hasleg[i]=hasleg[i-1];
        }
        hasleg[0]=temp;
        spiralClickedTime = -1;
    }
    var inittheta = 0;
    if(spiralClickedTime >= 0)
    {
        inittheta = spiralClickedTime;
        spiralClickedTime += 3;
    }
    for(i=0;i<8;i++)
    {
        if(hasleg[i]==1)
        {
            var theta= inittheta*Math.PI/180 + i* Math.PI/4;

            gContext.save();
            gContext.translate(gPlayer.x, gPlayer.y);
            gContext.rotate(theta);
            gContext.translate(gPlayer.diameter/2, 0);
            var polyX =[0, 0, len-gPlayer.diameter/2];
            var polyY =[2,-2,0];
            drawPolygon(polyX,polyY);
            gContext.stroke();
            gContext.fill();
            /*gContext.moveTo(0, 0);
            gContext.lineTo(len-gPlayer.diameter/2, 0);
            gContext.stroke();*/
            gContext.restore();
            //gContext.moveTo(gPlayer.x, gPlayer.y);
            //gContext.lineTo(gPlayer.x + len * Math.cos(theta), gPlayer.y + len * Math.sin(theta));
        }

    }

    //gContext.stroke();


    gContext.restore();

    gContext.save();


    gContext.beginPath();
    gContext.lineWidth = 3;
    /*gContext.shadowOffsetX = 0;
    gContext.shadowOffsetY = 0;
    gContext.shadowBlur = 6;
    gContext.shadowColor = '#ffffff';
    gContext.strokeStyle = '#000000';*/

    drawSpiderBody(gContext,gPlayer.x,gPlayer.y,gPlayer.diameter/2  - gContext.lineWidth,color);


    gContext.strokeStyle = '#000000';
    gContext.stroke();
    gContext.closePath();




    for(i=-1;i<=1;i+=2)
    {
        var xloc = gPlayer.x + gPlayer.diameter/2 *.4*i;
        var yloc = gPlayer.y - gPlayer.diameter/2 *.8;

        drawEye(xloc,yloc,i,.2);
    }

    gContext.restore();

}

function drawLegIndicator()
{
	if(levelType == RaceAgainstTime)
	{
		var  x=550,y=38;

		gContext.save();

		gContext.shadowOffsetX = 1;
		gContext.shadowOffsetY = 1;
		gContext.shadowBlur = 2;
		gContext.shadowColor = '#4d4d4d';


		var len = gPlayer.diameter * .8;

		var innerCircleRatio = .5;

		gContext.beginPath();
		gContext.arc(x, y, len/2, 0, 2 * Math.PI, false);


		gContext.fillStyle='#999999';
		gContext.fill();

		gContext.lineWidth = 2;
		gContext.strokeStyle='black';

		gContext.stroke();

		gContext.closePath();

		gContext.beginPath();

		gContext.arc(x, y, len/2 *innerCircleRatio, 0, 2 * Math.PI, false);
		gContext.fillStyle='#666666';
		gContext.fill();
		gContext.stroke();

		gContext.closePath();




		gContext.beginPath();
		gContext.lineWidth = 2;

		for(var i=0;i<8;i++)
		{
			if(hasleg[i]==1)
			{
				var theta= i* Math.PI/4;
				gContext.moveTo(x + len/2 *innerCircleRatio * Math.cos(theta),  y + len/2 *innerCircleRatio * Math.sin(theta));

				if(i==nextleg)
				{
					gContext.lineTo(x + len/2 * Math.cos(theta)* (innerCircleRatio + (nextlegtime*.0001*gNextLegTime *(1-innerCircleRatio))),
							y +  len/2 * Math.sin(theta)*(innerCircleRatio+ (nextlegtime*.0001*gNextLegTime *(1-innerCircleRatio))));
				}
				else
				{
					gContext.lineTo(x + len/2 * Math.cos(theta), y + len/2 * Math.sin(theta));
				}
			}
		}

		gContext.strokeStyle = 'black';
		gContext.stroke();
		gContext.closePath();

		gContext.restore();
	}	

}

function canvasKeyDown(e)
{
    if(gKeys.indexOf(e.keyCode) == -1)
        gKeys.push(e.keyCode);
    return false;
}

function canvasKeyUp(e)
{
    deletearray(e.keyCode,gKeys);
    return false;
}

function deletearray(needle, haystack)
{
    var i = 0;
    var Size = haystack.length
    for(i; i < Size; ++i)
    {
        if(haystack[i] == needle) {
            haystack.splice(i,1);
            return haystack;
        }
    }
    return haystack;
}