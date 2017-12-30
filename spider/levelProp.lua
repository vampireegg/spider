local M = {}

local OOF = 2000

----------------------------------------Level 1----------------------------------------
M[1] = {}

M[1].spider = {}
M[1].spider.MyScale = 0.2
M[1].spider.PosiX = 220
M[1].spider.PosiY = 200
M[1].spider.LegExists = {0,0,0,0,1,0,1,0}
M[1].spider.LegTapOrder = {5, 7}

M[1].collider = {}
M[1].collider.GroupX = {100}
M[1].collider.GroupY = {320}
M[1].collider.Num = {5}
M[1].collider.Orientation = {1}
M[1].collider.ColliderType = {1}

M[1].goal = {}
M[1].goal.PosiX = 980
M[1].goal.PosiY = 530

M[1].bg = {}
M[1].bg.Img = "bbg2.jpg"
M[1].bg.Opacity = 1
M[1].bg.ExtraImgExists = 1
M[1].bg.ExtraImg = {"tap_here.png", "tap_here2.png", "reload_here.png"}
M[1].bg.ExtraImgOpacity = {1, 0, 0}
M[1].bg.ExtraImgX = {90, 935, 910}
M[1].bg.ExtraImgY = {150, 100, 50}
M[1].bg.ExtraImgWidth = {285, 550, 572}
M[1].bg.ExtraImgHeight = {457, 162, 106}
M[1].bg.ExtraImgScale = {0.2, 0.2, 0.2}

M[1].eye = {}
M[1].eye.Opacity = 0

M[1].portal = {}
M[1].portal.Exists = 0
M[1].portal.Types = {}
M[1].portal.PosiX = {}
M[1].portal.PosiY = {}

M[1].dos_donts = {}
M[1].dos_donts.Img = "dos_donts_1.png"
M[1].dos_donts.Color = {0.4, 0.3, 0.2, 1}

M[1].icon = {}
M[1].icon.Img = "li_1.png"

---------------------------------------- Level 2----------------------------------------
M[2] = {}


M[2].spider = {}
M[2].spider.MyScale = 0.2
M[2].spider.PosiX = 90
M[2].spider.PosiY = 150
M[2].spider.LegExists = {1,1,1,1,1,1,1,1}

M[2].collider = {}
M[2].collider.GroupX = {30}
M[2].collider.GroupY = {300}
M[2].collider.Num = {8}
M[2].collider.Orientation = {1}
M[2].collider.ColliderType = {1}

M[2].goal = {}
M[2].goal.PosiX = 80
M[2].goal.PosiY = 400

M[2].bg = {}
M[2].bg.Img = "bbg2.jpg"
M[2].bg.Opacity = 1

M[2].eye = {}
M[2].eye.Opacity = 0

M[2].portal = {}
M[2].portal.Exists = 0
M[2].portal.Types = {}
M[2].portal.PosiX = {}
M[2].portal.PosiY = {}

M[2].dos_donts = {}
M[2].dos_donts.Img = "dos_donts_2.png"
M[2].dos_donts.Color = {0.6, 0.4, 0.3, 1}

M[2].icon = {}
M[2].icon.Img = "li_2.png"

---------------------------------------- Level 3----------------------------------------
M[3] = {}


M[3].spider = {}
M[3].spider.MyScale = 0.2
M[3].spider.PosiX = 230
M[3].spider.PosiY = 150
M[3].spider.LegExists = {1,1,1,1,1,1,1,1}

M[3].collider = {}
M[3].collider.GroupX = {70, 550}
M[3].collider.GroupY = {280, 410}
M[3].collider.Num = {5, 8}
M[3].collider.Orientation = {1, 1}
M[3].collider.ColliderType = {1,1}

M[3].goal = {}
M[3].goal.PosiX = 980
M[3].goal.PosiY = 530

M[3].bg = {}
M[3].bg.Img = "bbg2.jpg"
M[3].bg.Opacity = 1

M[3].eye = {}
M[3].eye.Opacity = 0

M[3].portal = {}
M[3].portal.Exists = 0
M[3].portal.Types = {}
M[3].portal.PosiX = {}
M[3].portal.PosiY = {}

M[3].dos_donts = {}
M[3].dos_donts.Img = "dos_donts_3.png"
M[3].dos_donts.Color = {0.5, 0.4, 0.3, 1}

