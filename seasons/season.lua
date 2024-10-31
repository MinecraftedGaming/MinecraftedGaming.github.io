local spring_side = "left"
local summer_side = "front"
local fall_side = "right"
local winter_side = "back"

---custom message at bottom of screen
---16 char max (for default scale)
local message = ""

---sign that shows when screen updates
local update_sign = "x"

---scale of the text on screen
---max of 1.5 recommended | 0.5 min | multiples of 0.5 only
local text_size = 1

---Season prefix editor
local early_txt = "Early"
local mid_txt = "Mid"
local MID_txt = "MID"
local late_txt = "Late"

---Season name editor
local spring_txt = "spring"
local summer_txt = "summer"
local fall_txt = "fall"
local winter_txt = "winter"
---what to show if computer cant find what season it is
local unknown_season_txt = "unkown season"

---length between updates in seconds
local rate = 1


-----------------------------------
---DO NOT CHANGE PAST THIS POINT---
-----------------------------------

function round(n)
    return math.floor((math.floor(n*2) + 1)/2)
end

local monitor = peripheral.find("monitor")
while true do
local spring = redstone.getAnalogInput(spring_side)
local summer = redstone.getAnalogInput(summer_side)
local fall = redstone.getAnalogInput(fall_side)
local winter = redstone.getAnalogInput(winter_side)
local layout = spring .. " " .. summer .. " " .. fall .. " " .. winter
monitor.setCursorPos(1,1)
monitor.clear()
monitor.setTextScale(1)
if spring > 0 then
    if spring <5 then
        monitor.write(early_txt .. " " .. spring_txt)
    elseif spring == 7 then
        monitor.write(MID_txt .. " " .. spring_txt)
    elseif spring < 10 then
        monitor.write(mid_txt .. " " .. spring_txt)
    else 
        monitor.write(late_txt .. " " .. spring_txt)
    end
    monitor.setCursorPos(1,2)
    monitor.write(round((spring/15)*100) .. "%")
elseif summer > 0 then
    if summer <5 then
        monitor.write(early_txt .. " " .. summer_txt)
    elseif summer == 7 then
        monitor.write(MID_txt .. " " .. summer_txt)
    elseif summer < 10 then
        monitor.write(mid_txt .. " " .. summer_txt)
    else 
        monitor.write(late_txt .. " " .. summer_txt)
    end
    monitor.setCursorPos(1,2)
    monitor.write(round((summer/15)*100) .. "%")
elseif fall > 0 then
    if fall <5 then
        monitor.write(early_txt .. " " .. fall_txt)
    elseif fall == 7 then
        monitor.write(MID_txt .. " " .. fall_txt)
    elseif fall < 10 then
        monitor.write(mid_txt .. " " .. fall_txt)
    else 
        monitor.write(late_txt .. " " .. fall_txt)
end
monitor.setCursorPos(1,2)
monitor.write(round((fall/15)*100) .. "%")
elseif winter > 0 then
    if winter <5 then
        monitor.write(early_txt .. " " .. winter_txt)
    elseif winter == 7 then
        monitor.write(MID_txt .. " " .. winter_txt)
    elseif winter < 10 then
        monitor.write(mid_txt .. " " .. winter_txt)
    else 
        monitor.write(late_txt .. " " .. winter_txt)
    end
    monitor.setCursorPos(1,2)
    monitor.write(round((winter/15)*100) .. "%")
else
    monitor.write(unknown_season_txt)
end
monitor.setCursorPos(1,3)
monitor.write(layout)
monitor.setCursorPos(1,4)
monitor.write(update_sign)
os.sleep(.1)
monitor.clearLine()
monitor.setCursorPos(1,5)
monitor.write(message)
os.sleep(rate)
end
