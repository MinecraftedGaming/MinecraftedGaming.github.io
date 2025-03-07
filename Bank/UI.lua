if settings.get("bank.beta") == false then
    printError("Bank UI is still in development and not ready for use")
    printError("enable beta features to use ui")
    printError("(this may cause things to break. use at own risk)")
    goto stop
end

printError("(this may cause things to break. use at own risk)")
os.sleep(1)

local modem = peripheral.find("modem")
if modem == nil then
    printError("Cant connect to online sevices. Please check your connection")
    goto stop
else
    peripheral.find("modem", rednet.open)
    rednet.broadcast("bank ui open on computer " .. os.getComputerID(), "bank") 
    rednet.broadcast("bank confirmation request", "bank")
    ::confirm::
    print("Waiting for confirmation from online services")
    local event, sender, message, protocol = os.pullEvent("rednet_message")
    if message == "confirm" then
        print("Connected to online services")
    elseif message == "deny" then
        printError("Connection denied")
        goto stop
    else
        goto confirm
    end
end

local screen = "n/a"  -- fix issues with some functions not setting screen properly

function drawClose(b) -- the little x in corner
    col = term.getBackgroundColor()
    term.setBackgroundColor(colors.red)
    term.setCursorPos(51, 1)
    term.write("X")
    if b == true then
        term.setBackgroundColor(colors.orange)
        term.setCursorPos(49, 1)
        term.write("<")
    end
    term.setBackgroundColor(col)
end

function clear(t, b) -- clear screen with/without close/back button
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.setCursorPos(1, 1)
    term.clear()
    if t == false then
        drawClose(b)
    end
end

function startscreen() -- start screen
    term.setBackgroundColor(colors.black)
    term.clear()
    screen = "start"

    paintutils.drawFilledBox(2, 2, 11, 4, colors.gray)
    term.setCursorPos(3, 3)
    term.write("New Card")
    term.setCursorPos(2, 2)
    term.write("1")

    paintutils.drawFilledBox(14, 2, 23, 4, colors.gray)
    term.setCursorPos(15, 3)
    term.write("Transfer")
    term.setCursorPos(14, 2)
    term.write("2")

    paintutils.drawFilledBox(26, 2, 34, 4, colors.gray)
    term.setCursorPos(27, 3)
    term.write("Balance")
    term.setCursorPos(26, 2)
    term.write("3")

    paintutils.drawFilledBox(37, 2, 46, 4, colors.gray)
    term.setCursorPos(38, 3)
    term.write("interest")
    term.setCursorPos(37, 2)
    term.write("4")

    drawClose()
    rednet.broadcast("bank ui home screen loaded on computer " .. os.getComputerID(), "bank")
end

function newcard() -- new cards screen
    clear(false, true)
    screen = "newcard"
    paintutils.drawFilledBox(2, 2, 9, 4, colors.gray)
    term.setCursorPos(3, 3)
    term.write("random")
    term.setCursorPos(2, 2)
    term.write("1")

    paintutils.drawFilledBox(11, 2, 18, 4, colors.gray)
    term.setCursorPos(12, 3)
    term.write("custom")
    term.setCursorPos(11, 2)
    term.write("2")

    rednet.broadcast("bank ui new card screen loaded on computer " .. os.getComputerID(), "bank")
end

function cardGen()
    clear(false, true)
    screen = "cardGen"
    cnum = "2064 " .. math.random(1000, 9999) .. " " .. math.random(1000, 9999) .. " " .. math.random(1000, 9999)
    paintutils.drawBox(2, 2, 23, 4, colors.gray)
    term.setCursorPos(10, 2)
    term.write("Card Number")
    paintutils.drawLine(3, 3, 22, 3, colors.lightGray)
    rednet.broadcast("bank ui card gen screen loaded on computer " .. os.getComputerID(), "bank")
    os.sleep(0.1)
    term.setCursorPos(3, 3)
    term.write(cnum)
    os.sleep(0.1)
    CVV = math.random(100, 999)
    paintutils.drawBox(2, 6, 36, 8, colors.gray)
    term.setCursorPos(15, 6)
    term.write("CVV")
    paintutils.drawLine(3, 7, 35, 7, colors.lightGray)
    term.setCursorPos(3, 7)
    term.write(CVV)
    paintutils.drawBox(2, 10, 36, 12, colors.gray)
    term.setCursorPos(13, 10)
    term.write("EXP")
    paintutils.drawLine(3, 11, 35, 11, colors.lightGray)
    term.setCursorPos(3, 11)
    exp = read()
    os.sleep(0.1)
    paintutils.drawBox(2, 14, 36, 16, colors.gray)
    term.setCursorPos(13, 14)
    term.write("Name")
    paintutils.drawLine(3, 15, 35, 15, colors.lightGray)
    term.setCursorPos(3, 15)
    name = read()
    os.sleep(0.1)
    paintutils.drawFilledBox(2, 18, 10, 20, colors.green)
    term.setCursorPos(3, 19)
    term.write("confirm")
    rednet.broadcast("bank card " .. cnum .. " being made on computer " .. os.getComputerID(), "bank")
