rednet.open("back")

while true do 
    rednet.broadcast("energy")
    num, msg, non = rednet.receive()
    shell.run('clear')
    print(ms)
end