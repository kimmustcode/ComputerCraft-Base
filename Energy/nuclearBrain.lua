-- This program is to control nuclear reactor
rednet.open("top")
nuke = peripheral.wrap("back")
coolant = true 

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
    end
end

main()