M[3].icon = {}
M[3].icon.Img = "li_3.png"

---------------------------------------- Level 4----------------------------------------
M[4] = {}


M[4].spider = {}
M[4].spider.MyScale = 0.15
M[4].spider.PosiX = 90
M[4].spider.PosiY = 70
M[4].spider.LegExists = {1,0,1,0,1,0,1,0}

M[4].collider = {}
M[4].collider.GroupX = {50}
M[4].collider.GroupY = {300}
M[4].collider.Num = {18}
M[4].collider.Orientation = {1}
M[4].collider.ColliderType = {1}

M[4].goal = {}
M[4].goal.PosiX = 90
M[4].goal.PosiY = 530

M[4].bg = {}
M[4].bg.Img = "water.jpg"
M[4].bg.Opacity = 0.3

M[4].eye = {}
M[4].eye.Opacity = 0

M[4].portal = {}
M[4].portal.Exists = 1
M[4].portal.Types = {4}
M[4].portal.PosiX = {{800,800}}
M[4].portal.PosiY = {{70,400}}

M[4].dos_donts = {}
M[4].dos_donts.Img = "dos_donts_4.png"
M[4].dos_donts.Color = {0.3, 0.2, 0.4, 1}

M[4].icon = {}
M[4].icon.Img = "li_4.png"

---------------------------------------- Level 5----------------------------------------
M[5] = {}


M[5].spider = {}
M[5].spider.MyScale = 0.2
M[5].spider.PosiX = 270
M[5].spider.PosiY = 200
M[5].spider.LegExists = {1,0,1,0,1,0,1,0}

M[5].collider = {}
M[5].collider.GroupX = {400, 650, 880}
M[5].collider.GroupY = {50, 440, 50}
M[5].collider.Num = {10, 3, 2}
M[5].collider.Orientation = {2, 2, 2}
M[5].collider.ColliderType = {1,1,1}

M[5].goal = {}
M[5].goal.PosiX = 980
M[5].goal.PosiY = 530

M[5].bg = {}
M[5].bg.Img = "water.jpg"
M[5].bg.Opacity = 0.3

M[5].eye = {}
M[5].eye.Opacity = 0

M[5].portal = {}
M[5].portal.Exists = 1
M[5].portal.Types = {1,3}
M[5].portal.PosiX = {{90,750}, {90,500}}
M[5].portal.PosiY = {{200,200}, {500,90}}

M[5].dos_donts = {}
M[5].dos_donts.Img = "dos_donts_5.png"
M[5].dos_donts.Color = {0.3, 0.2, 0.5, 1}

M[5].icon = {}
M[5].icon.Img = "li_5.png"

---------------------------------------- Level 6----------------------------------------
M[6] = {}


M[6].spider = {}
M[6].spider.MyScale = 0.15
M[6].spider.PosiX = 70
M[6].spider.PosiY = 70
M[6].spider.LegExists = {1,1,1,1,1,1,1,1}

M[6].collider = {}
M[6].collider.GroupX = {550, 50, 600}
M[6].collider.GroupY = {50, 400, 300}
M[6].collider.Num = {10, 9, 8}
M[6].collider.Orientation = {2, 1, 1}
M[6].collider.ColliderType = {1,1,1}

M[6].goal = {}
M[6].goal.PosiX = 660
M[6].goal.PosiY = 170

M[6].bg = {}
M[6].bg.Img = "water.jpg"
M[6].bg.Opacity = 0.3

M[6].eye = {}
M[6].eye.Opacity = 0

M[6].portal = {}
M[6].portal.Exists = 1
M[6].portal.Types = {3,4,1,2}
M[6].portal.PosiX = {{270,270}, {270,660}, {140,800}, {140,1000}}
M[6].portal.PosiY = {{70,490}, {270,490}, {270,170}, {490,490}}

M[6].dos_donts = {}
M[6].dos_donts.Img = "dos_donts_6.png"
M[6].dos_donts.Color = {0.2, 0.4, 0.5, 1}

M[6].icon = {}
M[6].icon.Img = "li_6.png"

---------------------------------------- Level 7----------------------------------------
M[7] = {}


M[7].spider = {}
M[7].spider.MyScale = 0.15
M[7].spider.PosiX = 90
M[7].spider.PosiY = 90
M[7].spider.LegExists = {1,1,1,1,1,1,1,1}

