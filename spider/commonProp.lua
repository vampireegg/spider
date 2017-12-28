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

M.reload_here = {}
M.reload_here.Img = "reload_here.png"
M.reload_here.PosiX = 910
M.reload_here.PosiY = 50
M.reload_here.Width = 572
M.reload_here.Height = 106
M.reload_here.Scale = 0.2

M.heart = {}
M.heart.Img = "heart1.png"
M.heart.Size = 100

M.level_select_screen = {}
M.level_select_screen.Color = {0.9, 0.9, 0.9, 0.4}
M.level_select_screen.Img = "splash3.jpg"

M.splash = {}
M.splash.Img = "splash2.jpg"


return M