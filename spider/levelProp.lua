local M = {}

----------------------------------------Level 1----------------------------------------
M[1] = {}

M[1].spider = {}
M[1].spider.PosiX = 220
M[1].spider.PosiY = 150

M[1].collider = {}
M[1].collider.GroupX = {100}
M[1].collider.GroupY = {300}
M[1].collider.Num = {5}

M[1].goal = {}
M[1].goal.PosiX = 980
M[1].goal.PosiY = 530

M[1].bg = {}
M[1].bg.Img = "bbg2.jpg"
M[1].bg.Opacity = 1

---------------------------------------- Level 2----------------------------------------
M[2] = {}


M[2].spider = {}
M[2].spider.PosiX = 90
M[2].spider.PosiY = 150

M[2].collider = {}
M[2].collider.GroupX = {30}
M[2].collider.GroupY = {300}
M[2].collider.Num = {8}

M[2].goal = {}
M[2].goal.PosiX = 80
M[2].goal.PosiY = 380

M[2].bg = {}
M[2].bg.Img = "tree2.jpg"
M[2].bg.Opacity = 0.4

---------------------------------------- Level 3----------------------------------------
M[3] = {}


M[3].spider = {}
M[3].spider.PosiX = 190
M[3].spider.PosiY = 150

M[3].collider = {}
M[3].collider.GroupX = {60, 550}
M[3].collider.GroupY = {280, 410}
M[3].collider.Num = {5, 8}

M[3].goal = {}
M[3].goal.PosiX = 980
M[3].goal.PosiY = 530

M[3].bg = {}
M[3].bg.Img = "tree2.jpg"
M[3].bg.Opacity = 0.4

return M