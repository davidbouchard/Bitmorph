import OSC
import argparse
import time

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--base", type=str, default="s")
    parser.add_argument("--ip", type=str, default="127.0.0.1")
    parser.add_argument("--port", type=int, default=9000)
    
    args = parser.parse_args()
    send_address = args.ip
    send_port = args.port

    osc = OSC.OSCClient()
    osc.connect((send_address, send_port))
    print "Sending OSC to", send_address, "port:", send_port
    
    base = args.base
    i = 0
    while (True):
       accountID = "{}{:03d}".format(base, i)        
       i = i + 1
       # send OSC message
       msg = OSC.OSCMessage()
       msg.setAddress("/scan")      #add the account number to the msg
       msg.append(accountID)
       try:
           osc.send(msg)
       except Exception as e:
           print e
           
       time.sleep(120)
        