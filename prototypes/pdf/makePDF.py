from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import inch
import urllib
import string
from PIL import Image


webUrl = "http://bitmorph.rtanewmedia.ca/"

# this will contain the valid characters for a code
charSet = []

def buildCharSet():
    for c in string.ascii_lowercase:
        charSet.append(c)

    for i in range(48, 58):
        charSet.append(chr(i))

def getQR(userCode):    
    query = "https://chart.googleapis.com/chart?" 
    query = query + "chs=200x200"                 
    query = query + "&cht=qr"                                  
    query = query + "&chl="                                  
    url = webUrl + userCode
    query = query + url
    return query

def generatePageFront(pdf, template):
    code = "abcdefg"    
    qrUrl = getQR(code)
    
    urllib.urlretrieve(qrUrl, "temp.jpg")
    qrImg = Image.open("temp.jpg")    

    w = 4.25*inch
    h = 2.75*inch
    for i in range(0, 2):
        for j in range(0, 4):
            x = w*i
            y = h*j
            pdf.drawInlineImage(template, x, y, w, h)
            pdf.drawInlineImage(qrImg, x+0.5*inch, y+0.5*inch, 1*inch, 1*inch)
            pdf.drawString(x, y, webUrl + code)
    
    pdf.showPage()


if __name__ == "__main__":    

    template = Image.open("template.png");
    pdf = canvas.Canvas("output.pdf", pagesize=letter)
    
 
    generatePageFront(pdf, template)
    generatePageFront(pdf, template)
    
    
    pdf.save()