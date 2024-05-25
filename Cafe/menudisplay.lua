-- Display amount of items in storage 
-- update if num of items in system changes 

monitor = peripheral.find("monitor")

function display() 
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("====== Meals ======")
    monitor.setCursorPos(1, 2)
    monitor.write("Mixed Salad (v)")
    monitor.setCursorPos(1, 3)
    monitor.write("Veggie Soup (v)")
    monitor.setCursorPos(1, 4)
    monitor.write("Ratatouille (v)")
    monitor.setCursorPos(1, 5)
    monitor.write("Dumplings")
    monitor.setCursorPos(1, 6)
    monitor.write("Egg Sandwich")

    monitor.setCursorPos(1, 8)
    monitor.write("====== Drinks ======")
    monitor.setCursorPos(1, 9)
    monitor.write("Watermelon Smoothie")


end 


while true do 
    sleep(0.1)
    display()

end 