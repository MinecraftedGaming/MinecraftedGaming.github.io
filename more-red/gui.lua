local monitor = peripheral.find("monitor")

::start::
monitor.clear()
monitor.setTextScale(0.5)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", math.random(1, 65535))
os.sleep(.1)
rs.setBundledOutput("back", 0)
os.sleep(1)
rs.setBundledOutput("back", 1)
os.sleep(.1)
rs.setBundledOutput("back", 2)
os.sleep(.1)
rs.setBundledOutput("back", 4)
os.sleep(.1)
rs.setBundledOutput("back", 8)
os.sleep(.1)
rs.setBundledOutput("back", 16)
os.sleep(.1)
rs.setBundledOutput("back", 32)
os.sleep(.1)
rs.setBundledOutput("back", 64)
os.sleep(.1)
rs.setBundledOutput("back", 128)
os.sleep(.1)
rs.setBundledOutput("back", 256)
os.sleep(.1)
rs.setBundledOutput("back", 512)
os.sleep(.1)
rs.setBundledOutput("back", 1024)
os.sleep(.1)
rs.setBundledOutput("back", 2048)
os.sleep(.1)
rs.setBundledOutput("back", 4096)
os.sleep(.1)
rs.setBundledOutput("back", 8192)
os.sleep(.1)
rs.setBundledOutput("back", 16384)
os.sleep(.1)
rs.setBundledOutput("back", 32768)
os.sleep(.1)
rs.setBundledOutput("back", 0)
os.sleep(1)
rs.setBundledOutput("back", 1)
os.sleep(.1)
rs.setBundledOutput("back", 2)
os.sleep(.1)
rs.setBundledOutput("back", 4)
os.sleep(.1)
rs.setBundledOutput("back", 8)
os.sleep(.1)
rs.setBundledOutput("back", 16)
os.sleep(.1)
rs.setBundledOutput("back", 32)
os.sleep(.1)
rs.setBundledOutput("back", 64)
os.sleep(.1)
rs.setBundledOutput("back", 128)
os.sleep(.1)
rs.setBundledOutput("back", 256)
os.sleep(.1)
rs.setBundledOutput("back", 512)
os.sleep(.1)
rs.setBundledOutput("back", 1024)
os.sleep(.1)
rs.setBundledOutput("back", 2048)
os.sleep(.1)
rs.setBundledOutput("back", 4096)
os.sleep(.1)
rs.setBundledOutput("back", 8192)
os.sleep(.1)
rs.setBundledOutput("back", 16384)
os.sleep(.1)
rs.setBundledOutput("back", 32768)
os.sleep(.1)
rs.setBundledOutput("back", 0)
monitor.setCursorPos(1, 1)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.white)
monitor.write("white")
monitor.setCursorPos(15, 1)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.orange)
monitor.write("orange")
monitor.setCursorPos(1, 2)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.magenta)
monitor.write("magenta")
monitor.setCursorPos(15, 2)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.lightBlue)
monitor.write("lightBlue")
monitor.setCursorPos(1, 3)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.yellow)
monitor.write("yellow")
monitor.setCursorPos(15, 3)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.lime)
monitor.write("lime")
monitor.setCursorPos(1, 4)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.pink)
monitor.write("pink")
monitor.setCursorPos(15, 4)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.grey)
monitor.write("grey")
monitor.setCursorPos(1, 5)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.lightGrey)
monitor.write("lightGrey")
monitor.setCursorPos(15, 5)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.cyan)
monitor.write("cyan")
monitor.setCursorPos(1, 6)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.purple)
monitor.write("purple")
monitor.setCursorPos(15, 6)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.blue)
monitor.write("blue")
monitor.setCursorPos(1, 7)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.brown)
monitor.write("brown")
monitor.setCursorPos(15, 7)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.green)
monitor.write("green")
monitor.setCursorPos(1, 8)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.red)
monitor.write("red")
monitor.setCursorPos(15, 8)
monitor.setTextColour(colours.red)
monitor.write("x")
monitor.setTextColour(colours.grey)
monitor.write("black")
monitor.setCursorPos(31, 24)
monitor.setTextColour(colours.red)
monitor.write("reboot")

white = false
orange = false
magenta = false
lightBlue = false
yellow = false
lime = false
pink = false
grey = false
lightGrey = false
cyan = false
purple = false
blue = false
brown = false
green = false
red = false
black = false
active = 0

function on(col)
    monitor.setTextColour(colours.green)
    active = active + col
    rs.setBundledOutput("back", active)
end

function off(col)
    monitor.setTextColour(colours.red)
    active = active - col
    rs.setBundledOutput("back", active)
end

