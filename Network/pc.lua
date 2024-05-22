rednet.open("back")

rednet.broadcast("pc")
num, energy, non = rednet.receive("1A1A")
num, inventory, non = rednet.receive("2A1A")
num, stat, non = rednet.receive("3A1A")
num, lvl, non = rednet.receive("4A1A")
num, flvl, non = rednet.receive("5A1A")
num, mbr, non = rednet.receive("6A1A")
num, perc, non = rednet.receive("7A1A")
num, tempa, non = rednet.receive("8A1A")




shell.run('clear')
print("===Nuclear Reactor===") 
if stat == true then 
    fStat = "Active"
else
    fStat = "Inactive"
end 

print("Status: " .. fStat) 
print("Temperature: ".. string.format("%.2f%", tempa))

print("Coolant Level: ".. lvl .. "%")

print("Fuel Level " .. flvl .. "%")

print("Burn Rate: " .. mbr)
print("\n===Energy Storage===") 
print((energy/1000000) .. " MJ") 

print(string.format("%.2f%% Full", (perc * 100)))

print("\n===Inventory Storage===") 
print(string.format("%.2f%% Full", (inventory * 100)))
