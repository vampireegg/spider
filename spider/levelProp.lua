local M = {}

local OOF = 2000

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
M[1].collider.ColliderType = {1}

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

M[1].dos_donts = {}
M[1].dos_donts.Img = "dos_donts_1.png"
M[1].dos_donts.Color = {0.4, 0.3, 0.2, 1}

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

-- ---------------------------------------- Level 9----------------------------------------

-- M[9] = {}

-- M[9].spider = {}
-- M[9].spider.MyScale = 0.15
-- M[9].spider.PosiX = 200
-- M[9].spider.PosiY = 150
-- M[9].spider.LegExists = {1,1,1,1,1,1,1,1}

-- M[9].collider = {}
-- M[9].collider.GroupX = {50, 50, 50, 1030}
-- M[9].collider.GroupY = {20, 280, 540, 100}
-- M[9].collider.Num = {18, 18, 18, 3}
-- M[9].collider.Orientation = {1, 1, 1, 2}
-- M[9].collider.ColliderType = {2, 2, 2, 2}

-- M[9].goal = {}
-- M[9].goal.PosiX = 830
-- M[9].goal.PosiY = 150

-- M[9].bg = {}
-- M[9].bg.Img = "leaf.jpg"
-- M[9].bg.Opacity = 0.3

-- M[9].eye = {}
-- M[9].eye.Opacity = 0

-- M[9].portal = {}
-- M[9].portal.Exists = 0
-- M[9].portal.Types = {}
-- M[9].portal.PosiX = {}
-- M[9].portal.PosiY = {}

-- M[9].dos_donts = {}
-- M[9].dos_donts.Img = "dos_donts_8.png"
-- M[9].dos_donts.Color = {0.2, 0.2, 0.2, 1}

return M