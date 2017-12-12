--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e492ba95184de52cfc79bb5b90dc2bca:e732b981c4e9d5e436980742f4392b07:54c9d37194c8886a2ea4fde487583249$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- eye1
            x=1,
            y=1,
            width=162,
            height=58,

            sourceX = 111,
            sourceY = 54,
            sourceWidth = 384,
            sourceHeight = 208
        },
        {
            -- eye2
            x=165,
            y=1,
            width=162,
            height=58,

            sourceX = 111,
            sourceY = 54,
            sourceWidth = 384,
            sourceHeight = 208
        },
        {
            -- eye3
            x=329,
            y=1,
            width=162,
            height=58,

            sourceX = 111,
            sourceY = 54,
            sourceWidth = 384,
            sourceHeight = 208
        },
        {
            -- eye4
            x=493,
            y=1,
            width=162,
            height=58,

            sourceX = 111,
            sourceY = 54,
            sourceWidth = 384,
            sourceHeight = 208
        },
    },
    
    sheetContentWidth = 656,
    sheetContentHeight = 60
}

SheetInfo.frameIndex =
{

    ["eye1"] = 1,
    ["eye2"] = 2,
    ["eye3"] = 3,
    ["eye4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
