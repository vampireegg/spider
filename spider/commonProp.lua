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
M.collider.Width = {M.collider.MyScale * 70, M.collider.MyScale * 20}
M.collider.Img = {"collider.png", "bouncer3.png"}
M.collider.CommonName = {"collider", "bouncer"}


M.goal = {}
M.goal.Size = 70

M.portal = {}
M.portal.Img = {"ptr.png", "ptw.png", "ptb.png", "ptg.png" }
M.portal.Size = 50


return M