M[7].collider = {}
M[7].collider.GroupX = {50, 250}
M[7].collider.GroupY = {300, 50}
M[7].collider.Num = {18,1}
M[7].collider.Orientation = {1, 2}
M[7].collider.ColliderType = {2, 1}

M[7].goal = {}
M[7].goal.PosiX = 90
M[7].goal.PosiY = 530

M[7].bg = {}
M[7].bg.Img = "leaf.jpg"
M[7].bg.Opacity = 0.3

M[7].eye = {}
M[7].eye.Opacity = 0

M[7].portal = {}
M[7].portal.Exists = 1
M[7].portal.Types = {2}
M[7].portal.PosiX = {{800,800}}
M[7].portal.PosiY = {{70,530}}

M[7].dos_donts = {}
M[7].dos_donts.Img = "dos_donts_7.png"
M[7].dos_donts.Color = {0.2, 0.3, 0.2, 1}

M[7].icon = {}
M[7].icon.Img = "li_7.png"

---------------------------------------- Level 8----------------------------------------

M[8] = {}

M[8].spider = {}
M[8].spider.MyScale = 0.15
M[8].spider.PosiX = 200
M[8].spider.PosiY = 150
M[8].spider.LegExists = {1,1,1,1,1,1,1,1}

M[8].collider = {}
M[8].collider.GroupX = {50, 50, 50, 1030}
M[8].collider.GroupY = {20, 280, 540, 100}
M[8].collider.Num = {18, 18, 18, 3}
M[8].collider.Orientation = {1, 1, 1, 2}
M[8].collider.ColliderType = {2, 2, 2, 2}

M[8].goal = {}
M[8].goal.PosiX = 830
M[8].goal.PosiY = 150

M[8].bg = {}
M[8].bg.Img = "leaf.jpg"
M[8].bg.Opacity = 0.3

M[8].eye = {}
M[8].eye.Opacity = 0

M[8].portal = {}
M[8].portal.Exists = 1
M[8].portal.Types = {2, 3, 4}
M[8].portal.PosiX = {{320,700}, {490,490}, {660,280}}
M[8].portal.PosiY = {{150,410}, {150,410}, {150,410}}

M[8].dos_donts = {}
M[8].dos_donts.Img = "dos_donts_8.png"
M[8].dos_donts.Color = {0.2, 0.2, 0.2, 1}

M[8].icon = {}
M[8].icon.Img = "li_8.png"

---------------------------------------- Level 9----------------------------------------

M[9] = {}

M[9].spider = {}
M[9].spider.MyScale = 0.1
M[9].spider.PosiX = 340
M[9].spider.PosiY = 80
M[9].spider.LegExists = {1,1,0,1,1,1,1,0}

M[9].collider = {}
M[9].collider.GroupX = {50, 50, 50, 930, 660, 400, 140, 930, 660, 400, 140}
M[9].collider.GroupY = {20, 290, 560, 90, 90, 90, 90, 360, 360, 360, 360}
M[9].collider.Num = {18, 18, 18, 3, 3, 3, 3, 3, 3, 3, 3}
M[9].collider.Orientation = {1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2}
M[9].collider.ColliderType = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

M[9].goal = {}
M[9].goal.PosiX = 870
M[9].goal.PosiY = 80

M[9].bg = {}
M[9].bg.Img = "water.jpg"
M[9].bg.Opacity = 0.3

M[9].eye = {}
M[9].eye.Opacity = 0

M[9].portal = {}
M[9].portal.Exists = 1
M[9].portal.Types = {6, 2, 3, 5, 4, 1, 7, 8}
M[9].portal.PosiX = {{340, 720}, {200, 200}, {870, 870}, {720, 460}, {600, 600}, {460, 720}, {340, 600}, {870, 200}}
M[9].portal.PosiY = {{230, 500}, {80,  500}, {500, 230}, {80,  350}, {500,  80}, {80,  230}, {350, 230}, {350, 230}}

M[9].dos_donts = {}
M[9].dos_donts.Img = "dos_donts_9.png"
M[9].dos_donts.Color = {0.2, 0.2, 0.3, 1}

M[9].icon = {}
M[9].icon.Img = "li_9.png"

---------------------------------------- Level 10----------------------------------------

M[10] = {}


