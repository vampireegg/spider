local M = {}

----------------------------------------Level 1----------------------------------------
M[1] = {}

M[1].spider = {}
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
M[1].portal.NumPairs = {0,0}
M[1].portal.PosiX = {{0,0}, {0,0}}
M[1].portal.PosiY = {{0,0}, {0,0}}

---------------------------------------- Level 2----------------------------------------
M[2] = {}


M[2].spider = {}
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
M[2].goal.PosiY = 380

M[2].bg = {}
M[2].bg.Img = "bbg2.jpg"
M[2].bg.Opacity = 1

M[2].eye = {}
M[2].eye.Opacity = 0

M[2].portal = {}
M[2].portal.NumPairs = {0,0}
M[2].portal.PosiX = {{0,0}, {0,0}}
M[2].portal.PosiY = {{0,0}, {0,0}}

---------------------------------------- Level 3----------------------------------------
M[3] = {}


M[3].spider = {}
M[3].spider.PosiX = 190
M[3].spider.PosiY = 150
M[3].spider.LegExists = {1,1,1,1,1,1,1,1}

M[3].collider = {}
M[3].collider.GroupX = {60, 550}
M[3].collider.GroupY = {280, 410}
M[3].collider.Num = {5, 8}
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
M[3].portal.NumPairs = {0,0}
M[3].portal.PosiX = {{0,0}, {0,0}}
M[3].portal.PosiY = {{0,0}, {0,0}}

---------------------------------------- Level 4----------------------------------------
M[4] = {}


M[4].spider = {}
M[4].spider.PosiX = 270
M[4].spider.PosiY = 150
M[4].spider.LegExists = {1,0,1,0,1,0,1,0}

M[4].collider = {}
M[4].collider.GroupX = {400, 650}
M[4].collider.GroupY = {50, 440}
M[4].collider.Num = {10, 3}
M[4].collider.Orientation = {2, 2}

M[4].goal = {}
M[4].goal.PosiX = 980
M[4].goal.PosiY = 530

M[4].bg = {}
M[4].bg.Img = "water.jpg"
M[4].bg.Opacity = 0.3

M[4].eye = {}
M[4].eye.Opacity = 0

M[4].portal = {}
M[4].portal.NumPairs = {1,1}
M[4].portal.PosiX = {{80,30}, {500,400}}
M[4].portal.PosiY = {{150,530}, {150,530}}

return M