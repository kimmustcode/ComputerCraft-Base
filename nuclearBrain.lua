-- This program is used to display a live view of the nuclear reactors information 
rednet.open("top")
nuke = peripheral.wrap("back")
monitor = peripheral.find("monitor")
coolant = true 


function printScreen() 
    mon.setCursorPos(1, 1)
    mon.write("Status: ") 
    stat = nuke.getStatus()
    if stat == true then 
        mon.setTextColor(colors.green)
    else
        mon.setTextColor(colors.red)
    end 
    
    mon.write(stat)
    mon.setTextColor(colors.white)
    mon.setCursorPos(1, 2)
    mon.write("Temperature: ".. nuke.getTemperature())
    mon.setCursorPos(1, 3)
    lvl = nuke.getCoolantFilledPercentage() * 100
    mon.write("Coolant Level: %".. lvl)
    mon.setCursorPos(1, 4)
    flvl = nuke.getFuelLevel() * 100
    mon.write("Fuel Level %" .. flvl)
    mon.setCursorPos(1, 5)
    mon.write("Burn Rate: " .. nuke.setBurnRate())
end


function main()
    while true do 
        num, msg, code = rednet.receive("0A1B")
        coolantLvl = nuke.getCoolantFilledPercentage()

        if coolantLvl == 0 then 
            if nuke.getStatus() then 
                nuke.scram()
            end
        end

        if msg == 'full' then  
            if nuke.getStatus() then
                print('Scram -- Reason: ' .. msg) 
                nuke.scram()
            end 
            
        elseif msg == 'low' then 
            if nuke.getStatus() == false and coolantLvl >= .5 then
                print('Reactivate -- Reason: ' .. msg) 
                nuke.activate()
            end 
        end 

        printScreen()
    end
end



