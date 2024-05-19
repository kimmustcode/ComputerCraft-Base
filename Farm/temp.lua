item = turtle.getItemDetail(i)

if item["name"] ~= "minecraft:charcoal" then 
    turtle.drop()
end 