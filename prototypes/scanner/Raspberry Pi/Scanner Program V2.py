#!/user/bin/python

import SimpleCV
import zbar
import OSC

from SimpleCV import Color,Camera,Display

send_address = '127.0.0.1' , 9000

c = OSC.OSCClient()
c.connect(send_address)

oldAccount = 0

cam = Camera()  #starts the camera
display = Display((640,480)) 

while(display.isNotDone()):
 
 img = cam.getImage() #gets image from the camera

 barcode = img.findBarcode() #finds barcode data from image
 if(barcode is not None): #if there is some data processed
   barcode = barcode[0] 
   result = str(barcode.data)
   account = result[-6:]

   if (oldAccount != account):
       print account #prints result of barcode in python shell
       oldAccount = account
       msg = OSC.OSCMessage()
       msg.setAddress("/print")
       msg.append(account)

       c.send(msg)

   barcode = [] #reset barcode data to empty set

 img.save(display) #shows the image on the screen
 