while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    print(x .. " " .. y)
    if y == 1 then
        if x >= 1 and x <= 14 then
            if white == false then
                on(colours.white)
                monitor.setCursorPos(1, 1)
                monitor.write("x")
                white = true
            else
                off(colours.white)
                monitor.setCursorPos(1, 1)
                monitor.write("x")
                white = false
            end
        elseif x >= 15 and x <= 30 then
            if orange == false then
                on(colours.orange)
                monitor.setCursorPos(15, 1)
                monitor.write("x")
                orange = true
            else
                off(colours.orange)
                monitor.setCursorPos(15, 1)
                monitor.write("x")
                orange = false
            end
        end
    elseif y == 2 then
        if x >= 1 and x <= 14 then
            if magenta == false then
                on(colours.magenta)
                monitor.setCursorPos(1, 2)
                monitor.write("x")
                magenta = true
            else
                off(colours.magenta)
                monitor.setCursorPos(1, 2)
                monitor.write("x")
                magenta = false
            end
        elseif x >= 15 and x <= 30 then
            if lightBlue == false then
                on(colours.lightBlue)
                monitor.setCursorPos(15, 2)
                monitor.write("x")
                lightBlue = true
            else
                off(colours.lightBlue)
                monitor.setCursorPos(15, 2)
                monitor.write("x")
                lightBlue = false
            end
        end
    elseif y == 3 then
        if x >= 1 and x <= 14 then
            if yellow == false then
                on(colours.yellow)
                monitor.setCursorPos(1, 3)
                monitor.write("x")
                yellow = true
            else
                off(colours.yellow)
                monitor.setCursorPos(1, 3)
                monitor.write("x")
                yellow = false
            end
        elseif x >= 15 and x <= 30 then
            if lime == false then
                on(colours.lime)
                monitor.setCursorPos(15, 3)
                monitor.write("x")
                lime = true
            else
                off(colours.lime)
                monitor.setCursorPos(15, 3)
                monitor.write("x")
                lime = false
            end
        end
    elseif y == 4 then
        if x >= 1 and x <= 14 then
            if pink == false then
                on(colours.pink)
                monitor.setCursorPos(1, 4)
                monitor.write("x")
                pink = true
            else
                off(colours.pink)
                monitor.setCursorPos(1, 4)
                monitor.write("x")
                pink = false
            end
        elseif x >= 15 and x <= 30 then
            if grey == false then
                on(colours.grey)
                monitor.setCursorPos(15, 4)
                monitor.write("x")
                grey = true
            else
                off(colours.grey)
                monitor.setCursorPos(15, 4)
                monitor.write("x")
                grey = false
            end
        end
    elseif y == 5 then
        if x >= 1 and x <= 14 then
            if lightGrey == false then
                on(colours.lightGrey)
                monitor.setCursorPos(1, 5)
                monitor.write("x")
                lightGrey = true
            else
                off(colours.lightGrey)
                monitor.setCursorPos(1, 5)
                monitor.write("x")
                lightGrey = false
            end
        elseif x >= 15 and x <= 30 then
            if cyan == false then
                on(colours.cyan)
                monitor.setCursorPos(15, 5)
                monitor.write("x")
                cyan = true
            else
                off(colours.cyan)
                monitor.setCursorPos(15, 5)
                monitor.write("x")
                cyan = false
            end
        end
    elseif y == 6 then
        if x >= 1 and x <= 14 then
            if purple == false then
                on(colours.purple)
                monitor.setCursorPos(1, 6)
                monitor.write("x")
                purple = true
            else
                off(colours.purple)
                monitor.setCursorPos(1, 6)
                monitor.write("x")
                purple = false
            end
        elseif x >= 15 and x <= 30 then
            if blue == false then
                on(colours.blue)
                monitor.setCursorPos(15, 6)
                monitor.write("x")
                blue = true
            else
                off(colours.blue)
                monitor.setCursorPos(15, 6)
                monitor.write("x")
                blue = false
            end
        end
    elseif y == 7 then
        if x >= 1 and x <= 14 then
            if brown == false then
                on(colours.brown)
                monitor.setCursorPos(1, 7)
                monitor.write("x")
                brown = true
            else
                off(colours.brown)
                monitor.setCursorPos(1, 7)
                monitor.write("x")
                brown = false
            end
        elseif x >= 15 and x <= 30 then
            if green == false then
                on(colours.green)
                monitor.setCursorPos(15, 7)
                monitor.write("x")
                green = true
            else
                off(colours.green)
                monitor.setCursorPos(15, 7)
                monitor.write("x")
                green = false
            end
        end
    elseif y == 8 then
        if x >= 1 and x <= 14 then
            if red == false then
                on(colours.red)
                monitor.setCursorPos(1, 8)
                monitor.write("x")
                red = true
            else
                off(colours.red)
                monitor.setCursorPos(1, 8)
                monitor.write("x")
                red = false
            end
        elseif x >= 15 and x <= 30 then
            if black == false then
                on(colours.black)
                monitor.setCursorPos(15, 8)
                monitor.write("x")
                black = true
            else
                off(colours.black)
                monitor.setCursorPos(15, 8)
                monitor.write("x")
                black = false
            end
        end
    elseif y == 24 then
        if x >= 31 and x <= 36 then
            os.reboot()
        end
    end
end
