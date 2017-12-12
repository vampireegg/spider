--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:3e24134736dd5e1b6f6879c2cd154d93:b900ea61cda327add8a6d7f743341405:cf8ab4992190eb44f97f06311ef326d7$
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
            -- spd3
            x=1,
            y=1,
            width=461,
            height=507,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 463,
            sourceHeight = 509
        },
        {
            -- spd4
            x=1,
            y=510,
            width=461,
            height=507,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 463,
            sourceHeight = 509
        },
        {
            -- spd5
            x=464,
            y=1,
            width=461,
            height=507,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 463,
            sourceHeight = 509
        },
        {
            -- spd6
            x=464,
            y=510,
            width=461,
            height=507,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 463,
            sourceHeight = 509
        },
        {
            -- spd7
            x=927,
            y=1,
            width=461,
            height=507,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 463,
            sourceHeight = 509
        },
    },
    
    sheetContentWidth = 1389,
    sheetContentHeight = 1018
}

SheetInfo.frameIndex =
{

    ["spd3"] = 1,
    ["spd4"] = 2,
    ["spd5"] = 3,
    ["spd6"] = 4,
    ["spd7"] = 5,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
