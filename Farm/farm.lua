-- Farms the potatoes

rednet.open("left")
check = false 
myID = "002D"
crop = "potato"

function find(name)
    item = "minecraft: " .. name
    for i = 1, 16, 1 do 
        block = turtle.getItemDetail(i)
        if block ~= nil then 
            if block["name"] == item then
                turtle.select(i)
            end
        end 
    end 
end 

function fuelCheck()
    f = turtle.getFuelLevel()
    if f == 0 then
        find("charcoal")
        turtle.refuel()
    end
end 

function farm() 
    turtle.turnRight()

    for i = 11, 1, -1 do 
        fuelCheck()
        turtle.forward()
        turtle.turnLeft()
        success, data = turtle.inspect()
        if success then
            if data.state.age == 7 then
                turtle.dig()
                turtle.suck()
                find(crop)
                turtle.place()
            else 
                turtle.suck()
            end
        
        elseif success == false then 
            find(crop)
            turtle.place()
        end 
        
        turtle.turnRight()
    end 

    turtle.turnLeft()
    turtle.turnLeft()

    for i = 11, 1, -1 do 
        turtle.forward()
    end 

    for i = 16, 1, -1 do 
        turtle.drop(i)
    end 
    turtle.turnRight()
end

while true do
    num, msg, code = rednet.receive("001D")
    if msg == "potato" then
        farm()  
        rednet.broadcast("Finished", "0A2D")
    end 
end 