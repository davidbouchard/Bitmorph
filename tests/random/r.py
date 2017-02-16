import random
import urllib2

stations = ("sci", "inn", "spa", "liv", "hum")


def genChar(hexid):
	temp = list(stations)
	n = random.randint(1, 5)
	for i in range(0, n): 
		s = random.choice(temp)
		temp.remove(s)
		url = "http://osc.rtanewmedia.ca/character-update/%04d/%s" % (hexid, s)
		print url
		resp = urllib2.urlopen(url)
		#print resp
	# retreive image
	url = "http://osc.rtanewmedia.ca/character-image/%04d/600/600" % hexid
	print url
	resp = urllib2.urlopen(url)
	f = open("%04d.png" % hexid, 'w')
	f.write(resp.read())
	f.close()
	

for i in range(0, 200):	
	genChar(i)