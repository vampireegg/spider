local M = {}

----------------------------------------Level 1----------------------------------------
M[1] = {}

M[1].spider = {}
M[1].spider.MyScale = 0.2
M[1].spider.PosiX = 220
M[1].spider.PosiY = 150
M[1].spider.LegExists = {1,1,1,1,1,1,1,1}

M[1].collider = {}
M[1].collider.GroupX = {100}
M[1].collider.GroupY = {300}
M[1].collider.Num = {5}
M[1].collider.Orientation = {1}

M[1].goal = {}
M[1].goal.PosiX = 980
M[1].goal.PosiY = 530

M[1].bg = {}
M[1].bg.Img = "bbg2.jpg"
M[1].bg.Opacity = 1

M[1].eye = {}
M[1].eye.Opacity = 0

M[1].portal = {}
M[1].portal.Exists = 0
M[1].portal.Types = {}
M[1].portal.PosiX = {}
M[1].portal.PosiY = {}

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

---------------------------------------- Level 3----------------------------------------
M[3] = {}


M[3].spider = {}
M[3].spider.MyScale = 0.2
M[3].spider.PosiX = 230
M[3].spider.PosiY = 150
M[3].spider.LegExists = {1,1,1,1,1,1,1,1}

M[3].collider = {}
M[3].collider.GroupX = {90, 550}
M[3].collider.GroupY = {280, 410}
M[3].collider.Num = {4, 8}
M[3].collider.Orientation = {1, 1}

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

---------------------------------------- Level 4----------------------------------------
M[4] = {}


M[4].spider = {}
M[4].spider.MyScale = 0.2
M[4].spider.PosiX = 270
M[4].spider.PosiY = 200
M[4].spider.LegExists = {1,0,1,0,1,0,1,0}

M[4].collider = {}
M[4].collider.GroupX = {400, 650, 880}
M[4].collider.GroupY = {50, 440, 50}
M[4].collider.Num = {10, 3, 2}
M[4].collider.Orientation = {2, 2, 2}

M[4].goal = {}
M[4].goal.PosiX = 980
M[4].goal.PosiY = 530

M[4].bg = {}
M[4].bg.Img = "water.jpg"
M[4].bg.Opacity = 0.3

M[4].eye = {}
M[4].eye.Opacity = 0

M[4].portal = {}
M[4].portal.Exists = 1
M[4].portal.Types = {1,3}
M[4].portal.PosiX = {{90,750}, {90,500}}
M[4].portal.PosiY = {{200,200}, {500,90}}

---------------------------------------- Level 5----------------------------------------
M[5] = {}


M[5].spider = {}
M[5].spider.MyScale = 0.15
M[5].spider.PosiX = 70
M[5].spider.PosiY = 70
M[5].spider.LegExists = {1,1,1,1,1,1,1,1}

M[5].collider = {}
M[5].collider.GroupX = {550, 50, 600}
M[5].collider.GroupY = {50, 400, 300}
M[5].collider.Num = {10, 9, 8}
M[5].collider.Orientation = {2, 1, 1}

M[5].goal = {}
M[5].goal.PosiX = 660
M[5].goal.PosiY = 170

M[5].bg = {}
M[5].bg.Img = "water.jpg"
M[5].bg.Opacity = 0.3

M[5].eye = {}
M[5].eye.Opacity = 0

M[5].portal = {}
M[5].portal.Exists = 1
M[5].portal.Types = {3,4,1,2}
M[5].portal.PosiX = {{270,270}, {270,660}, {140,1000}, {140,1000}}
M[5].portal.PosiY = {{70,490}, {270,490}, {270,170}, {490,490}}

return M