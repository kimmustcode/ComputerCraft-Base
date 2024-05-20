-- Program that mines out in a set square area
local args = {...}
local size = tonumber(args[1])
local cnt1 = 1 
local cnt2 = 1 
local here = false 
fuel = "minecraft:charcoal"


function torch() 
    inv = 1
    while inv < 16 do 
        item = turtle.getItemDetail(inv)
        if item ~= nil then 
            if item["name"] == "minecraft:torch" then
                turtle.turnRight()
                turtle.turnRight()
                turtle.select(inv)
                turtle.place()
                turtle.turnRight()
                turtle.turnRight()
            end 
        end
        inv = inv + 1 
    end
end 

-- Deposits inventory except torches and coal into chest 
function deposit(cnt) 
    print("deposit")
    temp = cnt -1

    -- walk forward back the amount of rows mined so far 
    for i = temp, 1, -1 do
        turtle.forward()
    end 

    turtle.turnLeft()

    -- Drop items that arent coal or torches 
    for i = 16, 1, -1 do
        block = turtle.getItemDetail(i)
        if block ~= nil then 
            if (block["name"] ~= fuel and block["name"] ~= "minecraft:torch") then
                turtle.select(i)
                turtle.drop()
            end
        end
    end

    if cnt >= size then 
        return
    end 
    -- return back to last row 
    turtle.turnLeft()

    step = 1
    while step < cnt do
        turtle.forward()
        step = step + 1
    end
end 

function move()
    print("move")
    -- check fuel level and if low then refuel
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



function main()
    -- outer loop is rows 
    while cnt2 <= size do 
        cnt1 = 1
        -- inner loop is columns
        while cnt1 <= size do
            check = move()
            if cnt1 % 13 == 0  and cnt2 % 4 == 0 and cnt2 ~= size then
                torch()
            end
            
            if check == true then      
                cnt1 = cnt1 + 1 
            end
        end

        turtle.turnRight()
        -- If the turtle is on the original side the deposit otherwise turn and mine next row.
        if here == true then
            deposit(cnt2)
            if cnt2 < size then
                check2 = move()
                if check2 == true then
                    cnt2 = cnt2 + 1 
                end
                turtle.dig()
                turtle.turnLeft()
            else 
                return
            end
        else 
            check2 = move()
            if check2 == true then
                cnt2 = cnt2 + 1 
            end
            turtle.turnRight()
        end 
        
        -- swap each row 
        here = not here
    end
end

main()