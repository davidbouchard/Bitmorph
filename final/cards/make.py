from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import inch
import urllib
import string
from PIL import Image
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

# contains bad words to check against 
badWords = []
with open('bad-words.txt') as f: 
    badWords = f.read().splitlines()
        
# used codes 
usedCodes = pickle.load(open("used-codes.pickle"))    
        
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
# -- input: a 6 character user code 
# -- returns: a QR code Image object 
def getQRUrl(userCode):        
    query = "https://chart.googleapis.com/chart?" 
    query = query + "chs=300x300"                 
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
        for i in range(6):     
            code = code + random.choice(charSet)            
        if isClean(code) and not isUsed(code): keepLooking = False

    # add the code to the used list 
    usedCodes.append(code)    
        
    return code


# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
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
def generatePage(pdf, front, back):
    
    w = 4.0*inch
    h = 2.5*inch
    
    border = 0.25 * inch;
    spacing = 1;
    
    # first generate four random codes
    codes = {}
    for i in range(0, 2):
        for j in range(0, 2):
            codes[ (i,j) ] = getRandomCode()
            print "Generating", codes[(i,j)]
    
    pdf.setFont("Helvetica", 7.90)
    for i in range(0, 2):
        for j in range(0, 2):
            x = w*i*spacing + border
            y = h*j*spacing + border
            code = codes[(i, j)]
            pdf.drawInlineImage(front, x, y, w, h)
            pdf.drawString(x + 1.055*inch, y+1.18*inch, webUrl + code)
    pdf.showPage()
    
    
    for i in range(0, 2):
        for j in range(0, 2):
            x = w*i*spacing + border
            y = h*j*spacing + border
            
            # need to mirror codes horizontally 
            ii = 0;
            if (i==0): ii = 1;
            code = codes[(ii, j)]
            
            query = getQRUrl(code)         
            # get the image
            urllib.urlretrieve(query, "temp.jpg")
            qrImage = Image.open("temp.jpg")   
            pdf.drawInlineImage(back, x, y, w, h)
            pdf.drawInlineImage(qrImage, x+0.6*inch, y+0.5*inch, 1.5*inch, 1.5*inch)
            
            """
            testing to see if codes line up
            pdf.saveState();
            pdf.translate(x+2.1*inch, y+0.5*inch);
            pdf.rotate(90);
            pdf.drawString(0, 0, code);	
            pdf.restoreState();
            """
            
    pdf.showPage()    
    
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
if __name__ == "__main__":    
    
    # parse command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('numPages', type=int, help='number of pages to generate')
    parser.add_argument('--reset', action="store_true", help='reset the used code file')
    args = parser.parse_args()
    print(args)
    
    # generate the PDF
    front = Image.open("front.png");
    back = Image.open("back.png");
    
    pdf = canvas.Canvas("output.pdf", pagesize=(612.0, 792.0/2))
     
    for i in range(args.numPages):
        generatePage(pdf, front, back)
    
    pdf.save()
    
    if (args.reset): pickle.dump([], open("used-codes.pickle", 'w'))
    else: pickle.dump(usedCodes, open("used-codes.pickle", 'w'))