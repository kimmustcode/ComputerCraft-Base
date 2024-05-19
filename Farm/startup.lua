rednet.open("left")

while true do 
    num, msg, code = rednet.receive("001D")
    if msg == "potato" then
        shell.run("farm")
        rednet.broadcast("finished", "0A2D")
    elseif msg == "autofarm" then
        shell.run("autofarm")
        rednet.broadcast("finished", "0A2D")
    end 
end