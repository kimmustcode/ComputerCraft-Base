-- This program is to control nuclear reactor
rednet.open("top")
nuke = peripheral.wrap("back")
coolant = true 

function main()
    while true do 
        num, msg, code = rednet.receive("0A1B")
        coolantLvl = nuke.getCoolantFilledPercentage()

        -- Scram if coolant is empty to prevent damage
        if coolantLvl == 0 then 
            if nuke.getStatus() then 
                nuke.scram()
            end
        end

        -- If the energy storage is full then scram the reactor 
        if msg == 'full' then  
            if nuke.getStatus() then
                print('Scram -- Reason: ' .. msg) 
                nuke.scram()
            end 
        
        -- If the energy storage is low then reactivate the reactor
        elseif msg == 'low' then 
            if nuke.getStatus() == false and coolantLvl >= .5 then
                print('Reactivate -- Reason: ' .. msg) 
                nuke.activate()
            end 
        end 
    end
end

main()

