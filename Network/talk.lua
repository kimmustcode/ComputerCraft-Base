
local inventory = peripheral.wrap("left")
local modem = peripheral.find("modem")

while true do 
    num, msg, non = rednet.receive()
    
    if msg == 'energy' then 
        cnt = 0 
        for v, s in pairs(inventory.list()) do
            cnt = cnt + 1 
        end 
        max = inventory.size()
        percent = string.format("%.2f%% Full", (cnt/max) *100) 
        rednet.broadcast("001C" .. percent)
    end 


end 