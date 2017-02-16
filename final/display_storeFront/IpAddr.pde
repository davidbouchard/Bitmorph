String wIP = "";
String eIP = "";
String pIP = "";

void checkIPs() {
  pIP = getPublicIPAddress();
  wIP = getIPAddress("wlan0");
  eIP = getIPAddress("eth0");
}

// Ip address troubleshooting tools 
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
      String addr = i.getHostAddress();
      if (addr.contains(interfaceName) == false) return addr;
    }
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  return null;
}