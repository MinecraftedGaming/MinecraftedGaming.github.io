local arguments = { ... }

if arguments[1] ~= nil then
    local card = arguments[1]
    local bal = arguments[2]
    if fs.exists("cards/" .. card) == true then
        local file = fs.open("cards/" .. card .. "/CB.hlx", "w")
        file.write(bal)
        file.close()
        local file = fs.open("cards/" .. card .. "/log.hlx", "a")
        file.writeLine("(" .. os.day("local") .. ") - balance set to $" .. bal .. " by SetBal on " .. os.getComputerID())
        file.close()
        print("set balance of " .. card .. " to $" .. bal)
        goto stop
    else
        print("card not found")
    end
end

if settings.get("card.option.2") == false then
    print("transaction service is currently offline")
    goto stop
end

print("enter card number:")
local card = read()
if fs.exists("cards/" .. card) == true then
    print("enter balance:")
    local bal = read()
    local file = fs.open("cards/" .. card .. "/CB.hlx", "w")
    file.write(bal)
    file.close()
    local file = fs.open("cards/" .. card .. "/log.hlx", "a")
    file.writeLine("(" .. os.day("local") .. ") - balance set to $" .. bal .. " by SetBal on " .. os.getComputerID())
    file.close()
    print("set balance of " .. card .. " to $" .. bal)
else
    print("card not found")
end
::stop::
