rednet.open("back")

energy = nil
inventory = nil

rednet.broadcast("pc")
num, energy, non = rednet.receive("0A1A")
num, inventory, non = rednet.receive("0B1A")

if energy ~= nil and inventory ~= nil then
    print("Energy: " .. energy .. " Joules")
    print("Inventory Space: " .. inventory)
end
