
#!/user/bin/python

import OSC

send_addess = '192.168.1.1' , 9000

c = OSC.OSCClient()
c.connect(send_address)

msg = OSC.OSCMessage()
msg.setAddress("/print")
msg.append(44)

c.send(msg)
