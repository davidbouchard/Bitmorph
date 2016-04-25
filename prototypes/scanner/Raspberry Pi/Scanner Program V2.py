#!/user/bin/python

import SimpleCV
import zbar
import OSC
import time

from SimpleCV import Color,Camera,Display

send_address = '127.0.0.1' , 9000

c = OSC.OSCClient()
c.connect(send_address)

oldAccount = 0

cam = Camera()  #starts the camera
display = Display((640,480)) 

timer = time.time()

delay = 0  #have delay set to 0 so that it is constantly checking

while(display.isNotDone()):
 
 img = cam.getImage() #gets image from the camera

 barcode = img.findBarcode() #finds barcode data from image

 #print the timer for debugging
 #print "Timer save at", timer   #show the time we started the timer at
 #print "Current time:", time.time()    #show the current time passed
 
 if(time.time() > timer+delay):
    
    print "Timer is up! ", delay, " seconds has passed. Start Scanning!"
    if(barcode is not None): #if there is some data processed
       barcode = barcode[0] 
       result = str(barcode.data)
       account = result[-6:]
       #account = result
       
       if (oldAccount != account): #check if the passport scanned was the previous one
           print account #prints result of barcode in python shell
           oldAccount = account
           msg = OSC.OSCMessage()
           msg.setAddress("/scan")      #add the account number to the msg
           #msg.append("hello world")
           msg.append(account)
           try:
             c.send(msg)
           except:
             pass

           barcode = [] #reset barcode data to empty set
       else:    #it's the same ticket as before
           print "Previous ticket detected!", account

           ########Comment the following code block if we don't want to send the same account number####
           oldAccount = account
           msg = OSC.OSCMessage()
           msg.setAddress("/scan")      #add the account number to the msg
           #msg.append("hello world")
           msg.append(account)
           try:
             c.send(msg)
           except:
             pass
           ###################################################################################
           barcode = [] #reset barcode data to empty set
           
       timer = time.time()
       print "Reseting timer"
           
 img.save(display) #shows the image on the screen
 
