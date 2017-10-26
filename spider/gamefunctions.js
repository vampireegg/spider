window.onload = function() {
    initGame();
}
var gCanvas = null;
var gContext = null;
var gKeys = [];
var bgcolor = '#222222';
var mousex =-100;
var mousey=-100;
var MaxLevel = 3;
var nextLevel = 0;

var goalX, goalY;
var endLevelTimer = 100;

var mainScreenBoundaryX = 615;


var gPlayer = {x:80,y:200,speed:0,speedMax:5,speedIncrement:10,height:110,width:110,boxheight:90,boxwidth:90};

var StartScreen=0, ChooseLevel=1, InLevel=2, EndLevel=3;
var gamePhase = 0; //0=StartScreen, 1=chooseLevel, 2=InLevel, 3=EndLevel


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

        if(mousex >= gCanvas.width/2-70 && mousex <= gCanvas.width/2-70+140
            && mousey >= gCanvas.height/2+120 && mousey <= gCanvas.height/2+120+20)
        {
            nextLevel = Number(localStorage.getItem("level"));
            if(nextLevel == NaN)
            {
                nextLevel =0;
            }
            gamePhase = InLevel;
            heightinc = -1;
            initLevel(nextLevel);
            return false;
        }
        else if(mousex >= gCanvas.width/2-70 && mousex <= gCanvas.width/2-70+140
            && mousey >= gCanvas.height/2+145 && mousey <= gCanvas.height/2+145+20)
        {
            localStorage.removeItem("level");
            nextLevel = 0;
            gamePhase = InLevel;
            heightinc = -1;
            nextLevel = 0;
            initLevel(nextLevel);
            return false;
        }
        else if(Math.sqrt(sqr(mousex - gCanvas.width/2) + sqr(mousey - gCanvas.height/2)) < 160)
        {
            gamePhase = InLevel;
            heightinc = -1;
            initLevel(nextLevel);
            return false;
        }
    }
    else if(gamePhase == InLevel)
    {
        if(Math.sqrt(sqr(mousex - reloadX) + sqr(mousey - reLoady)) < 20)
        {
            initLevel(nextLevel);
            return false;
        }
        if(Math.sqrt(sqr(mousex - crossX) + sqr(mousey - crossY)) < 20)
        {
            gPlayer.height = 110;
            hasleg = [1,1,1,1, 1,1,1,1];
            gamePhase = StartScreen;
            return false;
        }
    }


    getclickedleg (mousex,mousey);
    return false;
}

var reloadX = 750, reLoady = 45;
function drawReloadButton()
{

    var x = reloadX, y = reLoady;
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

var crossX = 660, crossY = 45;
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
    localStorage.setItem("level", level);
    gPlayer.width =70;
    gPlayer.height =70;
    gContext.fillStyle='#151515';
    gContext.fillRect(mainScreenBoundaryX,0,200,gCanvas.height);



    drawline(mainScreenBoundaryX-3,0,mainScreenBoundaryX-3,gCanvas.height,'#000000');
    drawline(mainScreenBoundaryX,0,mainScreenBoundaryX,gCanvas.height,'#000000');
    drawHelpBorder();
    drawReloadButton();
    drawCrossButton();
    drawHelpText(HelpText[level]);

    hasleg = [1,1,1,1, 1,1,1,1];

    nextlegtime = 100;

    willcollide = 1;

    if(level ==0)
    {
        nextleg =0;
        gPlayer.x = 80;
        gPlayer.y = 200;
        collider = [[10,400,260,270,1,0]];
        goalX=550;
        goalY=550;
    }

    if(level ==1)
    {
        nextleg =0;
        gPlayer.x = 80;
        gPlayer.y = 200;
        collider = [[10,200,260,270,1,0] , [300,590,400,410,1,0]];
        goalX=550;
        goalY=550;
    }
    if(level == 2)
    {
        nextleg = 2;
        gPlayer.x = 80;
        gPlayer.y = 300;
        collider = [[10,300,360,370,1,0] , [310,320,180,370,2,1], [10,200,160,170,1,0], [150,590,480,490,1,0]];
        goalX=50;
        goalY=550;
    }
    if(level == 3)
    {
        nextleg = 2;
        gPlayer.x = 155;
        gPlayer.y = 535;
        collider = [[247,257,325,590,2,1]];
        goalX=365;
        goalY=450;
    }
}