M[10].spider = {}
M[10].spider.MyScale = 0.15
M[10].spider.PosiX = 70
M[10].spider.PosiY = 70
M[10].spider.LegExists = {1,1,1,1,1,1,1,1}

M[10].collider = {}
M[10].collider.GroupX = {350, 90}
M[10].collider.GroupY = {90, 350}
M[10].collider.Num = {2, 2}
M[10].collider.Orientation = {2, 1}
M[10].collider.ColliderType = {1, 1}

M[10].goal = {}
M[10].goal.PosiX = 746
M[10].goal.PosiY = 536

M[10].bg = {}
M[10].bg.Img = "bricks.jpg"
M[10].bg.Opacity = 0.2

M[10].eye = {}
M[10].eye.Opacity = 0

M[10].portal = {}
M[10].portal.Exists = 1
M[10].portal.Types = {5, 4, 3}
M[10].portal.PosiX = {{536,OOF}, {882, -OOF}, {1002, OOF}}
M[10].portal.PosiY = {{536,OOF}, {393, -OOF}, {319, -OOF}}

M[10].heartExists = 1
M[10].heart = {}
M[10].heart.PosiX = {290}
M[10].heart.PosiY = {290}

M[10].dos_donts = {}
M[10].dos_donts.Img = "dos_donts_10.png"
M[10].dos_donts.Color = {0.3, 0.1, 0.2, 1}

M[10].icon = {}
M[10].icon.Img = "li_10.png"

---------------------------------------- Level 11----------------------------------------

M[11] = {}


M[11].spider = {}
M[11].spider.MyScale = 0.15
M[11].spider.PosiX = 150
M[11].spider.PosiY = 250
M[11].spider.LegExists = {1,0,1,0,1,0,1,0}

M[11].collider = {}
M[11].collider.GroupX = {300, 400, 700, 800, 180, 415, 815}
M[11].collider.GroupY = {170, 170, 170, 170, 130, 130, 130}
M[11].collider.Num = {8, 5, 8, 8, 3, 6, 5}
M[11].collider.Orientation = {2, 2, 2, 2, 1, 1, 1}
M[11].collider.ColliderType = {2, 1, 2, 1, 1, 1, 2}

M[11].goal = {}
M[11].goal.PosiX = 876
M[11].goal.PosiY = 530

M[11].bg = {}
M[11].bg.Img = "bricks.jpg"
M[11].bg.Opacity = 0.2

M[11].eye = {}
M[11].eye.Opacity = 0

M[11].portal = {}
M[11].portal.Exists = 1
M[11].portal.Types = {1, 5, 4, 2, 3}
M[11].portal.PosiX = {{63,  570}, {470, 570}, {470, 970}, {630, OOF}, {230, -OOF}}
M[11].portal.PosiY = {{120, 300}, {206, 530}, {530, 300}, {206, OOF}, {250, -OOF}}

M[11].heartExists = 1
M[11].heart = {}
M[11].heart.PosiX = {63}
M[11].heart.PosiY = {400}

M[11].dos_donts = {}
M[11].dos_donts.Img = "dos_donts_11.png"
M[11].dos_donts.Color = {0.25, 0.0, 0.12, 1}

M[11].icon = {}
M[11].icon.Img = "li_11.png"

---------------------------------------- Level 12----------------------------------------

M[12] = {}


M[12].spider = {}
M[12].spider.MyScale = 0.15
M[12].spider.PosiX = 730
M[12].spider.PosiY = 80
M[12].spider.LegExists = {1,1,1,1,1,1,1,1}

M[12].collider = {}
M[12].collider.GroupX = {550, 730, 230, 180, 910}
M[12].collider.GroupY = {60, 200, 200, 50, 50}
M[12].collider.Num = {3, 3, 3, 10, 10}
M[12].collider.Orientation = {2, 1, 1, 2, 2}
M[12].collider.ColliderType = {1, 1, 1, 1, 1}

M[12].goal = {}
M[12].goal.PosiX = 260
M[12].goal.PosiY = 63

M[12].bg = {}
M[12].bg.Img = "bricks.jpg"
M[12].bg.Opacity = 0.3

M[12].eye = {}
M[12].eye.Opacity = 0

M[12].portal = {}
M[12].portal.Exists = 0
M[12].portal.Types = {}
M[12].portal.PosiX = {}
M[12].portal.PosiY = {}

