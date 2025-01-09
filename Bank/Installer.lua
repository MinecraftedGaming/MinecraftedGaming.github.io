function clear (x)
    os.sleep(x)
    term.clear()
    term.setCursorPos(1,1)
end

function install (scr)
    print("downloading " .. scr)
    local request = http.get("https://mg.madefor.cc/Bank/" .. scr .. ".lua")
    print("downloaded " .. scr) 
    print("installing " .. scr .. ".lua")
    local file = fs.open("bank/" .. scr .. ".lua", "w")
    file.write(request.readAll())
    file.close()
    print("installed " .. scr .. ".lua")
end
function installA ()
    install("BalCheck")
    install("CardGen")
    install("CardMake")
    install("SetBal")
    install("Transfer")
    install("UI")
    print("")
    print("all files installed")
end

clear(0)
print("emu")
clear(1)
installA()
clear(1)
::prompt::
print("would you like to make your first card now")
print("Y/N")
local input = read()

if input == "y" or input == "Y" then
    clear()
    print("please enable new cards in UI before continuing")
    clear(2)
    shell.run("Bank/UI.lua")
    shell.run("Bank/CardMake.lua")
elseif input == "n" or input == "N" then
    clear()
    print("in order to create cats/make transactions they must be enabled by runnng 'Bank/UI'")
    clear(3)
else
    clear()
    print("Error: Invalid input")
    clear(1)
    goto prompt
end