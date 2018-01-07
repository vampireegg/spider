local M = {}

local OOF = 2000
local lvlno = 1

----------------------------------------Level 1----------------------------------------
M[lvlno] = {}
M[lvlno].goldMax = 10
M[lvlno].freeMove = 0

M[lvlno].levelName = "Hello World"
M[lvlno].levelNumber = "1"

M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.2
M[lvlno].spider.PosiX = 220
M[lvlno].spider.PosiY = 200
M[lvlno].spider.LegExists = {0,0,0,0,1,0,1,0}
M[lvlno].spider.LegTapOrder = {5, 7}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {100}
M[lvlno].collider.GroupY = {320}
M[lvlno].collider.Num = {5}
M[lvlno].collider.Orientation = {1}
M[lvlno].collider.ColliderType = {1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 980
M[lvlno].goal.PosiY = 530

M[lvlno].bg = {}
M[lvlno].bg.Img = "bbg2.jpg"
M[lvlno].bg.Opacity = 1
M[lvlno].bg.ExtraImgExists = 1
M[lvlno].bg.ExtraImg = {"tap_here.png", "tap_here2.png", "reload_here.png"}
M[lvlno].bg.ExtraImgOpacity = {1, 0, 0}
M[lvlno].bg.ExtraImgX = {90, 935, 910}
M[lvlno].bg.ExtraImgY = {150, 100, 50}
M[lvlno].bg.ExtraImgWidth = {285, 550, 572}
M[lvlno].bg.ExtraImgHeight = {457, 162, 106}
M[lvlno].bg.ExtraImgScale = {0.2, 0.2, 0.2}

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 0
M[lvlno].portal.Types = {}
M[lvlno].portal.PosiX = {}
M[lvlno].portal.PosiY = {}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_1.png"
M[lvlno].dos_donts.Color = {0.4, 0.3, 0.2, 1}


M[lvlno].icon = {}
M[lvlno].icon.Img = "li_1.png"

---------------------------------------- Level 2----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 20
M[lvlno].freeMove = 1

M[lvlno].levelName = "World with Borders"
M[lvlno].levelNumber = "2"


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.2
M[lvlno].spider.PosiX = 90
M[lvlno].spider.PosiY = 150
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {5, 7, 1, 3}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {30}
M[lvlno].collider.GroupY = {300}
M[lvlno].collider.Num = {8}
M[lvlno].collider.Orientation = {1}
M[lvlno].collider.ColliderType = {1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 80
M[lvlno].goal.PosiY = 400

M[lvlno].bg = {}
M[lvlno].bg.Img = "bbg2.jpg"
M[lvlno].bg.Opacity = 1

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 0
M[lvlno].portal.Types = {}
M[lvlno].portal.PosiX = {}
M[lvlno].portal.PosiY = {}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_2.png"
M[lvlno].dos_donts.Color = {0.6, 0.4, 0.3, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_2.png"

---------------------------------------- Level 3----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 50
M[lvlno].freeMove = 0

M[lvlno].levelName = "First LightBulb"
M[lvlno].levelNumber = "3"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 100
M[lvlno].nextMove.PosiY = 530


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.2
M[lvlno].spider.PosiX = 230
M[lvlno].spider.PosiY = 150
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {4, 6, 1, 7, 5}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {70, 550}
M[lvlno].collider.GroupY = {280, 410}
M[lvlno].collider.Num = {5, 8}
M[lvlno].collider.Orientation = {1, 1}
M[lvlno].collider.ColliderType = {1,1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 980
M[lvlno].goal.PosiY = 530

M[lvlno].bg = {}
M[lvlno].bg.Img = "bbg2.jpg"
M[lvlno].bg.Opacity = 1

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 0
M[lvlno].portal.Types = {}
M[lvlno].portal.PosiX = {}
M[lvlno].portal.PosiY = {}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_3.png"
M[lvlno].dos_donts.Color = {0.5, 0.4, 0.3, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_3.png"

---------------------------------------- sl - 1----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 20
M[lvlno].freeMove = 0
M[lvlno].levelName = "LegLess"
M[lvlno].levelNumber = "S1"

M[lvlno].levelType  = 2

M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.2
M[lvlno].spider.PosiX = 100
M[lvlno].spider.PosiY = 300
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {1, 7, 5, 3, 2, 4, 6, 8}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {}
M[lvlno].collider.GroupY = {}
M[lvlno].collider.Num = {}
M[lvlno].collider.Orientation = {}
M[lvlno].collider.ColliderType = {}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 766
M[lvlno].goal.PosiY = 300

M[lvlno].bg = {}
M[lvlno].bg.Img = "bbg2.jpg"
M[lvlno].bg.Opacity = 1

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 0
M[lvlno].portal.Types = {}
M[lvlno].portal.PosiX = {}
M[lvlno].portal.PosiY = {}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "sl_1.png"
M[lvlno].dos_donts.Color = {0.4, 0.3, 0.2, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "sli_1.png"

---------------------------------------- Level 4----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 10
M[lvlno].freeMove = 0
M[lvlno].levelName = "Portals"
M[lvlno].levelNumber = "4"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 900
M[lvlno].nextMove.PosiY = 530

M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.2
M[lvlno].spider.PosiX = 90
M[lvlno].spider.PosiY = 90
M[lvlno].spider.LegExists = {1,0,1,0,1,0,1,0}
M[lvlno].spider.LegTapOrder = {5, 7, 1}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {50}
M[lvlno].collider.GroupY = {300}
M[lvlno].collider.Num = {18}
M[lvlno].collider.Orientation = {1}
M[lvlno].collider.ColliderType = {1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 90
M[lvlno].goal.PosiY = 530

M[lvlno].bg = {}
M[lvlno].bg.Img = "water.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {4}
M[lvlno].portal.PosiX = {{800,800}}
M[lvlno].portal.PosiY = {{90,400}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_4.png"
M[lvlno].dos_donts.Color = {0.3, 0.2, 0.4, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_4.png"

---------------------------------------- Level 5----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 40
M[lvlno].freeMove = 0
M[lvlno].levelName = "Portals - 2"
M[lvlno].levelNumber = "5"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 750
M[lvlno].nextMove.PosiY = 530

M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.2
M[lvlno].spider.PosiX = 270
M[lvlno].spider.PosiY = 200
M[lvlno].spider.LegExists = {1,0,1,0,1,0,1,0}
M[lvlno].spider.LegTapOrder = {3, 1, 7, 5}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {400, 650, 880}
M[lvlno].collider.GroupY = {50, 440, 50}
M[lvlno].collider.Num = {10, 3, 2}
M[lvlno].collider.Orientation = {2, 2, 2}
M[lvlno].collider.ColliderType = {1,1,1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 980
M[lvlno].goal.PosiY = 530

M[lvlno].bg = {}
M[lvlno].bg.Img = "water.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {1,3}
M[lvlno].portal.PosiX = {{90,750}, {90,500}}
M[lvlno].portal.PosiY = {{200,200}, {500,90}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_5.png"
M[lvlno].dos_donts.Color = {0.3, 0.2, 0.5, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_5.png"

---------------------------------------- Level 6----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 100
M[lvlno].freeMove = 1
M[lvlno].levelName = "Portals - 3"
M[lvlno].levelNumber = "6"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 820
M[lvlno].nextMove.PosiY = 530


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 70
M[lvlno].spider.PosiY = 70
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {7, 5, 3, 1}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {550, 50, 600}
M[lvlno].collider.GroupY = {50, 400, 300}
M[lvlno].collider.Num = {10, 9, 8}
M[lvlno].collider.Orientation = {2, 1, 1}
M[lvlno].collider.ColliderType = {1,1,1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 660
M[lvlno].goal.PosiY = 170

M[lvlno].bg = {}
M[lvlno].bg.Img = "water.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {3,4,1,2}
M[lvlno].portal.PosiX = {{270,270}, {270,660}, {140,800}, {140,1000}}
M[lvlno].portal.PosiY = {{70,490}, {270,490}, {270,170}, {490,490}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_6.png"
M[lvlno].dos_donts.Color = {0.3, 0.2, 0.5, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_6.png"

---------------------------------------- sl - 2----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 70
M[lvlno].freeMove = 0
M[lvlno].levelName = "BoundLess"
M[lvlno].levelNumber = "S2"

M[lvlno].levelType  = 3

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 700
M[lvlno].nextMove.PosiY = 530

M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 189
M[lvlno].spider.PosiY = 100
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {1, 6, 8, 5, 2, 4, 3}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {30, 350, 620, 940}
M[lvlno].collider.GroupY = {50, 50, 50, 50}
M[lvlno].collider.Num = {10, 10, 10, 10}
M[lvlno].collider.Orientation = {2, 2, 2, 2}
M[lvlno].collider.ColliderType = {1, 1, 1, 1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 544
M[lvlno].goal.PosiY = 100

M[lvlno].bg = {}
M[lvlno].bg.Img = "water.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {2, 3, 4}
M[lvlno].portal.PosiX = {{189, 780}, {780, 189}, {780, 544}, {780, 544}}
M[lvlno].portal.PosiY = {{361, 361}, {445, 445}, {192, 361}, {830, 510}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "sl_2.png"
M[lvlno].dos_donts.Color = {0.1, 0.05, 0.2, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "sli_2.png"

---------------------------------------- Level 7----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 10
M[lvlno].freeMove = 0
M[lvlno].levelName = "Bouncers"
M[lvlno].levelNumber = "7"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 200
M[lvlno].nextMove.PosiY = 530


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 90
M[lvlno].spider.PosiY = 90
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {6, 5, 2, 1}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {50, 250}
M[lvlno].collider.GroupY = {300, 50}
M[lvlno].collider.Num = {18,1}
M[lvlno].collider.Orientation = {1, 2}
M[lvlno].collider.ColliderType = {2, 1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 90
M[lvlno].goal.PosiY = 530

M[lvlno].bg = {}
M[lvlno].bg.Img = "leaf.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {2}
M[lvlno].portal.PosiX = {{800,800}}
M[lvlno].portal.PosiY = {{70,530}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_7.png"
M[lvlno].dos_donts.Color = {0.2, 0.3, 0.2, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_7.png"

---------------------------------------- Level 8----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 30
M[lvlno].freeMove = 0
M[lvlno].levelName = "Bouncers - 2"
M[lvlno].levelNumber = "8"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 100
M[lvlno].nextMove.PosiY = 480

M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 200
M[lvlno].spider.PosiY = 150
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {50, 50, 50, 1030}
M[lvlno].collider.GroupY = {20, 280, 540, 100}
M[lvlno].collider.Num = {18, 18, 18, 3}
M[lvlno].collider.Orientation = {1, 1, 1, 2}
M[lvlno].collider.ColliderType = {2, 2, 2, 2}
M[lvlno].spider.LegTapOrder = {1, 6}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 830
M[lvlno].goal.PosiY = 150

M[lvlno].bg = {}
M[lvlno].bg.Img = "leaf.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {2, 3, 4}
M[lvlno].portal.PosiX = {{320,700}, {490,490}, {660,280}}
M[lvlno].portal.PosiY = {{150,410}, {150,410}, {150,410}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_8.png"
M[lvlno].dos_donts.Color = {0.2, 0.2, 0.2, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_8.png"

---------------------------------------- Level 9----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 120
M[lvlno].freeMove = 1
M[lvlno].levelName = "Backtracking"
M[lvlno].levelNumber = "9"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 30
M[lvlno].nextMove.PosiY = 520

M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.1
M[lvlno].spider.PosiX = 340
M[lvlno].spider.PosiY = 80
M[lvlno].spider.LegExists = {1,1,0,1,1,1,1,0}
M[lvlno].spider.LegTapOrder = {7, 5, 2, 6, 1, 4}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {50, 50, 50, 930, 660, 400, 140, 930, 660, 400, 140}
M[lvlno].collider.GroupY = {20, 290, 560, 90, 90, 90, 90, 360, 360, 360, 360}
M[lvlno].collider.Num = {18, 18, 18, 3, 3, 3, 3, 3, 3, 3, 3}
M[lvlno].collider.Orientation = {1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2}
M[lvlno].collider.ColliderType = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 870
M[lvlno].goal.PosiY = 80

M[lvlno].bg = {}
M[lvlno].bg.Img = "water.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {6, 2, 3, 5, 4, 1, 7, 8}
M[lvlno].portal.PosiX = {{340, 720}, {200, 200}, {870, 870}, {720, 460}, {600, 600}, {460, 720}, {340, 600}, {870, 200}}
M[lvlno].portal.PosiY = {{230, 500}, {80,  500}, {500, 230}, {80,  350}, {500,  80}, {80,  230}, {350, 230}, {350, 230}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_9.png"
M[lvlno].dos_donts.Color = {0.2, 0.2, 0.3, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_9.png"

---------------------------------------- Level 10----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 40
M[lvlno].freeMove = 0
M[lvlno].levelName = "Go Get a Life"
M[lvlno].levelNumber = "10"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 120
M[lvlno].nextMove.PosiY = 530


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 70
M[lvlno].spider.PosiY = 70
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {5, 7, 4, 7}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {350, 90}
M[lvlno].collider.GroupY = {90, 350}
M[lvlno].collider.Num = {2, 2}
M[lvlno].collider.Orientation = {2, 1}
M[lvlno].collider.ColliderType = {1, 1}


M[lvlno].goal = {}
M[lvlno].goal.PosiX = 746
M[lvlno].goal.PosiY = 536

M[lvlno].bg = {}
M[lvlno].bg.Img = "bricks.jpg"
M[lvlno].bg.Opacity = 0.2

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {5, 4, 3}
M[lvlno].portal.PosiX = {{536,OOF}, {882, -OOF}, {1002, OOF}}
M[lvlno].portal.PosiY = {{536,OOF}, {393, -OOF}, {319, -OOF}}

M[lvlno].heartExists = 1
M[lvlno].heart = {}
M[lvlno].heart.PosiX = {290}
M[lvlno].heart.PosiY = {290}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_10.png"
M[lvlno].dos_donts.Color = {0.3, 0.1, 0.2, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_10.png"

---------------------------------------- Level 11----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 70
M[lvlno].freeMove = 0
M[lvlno].levelName = "3 Houses"
M[lvlno].levelNumber = "11"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 520
M[lvlno].nextMove.PosiY = 60


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 150
M[lvlno].spider.PosiY = 250
M[lvlno].spider.LegExists = {1,0,1,0,1,0,1,0}
M[lvlno].spider.LegTapOrder = {7, 5, 3, 1, 3}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {300, 400, 700, 800, 180, 415, 815}
M[lvlno].collider.GroupY = {170, 170, 170, 170, 130, 130, 130}
M[lvlno].collider.Num = {8, 5, 8, 8, 3, 6, 5}
M[lvlno].collider.Orientation = {2, 2, 2, 2, 1, 1, 1}
M[lvlno].collider.ColliderType = {2, 1, 2, 1, 1, 1, 2}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 876
M[lvlno].goal.PosiY = 530

M[lvlno].bg = {}
M[lvlno].bg.Img = "bricks.jpg"
M[lvlno].bg.Opacity = 0.2

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {1, 5, 4, 2, 3}
M[lvlno].portal.PosiX = {{63,  570}, {470, 570}, {470, 970}, {630, OOF}, {230, -OOF}}
M[lvlno].portal.PosiY = {{120, 300}, {206, 530}, {530, 300}, {206, OOF}, {250, -OOF}}

M[lvlno].heartExists = 1
M[lvlno].heart = {}
M[lvlno].heart.PosiX = {63}
M[lvlno].heart.PosiY = {400}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_11.png"
M[lvlno].dos_donts.Color = {0.25, 0.0, 0.12, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_11.png"

---------------------------------------- Level 12----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 150
M[lvlno].freeMove = 1
M[lvlno].levelName = "Knots"
M[lvlno].levelNumber = "12"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 470
M[lvlno].nextMove.PosiY = 550


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 730
M[lvlno].spider.PosiY = 80
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {8, 2, 7, 4, 1, 6, 3, 1}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {550, 730, 230, 180, 910}
M[lvlno].collider.GroupY = {60, 200, 200, 50, 50}
M[lvlno].collider.Num = {3, 3, 3, 10, 10}
M[lvlno].collider.Orientation = {2, 1, 1, 2, 2}
M[lvlno].collider.ColliderType = {1, 1, 1, 1, 1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 260
M[lvlno].goal.PosiY = 63

M[lvlno].bg = {}
M[lvlno].bg.Img = "bricks.jpg"
M[lvlno].bg.Opacity = 0.3

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 0
M[lvlno].portal.Types = {}
M[lvlno].portal.PosiX = {}
M[lvlno].portal.PosiY = {}

M[lvlno].heartExists = 1
M[lvlno].heart = {}
M[lvlno].heart.PosiX = {378}
M[lvlno].heart.PosiY = {332}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_12.png"
M[lvlno].dos_donts.Color = {0.12, 0.25, 0.35, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_12.png"

---------------------------------------- Level 13----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 40
M[lvlno].freeMove = 0
M[lvlno].levelName = "Windows and Gates"
M[lvlno].levelNumber = "7"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 900
M[lvlno].nextMove.PosiY = 530


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 70
M[lvlno].spider.PosiY = 80
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {7, 5, 1, 6}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {}
M[lvlno].collider.GroupY = {}
M[lvlno].collider.Num = {}
M[lvlno].collider.Orientation = {}
M[lvlno].collider.ColliderType = {}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 375
M[lvlno].goal.PosiY = 536

M[lvlno].bg = {}
M[lvlno].bg.Img = "splash3.jpg"
M[lvlno].bg.Opacity = 0.4

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 0
M[lvlno].portal.Types = {}
M[lvlno].portal.PosiX = {}
M[lvlno].portal.PosiY = {}

M[lvlno].heartExists = 0

M[lvlno].switchSystemExists = 1
M[lvlno].switchSystem = {}
M[lvlno].switchSystem.Num = 1
M[lvlno].switchSystem.Color = {{1,1,1}}
M[lvlno].switchSystem.switch = {}
M[lvlno].switchSystem.switch.PosiX = {1002}
M[lvlno].switchSystem.switch.PosiY = {224}
M[lvlno].switchSystem.window = {}
M[lvlno].switchSystem.window.Orientation = {{1, 2}}
M[lvlno].switchSystem.window.State = {{1, 0}}
M[lvlno].switchSystem.window.Num = {{37, 8}}
M[lvlno].switchSystem.window.PosiX = {{30, 500}}
M[lvlno].switchSystem.window.PosiY = {{300, 350}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_13.png"
M[lvlno].dos_donts.Color = {0.25, 0.12, 0.12, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_13.png"


---------------------------------------- Level 14----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 100
M[lvlno].freeMove = 0
M[lvlno].levelName = "Switches"
M[lvlno].levelNumber = "14"

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 120
M[lvlno].nextMove.PosiY = 530


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.15
M[lvlno].spider.PosiX = 70
M[lvlno].spider.PosiY = 80
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {6, 2, 7, 5, 8, 4, 3, 1}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {450, 260}
M[lvlno].collider.GroupY = {60,  300}
M[lvlno].collider.Num = {7, 3}
M[lvlno].collider.Orientation = {2, 1}
M[lvlno].collider.ColliderType = {1, 1}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = 520
M[lvlno].goal.PosiY = 63

M[lvlno].bg = {}
M[lvlno].bg.Img = "splash3.jpg"
M[lvlno].bg.Opacity = 0.4

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 1
M[lvlno].portal.Types = {1}
M[lvlno].portal.PosiX = {{1002, 373}}
M[lvlno].portal.PosiY = {{536, 63}}

M[lvlno].heartExists = 0

M[lvlno].switchSystemExists = 1
M[lvlno].switchSystem = {}
M[lvlno].switchSystem.Num = 2
M[lvlno].switchSystem.Color = {{1,1,1}, {1,1,0.3}}
M[lvlno].switchSystem.switch = {}
M[lvlno].switchSystem.switch.PosiX = {214, 500}
M[lvlno].switchSystem.switch.PosiY = {224, 536}
M[lvlno].switchSystem.window = {}
M[lvlno].switchSystem.window.Orientation = {{1, 1}, {1, 1}}
M[lvlno].switchSystem.window.State = {{1, 0},{1, 0}}
M[lvlno].switchSystem.window.Num = {{7, 10}, {1, 10}}
M[lvlno].switchSystem.window.PosiX = {{30, 800},{323, 500}}
M[lvlno].switchSystem.window.PosiY = {{300, 300},{113, 300}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_14.png"
M[lvlno].dos_donts.Color = {0.25, 0.12, 0.0, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_14.png"


---------------------------------------- sl - 3----------------------------------------
lvlno = lvlno + 1
M[lvlno] = {}
M[lvlno].goldMax = 100
M[lvlno].freeMove = 0
M[lvlno].levelName = "Switches"
M[lvlno].levelNumber = "14"

M[lvlno].levelType = 4

M[lvlno].nextMoveExists = true
M[lvlno].nextMove = {}
M[lvlno].nextMove.PosiX = 120
M[lvlno].nextMove.PosiY = 530


M[lvlno].spider = {}
M[lvlno].spider.MyScale = 0.18
M[lvlno].spider.PosiX = 100
M[lvlno].spider.PosiY = 100
M[lvlno].spider.LegExists = {1,1,1,1,1,1,1,1}
M[lvlno].spider.LegTapOrder = {6, 2, 7, 5, 8, 4, 3, 1}
M[lvlno].spider.LegImg = "nerdarrow.png"
M[lvlno].spider.BodyImg = "nerdspider.png"
M[lvlno].spider.BodyImgWidth = 1269
M[lvlno].spider.BodyImgHeight = 917
M[lvlno].spider.BodyRatio = 0.65

M[lvlno].collider = {}
M[lvlno].collider.GroupX = {}
M[lvlno].collider.GroupY = {}
M[lvlno].collider.Num = {}
M[lvlno].collider.Orientation = {}
M[lvlno].collider.ColliderType = {}

M[lvlno].goal = {}
M[lvlno].goal.PosiX = OOF
M[lvlno].goal.PosiY = OOF

M[lvlno].bg = {}
M[lvlno].bg.Img = "splash3.jpg"
M[lvlno].bg.Opacity = 0.4

M[lvlno].eye = {}
M[lvlno].eye.Opacity = 0

M[lvlno].portal = {}
M[lvlno].portal.Exists = 0
M[lvlno].portal.Types = {}
M[lvlno].portal.PosiX = {}
M[lvlno].portal.PosiY = {}

M[lvlno].heartExists = 0

M[lvlno].switchSystemExists = 1
M[lvlno].switchSystem = {}
M[lvlno].switchSystem.Num = 4
M[lvlno].switchSystem.Color = {{1, 1, 1}, {0.3, 0.3, 1}, {1, 1, 0.3}, {0, 1, 0.3}}
M[lvlno].switchSystem.switch = {}
M[lvlno].switchSystem.switch.PosiX = {888, 177, 533, 533}
M[lvlno].switchSystem.switch.PosiY = {300, 300, 500, 100}
M[lvlno].switchSystem.window = {}
M[lvlno].switchSystem.window.Orientation = {{1, 1}, {1,2}, {1,2}, {1,2}}
M[lvlno].switchSystem.window.State = {{1, 0},{1, 0}, {1,0}, {0, 1}}
M[lvlno].switchSystem.window.Num = {{12, 12}, {12, 6}, {12, 6}, {12, 6}}
M[lvlno].switchSystem.window.PosiX = {{30, 721}, {30, 350}, {380, 721}, {380, 721}}
M[lvlno].switchSystem.window.PosiY = {{200, 400}, {400, 30}, {200, 230}, {400, 430}}

M[lvlno].dos_donts = {}
M[lvlno].dos_donts.Img = "dos_donts_14.png"
M[lvlno].dos_donts.Color = {0.25, 0.12, 0.0, 1}

M[lvlno].icon = {}
M[lvlno].icon.Img = "li_14.png"

return M