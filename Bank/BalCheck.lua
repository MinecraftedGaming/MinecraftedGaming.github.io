local arguments = { ... }
local CNUM = "1122 3344 5566 7788"
if arguments[1] == nil then
    CNUM = read()
else
    CNUM = arguments[1]
end

local file = fs.open("cards/" .. tostring(CNUM) .. "/CB.hlx", "r")
local Camount = file.readAll()
file.close()

print("$" .. Camount)
