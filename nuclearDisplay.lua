monitor = peripheral.find("monitor")

function printScreen() 
    monitor.setCursorPos(1, 1)
    monitor.write("Status: ") 
    stat = nuke.getStatus()
    if stat == true then 
        monitor.setTextColor(colors.green)
        monitor.write("ACTIVE")
    else
        monitor.setTextColor(colors.red)
        monitor.write("INACTIVE")
    end 
    
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(1, 2)
    monitor.write("Temperature: ".. nuke.getTemperature())

    monitor.setCursorPos(1, 3)
    lvl = nuke.getCoolantFilledPercentage() * 100
    monitor.write("Coolant Level: %".. lvl)

    monitor.setCursorPos(1, 4)
    flvl = nuke.getFuelFilledPercentage() * 100
    monitor.write("Fuel Level %" .. flvl)

    monitor.setCursorPos(1, 5)
    monitor.write("Burn Rate: " .. nuke.getMaxBurnRate())
end

while true do 
    printScreen()
end