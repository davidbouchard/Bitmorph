import random
import os.path
from PIL import Image
import urllib, cStringIO
import sys

def gen(baseCode, n):
    print "*"*80
    base = "http://osc.rtanewmedia.ca/character-update/{}/{}"
    areas = ["inn", "spa", "hum", "sci", "liv"]  
    out = Image.new('RGBA', (300, 50))
    box = (0, 0, 50, 50) 
    for i in range(0, 5):
        a = random.choice(areas)
        areas.remove(a)
        url = base.format(baseCode+n, a) 
        print url
        file = cStringIO.StringIO(urllib.urlopen(url).read())
        img = Image.open(file)
        
        #save the original
        try:
            os.makedirs(os.path.join(baseCode,"raw"))
        except:
            pass
        f = "%s/%s/%s%s_%d_%s.png" % (baseCode, "raw", baseCode, n, i, a)
        img.save(f)

        crop =  img.crop(box)
        #print crop
        out.paste(crop, (i*50, 0, (i+1)*50, 50))
    
    # grab the last item
    crop = img.crop((50, 0, 100, 50)) 
    out.paste(crop, (250, 0, 300, 50))
    
    # also grab the 2nd character from the last image 
    out.save(os.path.join(baseCode,baseCode+n+".png"))
        
        
baseCode = sys.argv[1]

try:
    os.makedirs(baseCode)
except:
    pass


for i in range(0, 99): 
    gen(baseCode, "%02d" % i)
    