M[12].heartExists = 1
M[12].heart = {}
M[12].heart.PosiX = {378}
M[12].heart.PosiY = {332}

M[12].dos_donts = {}
M[12].dos_donts.Img = "dos_donts_12.png"
M[12].dos_donts.Color = {0.12, 0.25, 0.35, 1}

M[12].icon = {}
M[12].icon.Img = "li_12.png"

---------------------------------------- Level 13----------------------------------------

M[13] = {}


M[13].spider = {}
M[13].spider.MyScale = 0.15
M[13].spider.PosiX = 70
M[13].spider.PosiY = 80
M[13].spider.LegExists = {1,1,1,1,1,1,1,1}

M[13].collider = {}
M[13].collider.GroupX = {}
M[13].collider.GroupY = {}
M[13].collider.Num = {}
M[13].collider.Orientation = {}
M[13].collider.ColliderType = {}

M[13].goal = {}
M[13].goal.PosiX = 375
M[13].goal.PosiY = 536

M[13].bg = {}
M[13].bg.Img = "zebra.jpg"
M[13].bg.Opacity = 0.3

M[13].eye = {}
M[13].eye.Opacity = 0

M[13].portal = {}
M[13].portal.Exists = 0
M[13].portal.Types = {}
M[13].portal.PosiX = {}
M[13].portal.PosiY = {}

M[13].heartExists = 0

M[13].switchSystemExists = 1
M[13].switchSystem = {}
M[13].switchSystem.Num = 1
M[13].switchSystem.Color = {{1,1,1}}
M[13].switchSystem.switch = {}
M[13].switchSystem.switch.PosiX = {1002}
M[13].switchSystem.switch.PosiY = {224}
M[13].switchSystem.window = {}
M[13].switchSystem.window.Orientation = {{1, 2}}
M[13].switchSystem.window.State = {{1, 0}}
M[13].switchSystem.window.Num = {{37, 8}}
M[13].switchSystem.window.PosiX = {{30, 500}}
M[13].switchSystem.window.PosiY = {{300, 350}}

M[13].dos_donts = {}
M[13].dos_donts.Img = "dos_donts_12.png"
M[13].dos_donts.Color = {0.12, 0.25, 0.35, 1}

M[13].icon = {}
M[13].icon.Img = "li_13.png"


---------------------------------------- Level 14----------------------------------------

M[14] = {}


M[14].spider = {}
M[14].spider.MyScale = 0.15
M[14].spider.PosiX = 70
M[14].spider.PosiY = 80
M[14].spider.LegExists = {1,1,1,1,1,1,1,1}

M[14].collider = {}
M[14].collider.GroupX = {450, 260}
M[14].collider.GroupY = {60,  300}
M[14].collider.Num = {7, 3}
M[14].collider.Orientation = {2, 1}
M[14].collider.ColliderType = {1, 1}

M[14].goal = {}
M[14].goal.PosiX = 520
M[14].goal.PosiY = 63

M[14].bg = {}
M[14].bg.Img = "zebra.jpg"
M[14].bg.Opacity = 0.3

M[14].eye = {}
M[14].eye.Opacity = 0

M[14].portal = {}
M[14].portal.Exists = 1
M[14].portal.Types = {1}
M[14].portal.PosiX = {{1002, 373}}
M[14].portal.PosiY = {{536, 63}}

M[14].heartExists = 0

M[14].switchSystemExists = 1
M[14].switchSystem = {}
M[14].switchSystem.Num = 2
M[14].switchSystem.Color = {{1,1,1}, {1,1,0.3}}
M[14].switchSystem.switch = {}
M[14].switchSystem.switch.PosiX = {214, 500}
M[14].switchSystem.switch.PosiY = {224, 536}
M[14].switchSystem.window = {}
M[14].switchSystem.window.Orientation = {{1, 1}, {1, 1}}
M[14].switchSystem.window.State = {{1, 0},{1, 0}}
M[14].switchSystem.window.Num = {{7, 10}, {1, 10}}
M[14].switchSystem.window.PosiX = {{30, 800},{323, 500}}
M[14].switchSystem.window.PosiY = {{300, 300},{113, 300}}

M[14].dos_donts = {}
M[14].dos_donts.Img = "dos_donts_12.png"
M[14].dos_donts.Color = {0.12, 0.25, 0.35, 1}

M[14].icon = {}
M[14].icon.Img = "li_12.png"

return M