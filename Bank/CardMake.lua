--initialize variables
local CNUM = 0
local EXP = 0
local CVV = 0

--check if new cards are allowed
if settings.get("card.option.1") == false then
    print ("new cards are not allowed at this time")
    goto stop
end

--generate the card details
print("enter custom card number")
CNUM = read()
print("enter custom card EXP. current date: " .. os.day("ingame"))
EXP = read()
print("enter custom CVV")
CVV = read()

--check for repeated card number
if fs.exists("cards/" .. CNUM) == false then
    print("please enter card holder name")
    local Owner = read()
    fs.makeDir("cards/" .. CNUM)
    local file = fs.open("cards/" .. CNUM .. "/info.hlx", "w")
    file.write(CNUM .. " / " .. EXP .. " / " .. CVV .. " / " .. Owner)
    file.close()
    local file = fs.open("cards/" .. CNUM .. "/CB.hlx", "w")
    file.write("0")
    file.close()
    local file = fs.open("cards/" .. CNUM .. "/log.hlx", "a")
    file.writeLine("(" .. os.day("ingame") .. ") - card created")
    file.close()
    print("new card created")
else
    print("card already exists")
end

::stop::
