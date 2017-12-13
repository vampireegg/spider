local M = {}

----------------------------------------Level 1----------------------------------------
M[1] = {}

M[1].collider = {}
M[1].collider.GroupX = {100}
M[1].collider.GroupY = {300}
M[1].collider.Num = {5}

M[1].spider = {}
M[1].spider.PosiX = 220
M[1].spider.PosiY = 150

M[1].goal = {}
M[1].goal.PosiX = 961
M[1].goal.PosiY = 495

---------------------------------------- Dummy Level 2----------------------------------------
M[2] = {}

M[2].collider = {}
M[2].collider.GroupX = {100}
M[2].collider.GroupY = {300}
M[2].collider.Num = {5}

M[2].spider = {}
M[2].spider.PosiX = 420
M[2].spider.PosiY = 150

M[2].goal = {}
M[2].goal.PosiX = 961
M[2].goal.PosiY = 295

return M