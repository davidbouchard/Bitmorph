from openpyxl import Workbook
from openpyxl.drawing.image import Image
import urllib
import string
#from PIL import Image
import random
import pickle 
import argparse

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
webUrl = "http://bitmorph.rtanewmedia.ca/"

# this will contain the valid characters for a code
charSet = []
for c in string.ascii_lowercase:
    charSet.append(c)

for i in range(48, 58):
    charSet.append(chr(i))

# remove illegal characters
charSet.remove('a')
charSet.remove('e')
charSet.remove('i')
charSet.remove('o')
charSet.remove('u')
charSet.remove('y')
charSet.remove('1')
charSet.remove('0')
charSet.remove('l')

# contains bad words to check against 
badWords = []
with open('bad-words.txt') as f: 
    badWords = f.read().splitlines()
        
# used codes 
usedCodes = pickle.load(open("used-codes.pickle"))    
        
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
# -- input: a 4 character user code 
# -- returns: a QR code Image object 
def getQRUrl(userCode):        
    query = "https://chart.googleapis.com/chart?" 
    query = query + "chs=450x450"                 
    query = query + "&cht=qr"                                  
    query = query + "&chl="                                  
    url = webUrl + userCode
    query = query + url
    return query

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
def getRandomCode():    
    keepLooking = True 
    code = ""
    while (keepLooking):
        code = ""
        for i in range(4):     
            code = code + random.choice(charSet)            
        if isClean(code) and not isUsed(code): keepLooking = False

    # add the code to the used list 
    usedCodes.append(code)    
        
    return code


# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
# I don't think this is needed anymore since we removed some characters from the options
# leaving it just in case
def isClean(code): 
    # remove digits 
    noDigits = ''.join([i for i in code if not i.isdigit()])
    for word in badWords:
        if word in noDigits: 
            return False
    return True

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
def isUsed(code):
    if code in usedCodes:
        return True
    return False 

    
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
if __name__ == "__main__":    
    
    # parse command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('numPages', type=int, help='number of pages to generate')
    parser.add_argument('outFile', type=str, help='filename to output')
    parser.add_argument('--reset', action="store_true", help='reset the used code file')
    args = parser.parse_args()
    
    wb = Workbook()
    ws = wb.active
     
    for i in range(args.numPages):
        code = getRandomCode()
        url = getQRUrl(code)
        urllib.urlretrieve(url, "temp.jpg")
        qrImage = Image("temp.jpg")               
        ws.add_image(qrImage, 'A1')
    
    wb.save(args.outFile)
    
    if (args.reset): pickle.dump([], open("used-codes.pickle", 'w'))
    else: pickle.dump(usedCodes, open("used-codes.pickle", 'w'))