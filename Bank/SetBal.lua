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
    file.writeLine("(" .. os.date("%D") .. ") - balance set to $" .. bal .. " by SetBal on " .. os.getComputerID())
    file.close()
else
    print("card not found")
end
::stop::