end

function cardsave()
    if fs.exists("cards/" .. cnum) == false then
        fs.makeDir("cards/" .. cnum)
        fs.makeDir("cards/" .. cnum .. "/info")
        local file = fs.open("cards/" .. cnum .. "/info/cvv.hlx", "w")
        file.write(CVV)
        file.close()
        local file = fs.open("cards/" .. cnum .. "/info/exp.hlx", "w")
        file.write(exp)
        file.close()
        local file = fs.open("cards/" .. cnum .. "/info/num.hlx", "w")
        file.write(cnum)
        file.close()
        local file = fs.open("cards/" .. cnum .. "/info/holder.hlx", "w")
        file.write(name)
        file.close()
        local file = fs.open("cards/" .. cnum .. "/log.hlx", "a")
        file.writeLine("(" .. os.day("local") .. ") - card created")
        file.close()
        rednet.broadcast("bank card " .. cnum .. " created on computer " .. os.getComputerID(), "bank")
    else
        startscreen()
    end
end

function transfer() -- transfer screen
    clear(false, true)
    screen = "transfer"
    paintutils.drawBox(2, 2, 36, 4, colors.gray)
    paintutils.drawBox(2, 6, 36, 8, colors.gray)
    paintutils.drawBox(2, 10, 12, 12, colors.gray)
    term.setCursorPos(13, 2)
    term.write("Card Number")
    term.setCursorPos(10, 6)
    term.write("recipiant number")
    term.setCursorPos(6, 10)
    term.write("CVV")
    paintutils.drawLine(3, 3, 35, 3, colors.lightGray)
    paintutils.drawLine(3, 7, 35, 7, colors.lightGray)
    paintutils.drawLine(3, 11, 11, 11, colors.lightGray)
    rednet.broadcast("bank ui transfer screen loaded on computer " .. os.getComputerID(), "bank")
    os.sleep(0.1)
    term.setBackgroundColor(colors.lightGray)
    term.setCursorPos(3, 3)
    cnum = read()
    os.sleep(0.1)
    term.setCursorPos(3, 7)
    rnum = read()
    os.sleep(0.1)
    term.setCursorPos(3, 11)
    cvv = read()
    os.sleep(0.1)
    paintutils.drawFilledBox(2, 14, 10, 16, colors.green)
    term.setCursorPos(3, 15)
    term.write("confirm")
    rednet.broadcast("bank transfer being made on computer " .. os.getComputerID(), "bank")
end

function transfer2() -- transfer screen page 2
    screen = "transfer2"
    clear(false, true)
    paintutils.drawBox(2, 2, 15, 4, colors.gray)
    paintutils.drawBox(2, 6, 50, 8, colors.gray)
    term.setCursorPos(6, 2)
    term.write("Amount")
    term.setCursorPos(24, 6)
    term.write("Memo")
    paintutils.drawLine(3, 3, 14, 3, colors.lightGray)
    paintutils.drawLine(3, 7, 49, 7, colors.lightGray)
    os.sleep(0.1)
    term.setCursorPos(3, 3)
    amount = read()
    os.sleep(0.1)
    term.setCursorPos(3, 7)
    memo = read()
    os.sleep(0.1)
    paintutils.drawFilledBox(2, 14, 10, 16, colors.green)
    term.setCursorPos(3, 15)
    term.write("confirm")
end

function balanceCheck() -- balance check screen
    clear(false, true)
    screen = "balanceCheck"
    paintutils.drawBox(2, 2, 36, 4, colors.gray)
    term.setCursorPos(13, 2)
    term.write("Account Number")
    paintutils.drawLine(3, 3, 35, 3, colors.lightGray)
    rednet.broadcast("bank ui balance check screen loaded on computer " .. os.getComputerID(), "bank")
    os.sleep(0.1)
    term.setCursorPos(3, 3)
    cnum = read()
    os.sleep(0.1)
    paintutils.drawFilledBox(2, 14, 10, 16, colors.green)
    term.setCursorPos(3, 15)
    term.write("confirm")
end

function balanceCheck2() -- balance check screen page 2
    clear(false, true)
    screen = "balanceCheck"
    local file = fs.open("card/" .. cnum .. "/balance.hlx", "r")
    local balance = file.readAll()
    file.close()
    term.setCursorPos(1, 1)
    term.write("Balance: " .. balance)
    rednet.broadcast("bank balance check on account " .. cnum .. " made on computer " .. os.getComputerID(), "bank")
end

