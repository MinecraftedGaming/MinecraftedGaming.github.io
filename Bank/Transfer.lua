if settings.get("bank.option.2") == false then
    printError("transaction service is currently disabled")
    goto stop
end

local arg = { ... }

if arg[1] == nil then
    print("enter card number:")
    C1 = read()
    print("enter security code")
    C1S = read()
else
    C1 = arg[1]
    C1S = arg[3]
end
local file = fs.open("cards/" .. C1 .. "/info/cvv.hlx", "r")
local C1C = file.readAll()
file.close()
if C1S ~= C1C then
    printError("Security code incorrect. Canceling transfer.")
    goto stop
end
if arg[1] == nil then
    print("enter recipient card number:")
    local C2 = read()
    print("enter amount:")
    local amount = read()
    print("enter memo:")
    local memo = read()
else
    C2 = arg[2]
    amount = arg[4]
    memo = arg[5]
end

local file = fs.open("cards/" .. C1 .. "/CB.hlx", "r")
local C1amount = file.readAll()
file.close()
local file = fs.open("cards/" .. C2 .. "/CB.hlx", "r")
local C2amount = file.readAll()
file.close()
if fs.exists("cards/" .. C1) then
    if fs.exists("cards/" .. C2) then
        if tonumber(C1amount) >= tonumber(amount) then
            if tonumber(amount) >= 1 then
                local file = fs.open("cards/" .. C1 .. "/log.hlx", "a")
                file.writeLine("(" ..
                    os.date("%D") ..
                    ") - transfered $" ..
                    amount .. " to " .. C2 .. " by " .. os.getComputerID() .. " Memo(" .. memo .. ")")
                file.close()
                local file = fs.open("cards/" .. C2 .. "/log.hlx", "a")
                file.writeLine("(" ..
                    os.date("%D") ..
                    ") - received $" ..
                    amount .. " from " .. C1 .. " by " .. os.getComputerID() .. " Memo(" .. memo .. ")")
                file.close()
                local file = fs.open("cards/" .. C1 .. "/CB.hlx", "w")
                file.write(C1amount - amount)
                file.close()
                local file = fs.open("cards/" .. C2 .. "/CB.hlx", "w")
                file.write(C2amount + amount)
                file.close()
                if arg[1] == nil then
                    print("transfered $" .. amount .. " to " .. C2 .. " from " .. C1 .. " Memo(" .. memo .. ")")
                end
            else
                print("amount must be greater than 0")
            end
        else
            print("invalid")
            print("requested: " .. amount)
            print("avalible: " .. C1amount)
        end
    end
end
::stop::
