from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import inch
from reportlab.lib.colors import black
import urllib
import string
from PIL import Image
import random
import pickle 
import argparse
import sys as Sys


# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
webUrl = "http://bitmorph.rtanewmedia.ca/"

# this will contain the valid characters for a code
charSet = []
for c in string.ascii_lowercase:
    charSet.append(c)

for i in range(48, 58):
    charSet.append(chr(i))

banned = ['a','e','i','o','u','y','1','l','0']
for b in banned: charSet.remove(b)

# used codes 
usedCodes = pickle.load(open("used-codes.pickle"))    
        
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
# -- input: a 6 character user code 
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
        if not isUsed(code): keepLooking = False

    # add the code to the used list 
    usedCodes.append(code)    
        
    return code

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
def isUsed(code):
    if code in usedCodes:
        return True
    return False 

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
def generatePage(pdf, front, back):
    
    w = 4.0*inch
    h = 2.5*inch
    # first generate four random codes
    codes = {}
    for i in range(0, 2):
        for j in range(0, 2):
            codes[ (i,j) ] = getRandomCode()
            print "Generating", codes[(i,j)]
    
    pdf.setFont("Helvetica", 7.90)
    for i in range(0, 2):
        for j in range(0, 2):
            x = w*i + i*spacing + border
            y = h*j + j*spacing + border
            code = codes[(i, j)]
            pdf.drawInlineImage(front, x, y, w, h)
            pdf.drawString(x + 1.055*inch, y+1.18*inch, webUrl + code)
    pdf.showPage()
    
    
    for i in range(0, 2):
        for j in range(0, 2):
            x = w*i + i*spacing + border
            y = h*j + j*spacing + border
            
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
def printProgress (iteration, total, prefix = '', suffix = '', decimals = 2, barLength = 100):
    """
    Call in a loop to create terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : number of decimals in percent complete (Int) 
        barLength   - Optional  : character length of bar (Int) 
    """
    filledLength    = int(round(barLength * iteration / float(total)))
    percents        = round(100.00 * (iteration / float(total)), decimals)
    bar             = '#' * filledLength + '-' * (barLength - filledLength)
    Sys.stdout.write('%s [%s] %s%s %s\r' % (prefix, bar, percents, '%', suffix)),
    Sys.stdout.flush()
    if iteration == total:
        print("\n")
    
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
if __name__ == "__main__":    
    
    # parse command line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument('numPages', type=int, help='number of pages to generate')
    parser.add_argument('filename', type=str, help='output file name')
    parser.add_argument('--test', action="store_true", help='include the card image file')
    parser.add_argument('--reset', action="store_true", help='reset the used code file')
    args = parser.parse_args()
    
    # generate the PDF
    front = Image.open("graphic.png");    
    pdf = canvas.Canvas(args.filename, pagesize=(4.0*inch, 2.5*inch), enforceColorSpace='sep_black')
    
    for i in range(args.numPages):        
        code = getRandomCode()
        query = getQRUrl(code)         
        # get the image
        urllib.urlretrieve(query, "temp.jpg")
        qrImage = Image.open("temp.jpg")        
        qrImage = qrImage.convert("1");

        if args.test: pdf.drawInlineImage(front, 0, 0, 4.0*inch, 2.5*inch)
        pdf.drawInlineImage(qrImage, 0.6125*inch, 0.5*inch, 1.5*inch, 1.5*inch)
    
        pdf.setFont("Helvetica", 10)
        pdf.setFillColor(black)
        pdf.translate(3.50*inch, 1.25*inch)
        pdf.rotate(90)
        pdf.drawCentredString(0, 0, webUrl + code)
        pdf.showPage()
    
        printProgress(i, args.numPages-1, "Generating: ", "Complete")
    
    pdf.save()
    
    if (args.reset): 
        print 'Used codes cleared'
        pickle.dump([], open("used-codes.pickle", 'w'))
    else: 
        if (args.test == False): 
            print 'Saved used codes.'
            pickle.dump(usedCodes, open("used-codes.pickle", 'w'))