function terminate()
    clear(true)
    --goto skip
    term.setCursorPos(1, 1)
    term.write("Safely closing bank...")
    os.sleep(math.random(1, 10) / 10)

    term.setCursorPos(1, 2)
    term.write("Closing connections...")
    rednet.broadcast("bank ui closed on computer " .. os.getComputerID(), "bank")
    os.sleep(math.random(1, 10) / 10)

    term.setCursorPos(1, 3)
    term.write("Clearing temporary files...")
    fs.delete("tmp")
    os.sleep(math.random(1, 10) / 10)

    term.setCursorPos(1, 4)
    term.write("Finalizing...")
    os.sleep(math.random(1, 10) / 10)

    term.setCursorPos(1, 5)
    term.write("Shutdown complete.")
    os.sleep(math.random(1, 10) / 10)

    cnum = 0
    rnum = 0
    cvv = 0
    amount = 0
    memo = "null"
    screen = "n/a"
    event = "n/a"
    e1 = "n/a"
    e2 = "n/a"
    e3 = "n/a"
    e4 = "n/a"
    os.sleep(0.1)
    x = 0
    y = 0
    button = 0
    os.sleep(0.1)
    t = false
    b = false
    os.sleep(0.1)
    ::skip::
    term.clear()
    term.setCursorPos(1, 1)
    term.write("closing")
    os.sleep(0.3)
    term.clear()
    term.setCursorPos(1, 1)
end

function loadingBar()
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)
    term.setTextColor(colors.white)
    term.write("Loading...")
    term.setCursorPos(1, 2)
    term.setBackgroundColor(colors.gray)
    term.clearLine()
    term.setBackgroundColor(colors.white)
    term.setCursorPos(1, 2)
    for i = 1, 50 do
        term.write(" ")
        os.sleep(math.random(1, 10) / 100) -- Adjust the speed of the loading bar here
    end
    term.setBackgroundColor(colors.black)
    term.clear()
end

-- end of functions

loadingBar()  -- loading bar
startscreen() -- startup

while true do
    local event, e1, e2, e3, e4 = os.pullEventRaw()
    if event == "terminate" then -- termiate event
        terminate()
        goto stop
    elseif event == "mouse_click" then -- click events
        button = e1
        x = e2
        y = e3
        if button == 1 then -- close button
            if x == 51 and y == 1 then
                terminate()
                goto stop
            end
            if x == 49 and y == 1 then -- back button
                clear(true)
                if screen == "newcard" or "balanceCheck" or "cardGen" then
                    startscreen()
                end
            end
            if screen == "start" then               -- click events for start screen
                if y >= 2 and y <= 4 then           -- button row 1
                    if x >= 2 and x <= 11 then      -- button 1
                        newcard()
                    elseif x >= 13 and x <= 23 then -- button 2
                        transfer()
                    elseif x >= 25 and x <= 34 then -- button 3
                        balanceCheck()
                    end
                end
            elseif screen == "newcard" then   -- click events for new card screen
                if y >= 2 and y <= 4 then     -- button row 1
                    if x >= 2 and x <= 9 then -- button 1
                        clear(true)
                        cardGen()
                    elseif x >= 11 and x <= 18 then -- button 2
                        clear(true)
                        shell.run("bank/CardMake.lua")
                        startscreen()
                    end
                end
            elseif screen == "transfer" then
                if y >= 14 and y <= 16 then
                    if x >= 2 and x <= 10 then
                        transfer2()
                    end
                end
            elseif screen == "transfer2" then
                if y >= 14 and y <= 16 then
                    if x >= 2 and x <= 10 then
                        clear(false)
                        modem.transmit(1, 350, "bank transfer of " .. amount .. " from " .. cnum .. " to " .. rnum .. " made on computer " .. os.getComputerID())
                        shell.run("bank/Transfer.lua", cnum, rnum, cvv, amount, memo)
                        startscreen()
                    end
                end
            end
        end
    elseif event == "key" then   -- key press events
        if e1 == keys.grave then -- close
            os.sleep(0.1)
            terminate()
            goto stop
        end
        if screen == "start" then        -- key events for start screen
            if e1 == keys.one then       -- button 1
                newcard()
            elseif e1 == keys.two then   -- button 2
                transfer()
            elseif e1 == keys.three then -- button 3
                balanceCheck()
            end
        elseif screen == "newcard" then -- key events for new card screen
            if e1 == keys.one then      -- button 1
                clear(true)
                cardGen()
            elseif e1 == keys.two then -- button 2
                clear(true)
                shell.run("CardMake.lua")
            elseif e1 == keys.backspace then -- back
                startscreen()
            end
        elseif screen == "transfer" then
            if e1 == keys.backspace then -- back
                startscreen()
            elseif e1 == keys.enter then -- go to next
                transfer2()
            end
        elseif screen == "transfer2" then
            if e1 == keys.backspace then -- back
                startscreen()
            elseif e1 == keys.enter then -- confirm transfer
                clear(false)
                modem.transmit(1, 350, "bank transfer of " .. amount .. " from " .. cnum .. " to " .. rnum .. " made on computer " .. os.getComputerID())
                shell.run("bank/Transfer.lua", cnum, rnum, cvv, amount, memo)
                startscreen()
            end
        elseif screen == "balanceCheck" then
            if e1 == keys.backspace then -- back
                startscreen()
            elseif e1 == keys.enter then -- confirm balance check
                clear(false)
                shell.run("bank/Balance.lua", cnum)
                startscreen()
            end
        end
    end
end
::stop::
