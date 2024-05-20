rednet.open("top")

while true do 
    num, msg, non = rednet.receive()

    if msg == "pc" then 
        rednet.broadcast("energy")
        num, energy = rednet.receive("001B")
        rednet.broadcast("inventory")
        num, inventory = rednet.receive("001C")

        rednet.broadcast(energy, "0A1A")
        rednet.broadcast(inventory, "0A1B")
    elseif 
        rednet.broadcast("harvest", "0000")
    end
end

