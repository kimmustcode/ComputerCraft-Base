-- This program displays nuclear reactor information
nuke = peripheral.wrap("fissionReactorLogicAdapter_0")
monitor = peripheral.wrap("monitor_7")
energyCube = peripheral.wrap("ultimateEnergyCube_0")
rednet.open("bottom")

maxEn = energyCube.getMaxEnergy()
lastE = 0 
nextE = 0 


function printScreen() 
    -- Get data 
    tempa = nuke.getTemperature()
    mbr = nuke.getMaxBurnRate()
    lvl = nuke.getCoolantFilledPercentage() * 100
    flvl = nuke.getFuelFilledPercentage() * 100
    nextE = math.floor(energyCube.getEnergy())

    -- If the energy level has changed 
    if nextE ~= lastE then 
        perc = nextE / maxEn
        
        -- Broadcast if full or low 
        if perc >= 1 then 
            rednet.broadcast("full", "0A1B")
        elseif math.floor(perc*10) == 7 then 
            rednet.broadcast("low", "0A1B")
        end 
        -- Color changes to reflect fullness level 
        if perc >= .5 then 
            red = 1 - ((perc - .5) / .5)
            monitor.setPaletteColor(colors.red, red, 1, 0)
        else
            green = (perc / .5)
            monitor.setPaletteColor(colors.green, 1, green, 0)
        end 
    end 
    
    -- Write to monitor 
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("===Nuclear Reactor===") 

    monitor.setCursorPos(1, 2)
    monitor.write("Status: ") 
    stat = nuke.getStatus()

    -- Display Green if reactor is active otherwise display Red
    if stat == true then 
        monitor.setTextColor(colors.green)
        monitor.write("ACTIVE")
    else
        monitor.setTextColor(colors.red)
        monitor.write("INACTIVE")
    end 
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(1, 3)
    monitor.write("Temperature: ".. tempa)

    monitor.setCursorPos(1, 4)
    monitor.write("Coolant Level: ".. lvl .. "%")

    monitor.setCursorPos(1, 5)
    monitor.write("Fuel Level " .. flvl .. "%")

    monitor.setCursorPos(1, 6)
    monitor.write("Burn Rate: " .. mbr)

    monitor.setCursorPos(1, 8)
    monitor.write("===Energy Storage===") 

    monitor.setCursorPos(1, 9)
    monitor.write((nextE/1000000) .. " MJ") 

    if perc >= .5 then 
        monitor.setTextColor(colors.red)
    else
        monitor.setTextColor(colors.green)
    end 

    monitor.setCursorPos(1, 10)
    monitor.write(string.format("%.2f%%", (perc * 100)))
    monitor.setTextColor(colors.white)
    monitor.write(" Full") 
    lastE = nextE  
end

-- sleep because nuke takes a second to form and this errors out if it tries to getstatus before its formed 
while true do 
    printScreen()
end