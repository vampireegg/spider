local M = {}

M.total = {}
M.total.Width = 600
M.total.Height = 1066

M.border = {}
M.border.Width = 2
M.border.CommonName = "border"

M.collider = {}
M.collider.MyScale = 0.8
M.collider.Height = M.collider.MyScale * 36
M.collider.Width = {M.collider.MyScale * 70, M.collider.MyScale * 70}
M.collider.Img = {"collider.png", "bouncer8.png"}
M.collider.CommonName = {"collider", "bouncer"}


M.goal = {}
M.goal.Size = 70

M.portal = {}
M.portal.Img = {"ptr.png", "ptw.png", "ptb.png", "ptg.png",  "ptfw.png", "ptfb.png", "ptbl.png", "ptrb.png"}
M.portal.Size = 50

M.switchSystem = {}
M.switchSystem.switch = {}
M.switchSystem.switch.Img = "switch.png"
M.switchSystem.switch.Width = 282
M.switchSystem.switch.Height = 277
M.switchSystem.switch.Scale = 0.2
M.switchSystem.window = {}
M.switchSystem.window.Img = "barricade3.png"
M.switchSystem.window.Scale = 0.17
M.switchSystem.window.Width = 161 * M.switchSystem.window.Scale
M.switchSystem.window.Height = 161 * M.switchSystem.window.Scale
 

 
M.noti = {}
M.noti.Img = {"use_all_legs.png", "out_of_the_world.png", "bad_moves_reloading.png"}
M.noti.PosiX = {M.total.Height / 2, M.total.Height / 2, M.total.Height / 2}
M.noti.PosiY = {M.total.Width / 2, M.total.Width / 2, M.total.Width / 2}
M.noti.Width = {449, 398, 973}
M.noti.Height = {52, 63, 85}
M.noti.Scale = {0.5, 0.5, 0.5}
M.noti.Opacity = {0, 0, 0}
M.noti.RectOpacity = {0, 0, 0}

M.nextMove = {}
M.nextMove.Img = "nextMove.png"
M.nextMove.Width = 290
M.nextMove.Height = 61
M.nextMove.Scale = 0.4



M.heart = {}
M.heart.Img = "heart7.png"
M.heart.Size = 100

M.level_select_screen = {}
M.level_select_screen.Color = {0.9, 0.9, 0.9, 0.4}
M.level_select_screen.Img = "splash3.jpg"

M.splash = {}
M.splash.Img = "splash2.jpg"

M.title = {}
M.title.Img = {"amazeing.png", "spider.png", "vampireegg.png"}
M.title.Width = {1613, 603, 1920}
M.title.Height = {550, 191, 1080}
M.title.Color = {0.3, 0.12, 0.21, 1}

return M