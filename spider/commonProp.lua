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

M.heart = {}
M.heart.Img = "heart2.png"
M.heart.Size = 100

M.level_select_screen = {}
M.level_select_screen.Color = {0.7, 0.5, 0.3, 1}
M.level_select_screen.Img = "level_select3.jpg"


return M