var gpainaudio;

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


function drawSpiderBody(context,x,y, radius)
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


    var myYellow = '#F2FA82';

    // draw yellow circle inside clipping region
    context.beginPath();
    context.arc(x , y, radius, 0, 2 * Math.PI, false);
    context.fillStyle = myYellow;
    context.fill();

    // draw red circle inside clipping region
    context.beginPath();
    context.arc(x, y - radius *.3, radius, 0, 2 * Math.PI, false);
    context.fillStyle = '#111111';
    context.fill();

    // draw blue circle inside clipping region
    context.beginPath();
    context.arc(x, y - radius *.5, radius, 0, 2 * Math.PI, false);
    context.fillStyle = myYellow;
    context.fill();

    // draw blue circle inside clipping region
    context.beginPath();
    context.arc(x, y - radius*1, radius , 0, 2 * Math.PI, false);
    context.fillStyle = '#111111';
    context.fill()

    // draw blue circle inside clipping region
    context.beginPath();
    context.arc(x, y - radius*1.2, radius , 0, 2 * Math.PI, false);
    context.fillStyle = myYellow;
    context.fill()


    // draw blue circle inside clipping region
    context.beginPath();
    context.arc(x, y - radius*1.5, radius *.9 , 0, 2 * Math.PI, false);
    context.fillStyle = '#111111';
    context.fill()

    // draw blue circle inside clipping region
    context.beginPath();
    context.arc(x, y - radius*1.65, radius *.9 , 0, 2 * Math.PI, false);
    context.fillStyle = myYellow;
    context.fill()

    /*
     * restore() restores the canvas context to its original state
     * before we defined the clipping region
     */
    context.restore();
    context.beginPath();
    context.arc(x, y, radius, 0, 2 * Math.PI, false);
    context.lineWidth = 1;
    context.strokeStyle = 'blue';
    context.stroke();
}


function drawBottle(i,x,y,doRotate)
{
    if(i==0)
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
        gContext.stroke();

        gContext.restore();

        var polyX =[x-2*Shrinkfactor*ctheta,x-6*Shrinkfactor*ctheta,x+6*Shrinkfactor*ctheta,x+2*Shrinkfactor*ctheta];
        var polyY =[y-28*Shrinkfactor*ctheta,y-20*Shrinkfactor*ctheta,y-20*Shrinkfactor*ctheta,y-28*Shrinkfactor*ctheta];
        drawPolygon(polyX,polyY);

        gContext.strokeStyle = '#000000';
        gContext.stroke();

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
}



