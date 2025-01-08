if settings.get("card.option.2") == false then
    print("transaction service is currently offline")
    goto stop
end

print("enter card number:")
local C1 = read()
print("enter recipient card number:")
local C2 = read()
print("enter amount:")
local amount = read()

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
                os.day("ingame") .. ") - transfered $" .. amount .. " to " .. C2 .. " by " .. os.getComputerID())
                file.close()
                local file = fs.open("cards/" .. C2 .. "/log.hlx", "a")
                file.writeLine("(" ..
                os.day("ingame") .. ") - received $" .. amount .. " from " .. C1 .. " by " .. os.getComputerID())
                file.close()
                local file = fs.open("cards/" .. C1 .. "/CB.hlx", "w")
                file.write(C1amount - amount)
                file.close()
                local file = fs.open("cards/" .. C2 .. "/CB.hlx", "w")
                file.write(C2amount + amount)
                file.close()
                print("transfered $" .. amount .. " to " .. C2 .. " from " .. C1)
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