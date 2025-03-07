--initialize variables
local CNUM = 0
local EXP = 0
local CVV = 0

--check if new cards are allowed
if settings.get("bank.option.1") == false then
    printError("new cards are not allowed at this time")
    goto stop
end

--generate the card details
print("set new card number")
CNUM = read()
print("set card EXP. current date: " .. os.date("local"))
EXP = read()
print("set CVV")
CVV = read()

--check for repeated card number
if fs.exists("cards/" .. CNUM) == false then
    print("please enter card holder name")
    local Owner = read()
    fs.makeDir("cards/" .. CNUM)
    local file = fs.open("cards/" .. CNUM .. "/info/cvv.hlx", "w")
    file.write(CVV)
    file.close()
    local file = fs.open("cards/" .. CNUM .. "/info/exp.hlx", "w")
    file.write(EXP)
    file.close()
    local file = fs.open("cards/" .. CNUM .. "/info/num.hlx", "w")
    file.write(CNUM)
    file.close()
    local file = fs.open("cards/" .. CNUM .. "/info/holder.hlx", "w")
    file.write(Owner)
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
