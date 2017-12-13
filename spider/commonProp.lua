local M = {}

M.total = {}
M.total.Width = 600
M.total.Height = 1066

M.border = {}
M.border.Width = 2

M.collider = {}
M.collider.MyScale = 0.8
M.collider.Height = M.collider.MyScale * 36
M.collider.Width = M.collider.MyScale * 70

M.spider = {}
M.spider.MyScale = 0.2
M.spider.ArrowSize = 83.5 * M.spider.MyScale
M.spider.BodySize = 487 * M.spider.MyScale
M.spider.ArrowDistance = 365 * M.spider.MyScale
M.spider.SpiderRadius = M.spider.ArrowDistance + M.spider.ArrowSize

M.goal = {}
M.goal.Size = 100

return M