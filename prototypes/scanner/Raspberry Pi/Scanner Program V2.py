#!/user/bin/python

import SimpleCV
import zbar
import OSC
import time

from SimpleCV import Color,Camera,Display

send_address = '141.117.45.114' , 9000

c = OSC.OSCClient()
c.connect(send_address)

oldAccount = 0

cam = Camera()  #starts the camera
display = Display((640,480)) 

timer = time.time()

while(display.isNotDone()):
 
 img = cam.getImage() #gets image from the camera

 barcode = img.findBarcode() #finds barcode data from image

 #print the timer for debugging
 #print "Timer save at", timer   #show the time we started the timer at
 #print "Current time:", time.time()    #show the current time passed
 
 if(time.time() > timer+5):
    
    print "Timer is up! 5 seconds has passed. Start Scanning!"
    if(barcode is not None): #if there is some data processed
       barcode = barcode[0] 
       result = str(barcode.data)
       account = result[-6:]
       #account = result
       
       if (oldAccount != account): #check if the passport scanned was the previous one
           print account #prints result of barcode in python shell
           oldAccount = account
           msg = OSC.OSCMessage()
           msg.setAddress(account)      #add the account number to the msg
           #msg.append("hello world")

           c.send(msg)

           barcode = [] #reset barcode data to empty set
       else:    #it's the same ticket as before
           print "Previous ticket detected!", account
           
       timer = time.time()
       print "Reseting timer"
           
 img.save(display) #shows the image on the screen
 
