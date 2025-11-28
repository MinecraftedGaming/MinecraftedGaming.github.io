function clear(x)
    os.sleep(x)
    term.clear()
    term.setCursorPos(1,1)
end

function install(scr)
    print("downloading " .. scr)
    local request = http.get("https://mg.madefor.cc/GPUVideo/" .. scr .. ".lua")
    print("downloaded " .. scr)
    print("installing " .. scr .. ".lua")
    local file = fs.open("GPUVideo/" .. scr .. ".lua", "w")
    file.write(request.readAll())
    file.close()
    print("installed " .. scr .. ".lua")
end

clear(0)
install("play")
install("video")
install("audio")
print("")
print("all files installed")
clear(2)
