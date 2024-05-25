-- This program displays nuclear reactor information
nuke = peripheral.wrap("fissionReactorLogicAdapter_0")
monitor = peripheral.wrap("monitor_7")
energyCube = peripheral.wrap("ultimateEnergyCube_0")
inventory = peripheral.wrap("toms_storage:ts.inventory_connector.tile_0")
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
    invCrnt = 0
    invMax = inventory.size()
    stat = nuke.getStatus()
    perc = nextE / maxEn

    invlist = inventory.list()

    if invlist ~= nil then 
        for item in pairs(invlist) then 
            invCrnt = invCrnt + 1 
        end
    end
    
    invperc = invCrnt / invMax

    rednet.broadcast(nextE, "1A1A")
    rednet.broadcast(invperc, "2A1A")
    rednet.broadcast(stat, "3A1A")
    rednet.broadcast(lvl, "4A1A")
    rednet.broadcast(flvl, "5A1A")
    rednet.broadcast(mbr, "6A1A")
    rednet.broadcast(perc, "7A1A")
    rednet.broadcast(tempa, "8A1A")


    -- If the energy level has changed 
    if nextE ~= lastE then 
        
        
        -- Broadcast if full or low 
        if perc >= 1 then 
            rednet.broadcast("full", "0A1B")
        elseif math.floor(perc*10) == 7 then
            rednet.broadcast("low", "0A1B")
        end 
        -- Color changes to reflect fullness level 
        if perc >= .5 then 
            red = 1 - ((perc - .5) / .5)
            monitor.setPaletteColor(colors.pink, red, 1, 0)
        else
            green = (perc / .5)
            -- Brown so it doesnt interfere with other green text
            monitor.setPaletteColor(colors.brown, 1, green, 0)
        end 
    end 
    
    -- Write to monitor 
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("===Nuclear Reactor===") 

    monitor.setCursorPos(1, 2)
    monitor.write("Status: ") 
    

    -- Display Green if reactor is active otherwise display Red
    if stat == true then 
        monitor.setPaletteColor(colors.green, 0, 1, 0)
        monitor.setTextColor(colors.green)
        monitor.write("ACTIVE")
    else
        monitor.setPaletteColor(colors.red, 1, 0, 0)
        monitor.setTextColor(colors.red)
        monitor.write("INACTIVE")
    end 
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(1, 3)
    monitor.write("Temperature: ".. tempa - 273.15 .. " C")

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
        monitor.setTextColor(colors.pink)
    else
        monitor.setTextColor(colors.brown)
    end 

    monitor.setCursorPos(1, 10)
    monitor.write(string.format("%.2f%%", (perc * 100)))
    monitor.setTextColor(colors.white)
    monitor.write(" Full") 

    monitor.setCursorPos(1, 12)
    monitor.write("===Inventory Storage===") 
    monitor.setCursorPos(1, 13)
    monitor.write(string.format("%.2f%% Full", (invperc * 100)))
    monitor.setCursorPos(1, 14)
    monitor.write(invCrnt .. " / " .. invMax)

    lastE = nextE  
end

while true do 
    printScreen()
end