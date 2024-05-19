local size = 64
local cnt1 = 1 
local cnt2 = 1 
local here = false 
fuel = "minecraft:coal"

function deposit(cnt) 
    temp = cnt 

    print(temp)
    for i = temp, 1, -1 do
        turtle.forward()
    end 

    turtle.turnLeft()

    for i = 16, 1, -1 do
        block = turtle.getItemDetail(i)
        if block ~= nil then 
            if (block["name"] ~= fuel and block["name"] ~= "minecraft:torch") then
                turtle.select(i)
                turtle.drop()
            end
        end
    end

    turtle.turnLeft()

    step = 1
    while step < cnt do
        turtle.forward()
        step = step + 1
    end
end 

function move()
    if turtle.getFuelLevel() == 0 then
        inv = 1
        while inv < 16 do 
            item = turtle.getItemDetail(inv)
            if item ~= nil then 
                if item["name"] == fuel then
                    turtle.select(inv)
                end 
            end
            inv = inv + 1 
        end 
        turtle.refuel()
    end

    if turtle.detectUp() == true then 
        -- If there is a block above, mine it 
        turtle.digUp()
    end   

    -- If there is a block in front 
    if turtle.detect() == true then
        -- Mine it and move forward
        turtle.dig()
    end
    return turtle.forward()
end

while cnt2 < size do 
    
    
    cnt1 = 1
    while cnt1 < size do
        check = move()
        if check == true then
            cnt1 = cnt1 + 1 
        end
    end

    turtle.turnRight()
    if here == true then
        deposit()
        check2 = move()
        if check2 == true then
            cnt2 = cnt2 + 1 
        end
        turtle.turnLeft()
    else 
        check2 = move()
        if check2 == true then
            cnt2 = cnt2 + 1 
        end
        turtle.turnRight()
    end 
    
    here = not here




    

end