function drawBottles()
{
    var i;
    for(i=0;i<bottleexist.length;i++)
    {
        if(bottleexist[i]==1)
        {
            drawBottle(i,50,40,0);

            var x,y;
            if (selectedBottle == i && mousex <= 585)
            {

                //getMousePos();
                if(mousex>585)
                {
                    x=585;
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


                drawBottle(i,x,y,1);
            }

        }
    }
}

function initGame()
{

    gCanvas = document.getElementById('canvas');
    gContext = gCanvas.getContext('2d');

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
    gpainaudio.src = 'baby-crying-01.mp3';
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

var HelpText =[
        '\n\n1. Cut one of the legs to move the spider to the opposite direction.\n\n' +
        '2. You can cut legs only when he is still ;-)\n\n' +
        '3. Reach the web while you still have one or more legs.\n\n' +
        '4. Be aware: Time is running out,so are your legs!\n',

        '\n\n1. Watch out for your next-to-be-vanished leg. The clock like thingy ont the top right of the screen indicates it.\n\n' +
        '2. Be aware, again: Time is running out,so are your legs!\n\n' +
        '3. The most important tip: Think out of the box.\n\n',


        '\n\n1. Did you see the new colliders with grey boundaries? They are bouncy.\n\n' +
        '2. Watch out! Legs may fall in different orders in different levels.\n\n',

        '\n\n1. If you are very close to the goal, but cannot reach it, THINK DIFFERENT.\n\n' +
        '2. Yes, there is a solution, and there is \'probably\' only one solution ;-)\n\n'

];


function wrapText(context, text, x, y, maxWidth, lineHeight, position,font)
{
    if(typeof(position)==='undefined') position = "top";
    if(typeof(font)==='undefined')  context.font = "italic 16pt Calibri";
    var cars = text.split("\n");
    context.save();

    context.lineWidth = 1;
    context.shadowOffsetX = 0;
    context.shadowOffsetY = 0;
    context.shadowBlur = 3;
    context.shadowColor = '#4d4d4d';

    //context.style.textShadow = '3pt|3pt|0pt|#2c2e38';

    context.fillStyle = '#bbbbbb';

    context.textBaseline = position;
    context.font = font;

    for (var ii = 0; ii < cars.length; ii++) {

        var line = "";
        var words = cars[ii].split(" ");

        for (var n = 0; n < words.length; n++) {
            var testLine = line + words[n] + " ";
            var metrics = context.measureText(testLine);
            var testWidth = metrics.width;

            if (testWidth > maxWidth) {
                context.fillText(line, x, y);
                line = words[n] + " ";
                y += lineHeight;
            }
            else {
                line = testLine;
            }
        }

        context.strokeText(line, x, y);
        context.fillText(line, x+1, y+1);

        y += lineHeight;
    }
    context.restore();
}

function drawHelpText (text)
{
    gContext.fillStyle = '#cccccc';
    //gContext.fillText(text, 610, 25);
    wrapText(gContext,text,mainScreenBoundaryX + 5, 50,185,30);
    gContext.closePath();
}

function writeMessage( message) {
    /*
     //var context = gcanvas.getContext('2d');
     gContext.beginPath();
     gContext.clearRect(0, 0, 300, 50);
     gContext.fillStyle=bgcolor;
     gContext.fillRect(0, 0, 300, 50);
     gContext.font = "16pt Arial";
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

var leftarrow = 37;
var uparrow = 38;
var rightarrow = 39;
var downarrow = 40;
var pause = 19;
var space = 32;
var hasleg = new Array(1,1,1,1, 1,1,1,1);
var legxdir = new Array(1,1,0,-1, -1,-1,0,1);
var Legydir = new Array(0,1,1,1, 0,-1,-1,-1);
var collider = new Array(); //1 means horizontal, 2 means vertical
var bottleexist = [1,0,0,0,0];
var selectedBottle = 0;
var movedirx = 0;
var movediry = 0;

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

var timer =0;
var nextleg=0;
var willcollide =1;
var collitionwith =-1;



function willcollidewith(i)
{
    var playerrightwall = gPlayer.x + gPlayer.boxwidth/2;
    var playerleftwall = gPlayer.x - gPlayer.boxwidth/2;
    var playertopwall = gPlayer.y - gPlayer.boxheight/2;
    var playerbottomwall = gPlayer.y + gPlayer.boxheight/2;

    var coliiderleftwall = collider[i][0];
    var coliiderrightwall = collider[i][1];
    var coliidertopwall = collider[i][2];
    var coliiderbottomwall = collider[i][3];

    var collidedist;


    if(playertopwall>coliiderbottomwall
        && playertopwall + movediry * gPlayer.speedIncrement <= coliiderbottomwall )
    {
        collidedist = Math.abs(coliiderbottomwall - playertopwall);
        var collitionxleft= playerleftwall + movedirx * collidedist;
        var collitionxright = playerrightwall + movedirx * collidedist;
        if((collitionxleft>coliiderleftwall && collitionxleft<coliiderrightwall)
            ||(collitionxright>coliiderleftwall && collitionxright<coliiderrightwall))
        {
            movediry = 1;
            return true;
        }
    }
    if(playerbottomwall<coliidertopwall
        && playerbottomwall + movediry * gPlayer.speedIncrement >= coliidertopwall )
    {
        collidedist = Math.abs(coliidertopwall - playerbottomwall);
        var collitionxleft= playerleftwall + movedirx * collidedist;
        var collitionxright = playerrightwall + movedirx * collidedist;
        if((collitionxleft>coliiderleftwall && collitionxleft<coliiderrightwall)
            ||(collitionxright>coliiderleftwall && collitionxright<coliiderrightwall))
        {
            movediry = -1;
            return true;
        }
    }

    if(playerrightwall<coliiderleftwall
        && playerrightwall + movedirx * gPlayer.speedIncrement >= coliiderleftwall )
    {
        collidedist = Math.abs(coliiderleftwall - playerrightwall);
        var collitionytop = playertopwall + movediry * collidedist;
        var collitionybottom = playerbottomwall + movediry * collidedist;
        if((collitionytop>coliidertopwall && collitionytop<coliiderbottomwall)
            ||(collitionybottom>coliidertopwall && collitionybottom<coliiderbottomwall))
        {
            movedirx = -1;
            return true;
        }
    }
    if(playerleftwall>coliiderrightwall
        && playerleftwall + movedirx * gPlayer.speedIncrement <= coliiderrightwall )
    {
        collidedist = Math.abs(coliiderrightwall - playerleftwall);
        var collitionytop = playertopwall + movediry * collidedist;
        var collitionybottom = playerbottomwall + movediry * collidedist;
        if((collitionytop>coliidertopwall && collitionytop<coliiderbottomwall)
            ||(collitionybottom>coliidertopwall && collitionybottom<coliiderbottomwall))
        {
            movedirx = 1;
            return true;
        }
    }

}

function detectcollition()
{
    //gPlayer.x += movedirx * gPlayer.speedIncrement;
    var i,j;
    for(i=0;i<collider.length;i++)
    {
        if(willcollidewith(i))
        {
            willcollide =1;
            if(collider[i][5]==1)
            {
                willcollide = 0;
            }
            collitionwith =i;
        }
    }

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



function getclickedleg (x1,y1)
{
    if(willcollide==0)
        return -1;
    var theta =0;
    var len = gPlayer.width/2 *1.5;
    var len2 = gPlayer.width/2 ;

    var i=1;
    for(i=0;i<8;i++)
    {
        if(hasleg[i]==1)
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
                Distancepointpoint(x1,y1,gPlayer.x,gPlayer.y)>=gPlayer.width/2-15)
            {
                hasleg[i] =0;
                willcollide =0;
                //clearPlayer();
                //drawPlayer();
                writeMessage('leg ' + i +' clicked');
                movedirx = -legxdir[i];
                movediry = -Legydir[i];
                return i;
            }

        }


    }
    return -1;
}

var winkingtime = -1;

function drawcollider(i)
{
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
        gContext.rect(topleftx, toplefty, width, height);


        gContext.lineWidth = 2;
        if(collider[i][5]==0)
        {
            gContext.strokeStyle = 'black';
            gContext.fillStyle = '#555555';
        }
        else
        {
            gContext.strokeStyle = '#333333';
            gContext.fillStyle = 'black';
        }
        gContext.fill();
        gContext.stroke();
        var j;
        for(j=topleftx +10; j<=topleftx + width -5; j+=20)
        {
            gContext.moveTo(j,collider[i][2]-1);
            gContext.lineTo(j,collider[i][3]+1);
        }
        gContext.stroke();
    }
    else
    {
        topleftx = collider[i][0] + (collider[i][1]-collider[i][0]) /4;
        toplefty = collider[i][2];
        width = (collider[i][1]-collider[i][0])/2;
        height = (collider[i][3]-collider[i][2]);
        gContext.rect(topleftx, toplefty, width, height);
        gContext.fillStyle = '#555555';

        gContext.lineWidth = 2;
        if(collider[i][5]==0)
        {
            gContext.strokeStyle = 'black';
            gContext.fillStyle = '#555555';
        }
        else
        {
            gContext.strokeStyle = '#333333';
            gContext.fillStyle = 'black';
        }
        gContext.stroke();
        gContext.fill();
        var j;
        for(j=toplefty +10; j<=toplefty + height -5; j+=20)
        {
            gContext.moveTo(collider[i][0]-1,j);
            gContext.lineTo(collider[i][1]+1,j);
        }
        gContext.stroke();

    }

    gContext.closePath();
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

    setTimeout(function()
    {
        //gpainaudio.stop();
        document.body.removeChild(gpainaudio);
    },2000);

}
var nextlegtime = 100;
var heightinc =-1;
gPlayer.height = 120;
function drawStartScreen()
{
    gContext.clearRect(0,0,gCanvas.width,gCanvas.height);
    gContext.fillStyle='#222222';

    gPlayer.width = gPlayer.height;
    gPlayer.x = gCanvas.width/2;
    gPlayer.y = gCanvas.height/2 -20;
    gContext.fillRect(0,0,gCanvas.width,gCanvas.height);
    drawPlayer();
    if(gPlayer.height<=110 || gPlayer.height>=130)
    {
        heightinc*=-1;
    }
    wrapText(gContext,"Save The Last Spider",gCanvas.width/2-70,gCanvas.height/2+100, 500, 200, 'centre');

    gContext.strokeStyle = '#444444';
    gContext.strokeRect(gCanvas.width/2-70,gCanvas.height/2+120,140,20);
    wrapText(gContext,"Old Game",gCanvas.width/2-20,gCanvas.height/2+132, 500, 200, 'centre','italic 10pt Calibri');
    gContext.strokeRect(gCanvas.width/2-70,gCanvas.height/2+145,140,20);
    wrapText(gContext,"New Game",gCanvas.width/2-20,gCanvas.height/2+157, 500, 200, 'centre','italic 10pt Calibri');
    gPlayer.height += heightinc;
}

function gameLoop()
{

    setTimeout(gameLoop, (1000 / 30));
    if(gamePhase == StartScreen)
    {
        drawStartScreen();
        return;
    }
    if(gamePhase == EndLevel)
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
    if(hasanyleg() == 0)
    {
        initLevel(nextLevel);
    }

    if(mousex < 585)
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

    if(timer % 3 == 0)
    {
        nextlegtime--;
    }

    if (nextlegtime == 0 && hasanyleg() == 1)
    {
        if(hasleg[nextleg]==1) {
            playCrySound();
        }
        nextlegtime=100;
        hasleg[nextleg] = 0;

        playCrySound();
        var msg = 'removing leg ' + nextleg;
        writeMessage(msg);
        //while(hasleg[nextleg+1]==0)
        //{
            //nextleg++;
        //}
        nextleg++;
        if(nextleg == 8)
        {
            nextleg = 0;
        }
        winkingtime = 0;

    }

    if (winkingtime >= 0) {
        winkingtime++;
    }
    if (winkingtime >= 20) {
        //clearPlayer();
        //drawPlayer();
        winkingtime = -1;
    }
    //setTimeout(gameLoop, (1000 / 30)); // Execute Game Loop at 30FPS

    /*
     if (gKeys.indexOf(leftarrow) != -1) {
     clearPlayer();
     gPlayer.x -= gPlayer.speedIncrement; // Move Left 1
     drawPlayer();
     }
     if (gKeys.indexOf(rightarrow) != -1) {
     clearPlayer();
     gPlayer.x += gPlayer.speedIncrement; // Move Right 1
     drawPlayer();
     }
     if (gKeys.indexOf(uparrow) != -1) {
     clearPlayer();
     gPlayer.y -= gPlayer.speedIncrement; // Move Left 1
     drawPlayer();
     }
     if (gKeys.indexOf(downarrow) != -1) {
     clearPlayer();
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

    detectcollition();
    if(willcollide==0)
    {
        //clearPlayer();

        if (gPlayer.x + movedirx * gPlayer.speedIncrement - gPlayer.boxwidth/2 >= 5 &&
            gPlayer.x + movedirx * gPlayer.speedIncrement + gPlayer.boxwidth/2  <= mainScreenBoundaryX -15)
        {
            gPlayer.x += movedirx * gPlayer.speedIncrement;
        }
        else
        {
            willcollide=1;
            movedirx=0;
            movediry=0;

        }
        if (gPlayer.y + movediry * gPlayer.speedIncrement -  gPlayer.boxheight/2 >= 80 &&
            gPlayer.y + movediry * gPlayer.speedIncrement +  gPlayer.boxheight/2 <= gCanvas.height)
        {
            gPlayer.y += movediry * gPlayer.speedIncrement;
        }
        else
        {
            willcollide=1;
            movedirx=0;
            movediry=0;
        }

        //drawPlayer();
    }
    else
    {
        //clearPlayer();
        movedirx=0;
        movediry=0;
        //drawPlayer();
    }
    redrawAll()();
}

function drawSpiderWeb(x,y)
{
    gContext.save();
    var len = gPlayer.width/2 *1.5;
    var i, theta;
    var ninety = Math.PI/2;
    var twoseventy = 3*Math.PI/2;
    gContext.beginPath();
    gContext.lineWidth = 2;
    for(i=0;i<5;i++)
    {
        //if(hasleg[i]==1)
        {
            theta= i* 2*Math.PI/5;

            drawlineNoStroke(x + len *.3 * Math.cos(theta), y + len *.3 * Math.sin(theta),
                    x + len * Math.cos(theta), y + len * Math.sin(theta),
                '#ffffff');

            var j, theta2;
            theta2 = theta + Math.PI/5;
            for(j=1;j<5;j++)
            {
                var midx = x + j*8 * Math.cos(theta2);
                var midy = y + j*8 * Math.sin(theta2);
                drawlineNoStroke(midx + 8*(j) * Math.cos(ninety+theta2), midy + 8*(j) * Math.sin(ninety+theta2),
                        midx + 8*(j) * Math.cos(twoseventy+theta2), midy + 8*(j) * Math.sin(twoseventy+theta2),
                    '#ffffff');
            }

        }

    }

    gContext.closePath();

    gContext.stroke();
    gContext.restore();

}

function clearPlayer()
{


    //gContext.clearRect(gPlayer.x-gPlayer.width/2 *1.5 ,gPlayer.y-gPlayer.height/2*1.5,gPlayer.width*1.5,gPlayer.height*1.5);
    //gContext.fillStyle=bgcolor;
    //gContext.fillRect(gPlayer.x-gPlayer.width/2 *1.5 ,gPlayer.y-gPlayer.height/2*1.5,gPlayer.width*1.5,gPlayer.height*1.5);
    //drawSpiderWeb(550,550);

    /*
    gContext.clearRect(0,0,600,gCanvas.height);
    gContext.fillStyle=bgcolor;
    gContext.fillRect(0,0,600,gCanvas.height);
    drawColliders();
    drawSpiderWeb(550,550);
    drawBottles();
    */
}

function redrawAll()
{
    gContext.clearRect(0,0,mainScreenBoundaryX,gCanvas.height);
    gContext.fillStyle=bgcolor;
    gContext.fillRect(0,0,mainScreenBoundaryX,gCanvas.height);
    drawColliders();
    drawLegIndicator();
    drawSpiderWeb(goalX,goalY);

    drawPlayer();
    drawBottles();
    drawUpBorder();

}

function isPlayerInGoal()
{
    if(Math.sqrt(sqr(gPlayer.x-goalX)+sqr(gPlayer.y-goalY))<10)
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
    wrapText(gContext,text,gCanvas.width/2-100, gCanvas.height/2,180,30,"centre");

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
    var grd2=gContext.createRadialGradient(xloc, yloc, gPlayer.width *.5*rad,xloc,yloc,gPlayer.width*rad );
    grd2.addColorStop(0,"#111111");
    grd2.addColorStop(1,"#ffffff");

    var grd3=gContext.createRadialGradient(xloc, yloc, gPlayer.width *.7*rad,xloc,yloc,gPlayer.width*rad );
    grd3.addColorStop(0,"#111111");
    grd3.addColorStop(1,"#ffffff");

    gContext.beginPath();
    //gContext.moveTo(gPlayer.x, gPlayer.y);
    //gContext.scale(0.75,1);
    //gContext.arc(xloc, yloc, gPlayer.height *rad, 0, 2 * Math.PI, false);
    drawEllipseByCenter(gContext,xloc,yloc,gPlayer.width *1.5*rad,gPlayer.height *2*rad)
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
    //gContext.strokeStyle = '#000000';
    //gContext.stroke();
    gContext.closePath();

}
function drawPlayer()
{

    gContext.save();

    gContext.beginPath();



    gContext.lineWidth = 3;
    gContext.moveTo(gPlayer.x, gPlayer.y);
    var i=0;
    var j=0;

    gContext.shadowOffsetX = 0;
    gContext.shadowOffsetY = 0;
    gContext.shadowBlur = 4;
    gContext.shadowColor = '#4d4d4d';

    for(i=0;i<8;i++)
    {
        if(hasleg[i]==1)
        {
            var theta= i* Math.PI/4;
            var len = gPlayer.width/2 *1.5;
            gContext.moveTo(gPlayer.x, gPlayer.y);
            gContext.lineTo(gPlayer.x + len * Math.cos(theta), gPlayer.y + len * Math.sin(theta));
        }

    }

    gContext.strokeStyle = '#000000';
    gContext.stroke();
    gContext.closePath();

    gContext.restore();

    gContext.save();


    gContext.beginPath();
    gContext.lineWidth = 3;

    drawSpiderBody(gContext,gPlayer.x,gPlayer.y,gPlayer.height/2  - gContext.lineWidth);


    gContext.strokeStyle = '#000000';
    gContext.stroke();
    gContext.closePath();




    for(i=-1;i<=1;i+=2)
    {
        var xloc = gPlayer.x + gPlayer.width/2 *.4*i;
        var yloc = gPlayer.y - gPlayer.height/2 *.8;

        drawEye(xloc,yloc,i,.2);

        //xloc = gPlayer.x + gPlayer.width/2 *.6*i;
        //yloc = gPlayer.y - gPlayer.height/2 *.3;

        //drawEye(xloc,yloc,i,.08);

    }

    gContext.restore();

}

function drawLegIndicator()
{
    var  x=550,y=38;

    gContext.save();

    gContext.shadowOffsetX = 1;
    gContext.shadowOffsetY = 1;
    gContext.shadowBlur = 2;
    gContext.shadowColor = '#4d4d4d';


    var len = gPlayer.width * .8;

    var innerCircleRatio = .7;

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
                gContext.lineTo(x + len/2 * Math.cos(theta)* (innerCircleRatio + (nextlegtime/100 *(1-innerCircleRatio))),
                        y +  len/2 * Math.sin(theta)*(innerCircleRatio+ (nextlegtime/100 *(1-innerCircleRatio))));
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
    var size = haystack.length
    for(i; i < size; ++i)
    {
        if(haystack[i] == needle) {
            haystack.splice(i,1);
            return haystack;
        }
    }
    return haystack;
}