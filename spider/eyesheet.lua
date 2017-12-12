--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:cc30828ba69abae9a959b0f41556d092:4bc40f7edaa1084c5034542195130b1b:54c9d37194c8886a2ea4fde487583249$
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
            width=790,
            height=276,

            sourceX = 566,
            sourceY = 278,
            sourceWidth = 1920,
            sourceHeight = 1040
        },
        {
            -- eye2
            x=793,
            y=1,
            width=790,
            height=276,

            sourceX = 566,
            sourceY = 278,
            sourceWidth = 1920,
            sourceHeight = 1040
        },
        {
            -- eye3
            x=1,
            y=279,
            width=790,
            height=276,

            sourceX = 566,
            sourceY = 278,
            sourceWidth = 1920,
            sourceHeight = 1040
        },
        {
            -- eye4
            x=793,
            y=279,
            width=790,
            height=276,

            sourceX = 566,
            sourceY = 278,
            sourceWidth = 1920,
            sourceHeight = 1040
        },
    },
    
    sheetContentWidth = 1584,
    sheetContentHeight = 556
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
