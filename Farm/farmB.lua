rednet.open("back")
potato = "002D"

while true do 
    num, msg, code = rednet.receive("0000")
    if code == "0000" and msg == "harvest" then
        rednet.broadcast("potato", "001D")
    end 
end 