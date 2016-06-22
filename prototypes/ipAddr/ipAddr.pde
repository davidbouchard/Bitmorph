import java.net.*;
import java.util.*;

void setup() {
   println(getIPAddress("en1"));
   println(getPublicIPAddress());
}

void draw() {
}

String getPublicIPAddress() {
  String URL = "http://bot.whatismyipaddress.com/";
  String[] data = loadStrings("http://bot.whatismyipaddress.com/");
  return data[0];
}

String getIPAddress(String interfaceName) {
   try {
    NetworkInterface n = NetworkInterface.getByName(interfaceName);
    Enumeration ee = n.getInetAddresses();
    while (ee.hasMoreElements())
    {
      InetAddress i = (InetAddress) ee.nextElement();   
      if (i.isLinkLocalAddress() == false) return i.getHostAddress();
    }
  }
  catch(Exception e) {
    e.printStackTrace();    
  }
  return null;
}