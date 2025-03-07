local modem = peripheral.find("modem")
if modem == nil then
    print("No modem found")
    return
end
peripheral.find("modem", rednet.open)
rednet.host("bank", "bank")
while true do
    ::start::
    local event, sender, message, protocol = os.pullEvent("rednet_message")
    print(sender .. " " .. os.date("%m/%d/%y ") .. textutils.formatTime(os.time("local")) .. " | " .. message)
    if protocol == "bank" then
        local file = fs.open("logs/" .. os.date("%y/%m/%d/") .. "bank.lg", "a")
        file.writeLine(os.date("%m/%d/%y ") .. textutils.formatTime(os.time("local")) .. " | " .. message)
        file.close()
        if message == "bank confirmation request" then
            term.write("bank usage request from " .. sender .. " [y/n]")
            local event, key = os.pullEvent("key")
            if key == keys.y then
                rednet.send(sender, "confirm", "bank")
                print("bank usage request from " .. sender .. " confirmed")
                goto start
            else
                rednet.send(sender, "deny", "bank")
                print("bank usage request from " .. sender .. " denied")
                goto start
            end
        end
    end
end
