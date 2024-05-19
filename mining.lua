fuel = "minecraft:charcoal"

function arm()
    lengthMain = 32
    cnt = 0 
    while cnt < lengthMain do
        temp = cnt
        check = move(temp)
        if check == true then
            cnt = cnt + 1 
        end
    end 

    turtle.digUp()
    torch()
    turtle.turnRight()
    turtle.turnRight()

    while cnt > 1 do
        turtle.forward()
        cnt = cnt - 1
    end
    return
end

function move(cnt)
    inv = 0 
        if turtle.getFuelLevel() == 0 then
            while inv < 16 do 
                item = turtle.getItemDetail(inv)
                if item ~= nil then 
                    if item["name"] == fuel then
                        turtle.select(inv)
                    end 
                end
                inv = inv + 1 
            end 
            turtle.place()
            turtle.refuel()
        end

        if turtle.detectUp() == true then 
            -- If there is a block above, mine it 
            turtle.digUp()
        end   

        -- every 13 blocks place a torch 
        inv = 0 
        if cnt % 13 == 0 then
            torch()
        end
        -- If there is a block in front 
        if turtle.detect() == true then
            -- Mine it and move forward
            turtle.dig()
        end
        
        return turtle.forward()
end

function torch() 
    while inv < 16 do 
        item = turtle.getItemDetail(inv)
        
        
            if item["name"] == "minecraft:torch" then
                turtle.turnRight()
                turtle.turnRight()
                turtle.up()
                turtle.select(inv)
                turtle.place()
                turtle.down()
                turtle.turnRight()
                turtle.turnRight()
            end 
        end
        inv = inv + 1 
    end 
end 

function deposit(cnt)
    temp = cnt 
    turtle.turnRight()
    while temp > 1 do 
        move(1)
        temp = temp - 1
    end 
    for i = 16, 1, -1 do
        block = turtle.getItemDetail(i)
        if block ~= nil then 
            if (block["name"] ~= fuel and block["name"] ~= "minecraft:torch") then
                turtle.select(i)
                turtle.drop()
            end
        end
    end

    turtle.turnRight()
    turtle.turnRight()

    step = 1
    while step < cnt do
        move(1)
        step = step + 1
    end
end 

function oreMining()



end 

function main()
    length = 20
    current = 1 

    while current < length do a
        if current % 4 == 0 then
            turtle.turnRight()
            arm()
            turtle.forward()
            arm()
            turtle.forward()
            deposit()
        end

        check = move(current)
        if check == true then
            cnt = cnt + 1 
        end
    end 
end

main()