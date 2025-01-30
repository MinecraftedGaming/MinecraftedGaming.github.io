local arguments = { ... }

if settings.get("card.option.3") == false then
    printError("Debt disabled in settings.")
    printError("Bank/UI for settings.")
    os.sleep(3)
    term.clear()
    term.setCursorPos(1, 1)
    goto stop
end

function nocard(x)
    if x == 2 then
        printError("1 or more cards not detected")
        printError("card 1 detected: " .. tostring(fs.exists("cards/" .. arguments[2])))
        printError("card 2 detected: " .. tostring(fs.exists("cards/" .. arguments[3])))
    elseif x == 1 then
        printError("card not detected")
        printError("card 1 detected: " .. tostring(fs.exists("cards/" .. arguments[2])))
    end
end

if arguments[1] == "add" then
    if fs.exists("cards/" .. arguments[2]) == false and fs.exists("cards/" .. arguments[3]) == false then
        nocard(2)
        goto stop
    end
    if fs.exists("cards/" .. arguments[2] .. "/debt.hlx") == false then
        local file = fs.open("cards/" .. arguments[2] .. "/debt.hlx", "w")
        file.write("0")
        file.close()
    end
    local file = fs.open("cards/" .. arguments[2] .. "/debt.hlx", "r+")
    local debt = file.readAll()
    file.write(debt + arguments[4])
    file.close()
    if fs.exists("cards/" .. arguments[2] .. "/debt/" .. arguments[3]) == true then
        local file = fs.open("cards/" .. arguments[2] .. "/debt/" .. arguments[3] .. ".hlx", "r+")
        local predebt = file.readAll()
        file.write(arguments[4] + predebt)
        file.close()
        local file = fs.open("cards/" .. arguments[2] .. "/debtList.hlx", "r+")
        local new = file.readAll():gsub(arguments[3] .. " - $" .. arguments[4],
            arguments[3] .. " - $" .. arguments[4] + predebt)
        file.write(new)
        file.close()
    else
        local file = fs.open("cards/" .. arguments[2] .. "/debtList.hlx", "a")
        file.writeLine(arguments[3] .. " - $" .. arguments[4])
        file.close()
        local file = fs.open("cards/" .. arguments[2] .. "/debt/" .. arguments[3] .. ".hlx", "a")
        file.writeLine(arguments[4])
        file.close()
    end
    print(arguments[2] .. " now owes " .. arguments[3] .. " $" .. arguments[4])
    local file = fs.open("cards/" .. arguments[2] .. "/dlog.hlx", "a")
    file.writeLine("(" .. os.date("%D") .. ") $" .. arguments[4] .. " owed to " .. arguments[3])
    file.close()
elseif arguments[1] == "payoff" then
    if fs.exists("cards/" .. arguments[2]) == false and fs.exists("cards/" .. arguments[3]) == false then
        nocard(2)
        goto stop
    end
    print("payoff")
    local file = fs.open("cards/" .. arguments[2] .. "/debt/" .. arguments[3] .. ".hlx", "r")
    local paid = file.readAll()
    file.close()
    print("grabbed amount paid")
    fs.delete("cards/" .. arguments[2] .. "/debt/" .. arguments[3] .. ".hlx")
    print("deleted " .. arguments[3] .. " debt file")
    local file = fs.open("cards/" .. arguments[2] .. "/debtList.hlx", "r+")
    local list = file.readAll()
    local newlist = list:gsub(arguments[3] .. " - $" .. paid, "")
    file.write(newlist)
    file.close()
    print("removed " .. arguments[3] .. " from debt list")
    local file = fs.open("cards/" .. arguments[2] .. "/debt.hlx", "r+")
    local debt = file.readAll()
    file.write(debt - paid)
    file.close()
    print("removed amount from debt")
    local file = fs.open("cards/" .. arguments[2] .. "/dlog.hlx", "a")
    file.writeLine("(" .. os.date("%D") .. ") $" .. tostring(arguments[4]) .. " paid to " .. tostring(arguments[3]))
    file.close()
elseif arguments[1] == "check" then
    if fs.exists("cards/" .. arguments[2]) == false then
        nocard(1)
        goto stop
    end
    local file = fs.open("cards/" .. arguments[2] .. "/debtList.hlx", "r")
    local list = file.readAll()
    file.close()
    print(list)
else
    printError("invalid mode: " .. arguments[1])
end
::stop::
