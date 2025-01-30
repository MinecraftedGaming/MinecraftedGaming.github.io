local b1x = 2
local b1y = 2
local b1h = 3
local b1txt = "new cards"
local b1io = false
local b1w = b1txt:len() + 2
local b1a = tostring(settings.get("card.option.1"))

local b2x = 14
local b2y = 2
local b2h = 3
local b2txt = "transactions"
local b2io = false
local b2w = b1txt:len() + 2
local b2a = tostring(settings.get("card.option.2"))

local b3x = 29
local b3y = 2
local b3h = 3
local b3txt = "Debt"
local b3io = false
local b3w = b1txt:len() + 2
local b3a = tostring(settings.get("card.option.3"))

local ontxt = "on"
local offtxt = "off"

term.clear()
paintutils.drawFilledBox(1, 1, 43, 17, colors.gray)

function b1f()
    paintutils.drawFilledBox(b1x, b1y, b1x + b1w - 1, b1y + b1h - 1, colors.gray)
    if b1io == true then
        b1txt = offtxt
    end
    b1w = b1txt:len() + 2
    paintutils.drawFilledBox(b1x, b1y, b1x + b1w - 1, b1y + b1h - 1, colors.red)
    term.setBackgroundColor(colors.red)
    term.setCursorPos(b1x + 1, b1y + (b1h / 2))
    term.write(b1txt)
    b1a = "false"
    settings.set("card.option.1", false)
    settings.save()
end

function b1t()
    paintutils.drawFilledBox(b1x, b1y, b1x + b1w - 1, b1y + b1h - 1, colors.gray)
    if b1io == true then
        b1txt = ontxt
    end
    b1w = b1txt:len() + 2
    paintutils.drawFilledBox(b1x, b1y, b1x + b1w - 1, b1y + b1h - 1, colors.green)
    term.setBackgroundColor(colors.green)
    term.setCursorPos(b1x + 1, b1y + (b1h / 2))
    term.write(b1txt)
    b1a = "true"
    settings.set("card.option.1", true)
    settings.save()
end

function b2f()
    paintutils.drawFilledBox(b2x, b2y, b2x + b2w - 1, b2y + b2h - 1, colors.gray)
    if b2io == true then
        b2txt = offtxt
    end
    b2w = b2txt:len() + 2
    paintutils.drawFilledBox(b2x, b2y, b2x + b2w - 1, b2y + b2h - 1, colors.red)
    term.setBackgroundColor(colors.red)
    term.setCursorPos(b2x + 1, b2y + (b2h / 2))
    term.write(b2txt)
    b2a = "false"
    settings.set("card.option.2", false)
    settings.save()
end

function b2t()
    paintutils.drawFilledBox(b2x, b2y, b2x + b2w - 1, b2y + b2h - 1, colors.gray)
    if b2io == true then
        b2txt = ontxt
    end
    b2w = b2txt:len() + 2
    paintutils.drawFilledBox(b2x, b2y, b2x + b2w - 1, b2y + b2h - 1, colors.green)
    term.setBackgroundColor(colors.green)
    term.setCursorPos(b2x + 1, b2y + (b2h / 2))
    term.write(b2txt)
    b2a = "true"
    settings.set("card.option.2", true)
    settings.save()
end

function b3f()
    paintutils.drawFilledBox(b3x, b3y, b3x + b3w - 1, b3y + b3h - 1, colors.gray)
    if b3io == true then
        b3txt = offtxt
    end
    b3w = b3txt:len() + 2
    paintutils.drawFilledBox(b3x, b3y, b3x + b3w - 1, b3y + b3h - 1, colors.red)
    term.setBackgroundColor(colors.red)
    term.setCursorPos(b3x + 1, b3y + (b3h / 2))
    term.write(b3txt)
    b3a = "false"
    settings.set("card.option.3", false)
    settings.save()
end

function b3t()
    paintutils.drawFilledBox(b3x, b3y, b3x + b3w - 1, b3y + b3h - 1, colors.gray)
    if b3io == true then
        b3txt = ontxt
    end
    b3w = b3txt:len() + 2
    paintutils.drawFilledBox(b3x, b3y, b3x + b3w - 1, b3y + b3h - 1, colors.green)
    term.setBackgroundColor(colors.green)
    term.setCursorPos(b3x + 1, b3y + (b3h / 2))
    term.write(b3txt)
    b3a = "true"
    settings.set("card.option.3", true)
    settings.save()
end

if b1a == "true" then
    b1t()
else
    b1f()
end
if b2a == "true" then
    b2t()
else
    b2f()
end
if b3a == "true" then
    b3t()
else
    b3f()
end

term.setCursorPos(43, 1)
term.setBackgroundColor(colors.red)
term.write("x")

x = 0

while true do
    term.setBackgroundColour(colours.black)
    term.setCursorPos(1, 18)
    local event, button, x, y = os.pullEvent("mouse_click")
    if x == 43 and y == 1 then
        term.clear()
        term.setCursorPos(1, 1)
        term.setBackgroundColor(colors.black)
        goto stop
    end
    if y >= b1y and y <= b1y + b1h - 1 then
        if x >= b1x and x <= b1x + b1w - 1 then
            if b1a == "false" then
                b1t()
            else
                b1f()
            end
        elseif x >= b2x and x <= b2x + b2w - 1 then
            if b2a == "false" then
                b2t()
            else
                b2f()
            end
        elseif x >= b3x and x <= b3x + b3w - 1 then
            if b3a == "false" then
                b3t()
            else
                b3f()
            end
        end
    end
end
::stop::
