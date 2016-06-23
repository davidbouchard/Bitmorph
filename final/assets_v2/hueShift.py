from PIL import Image
from PIL import ImageStat
from PIL import ImageChops
import numpy as np
import colorsys
import os

outdir = "shifted"

rgb_to_hsv = np.vectorize(colorsys.rgb_to_hsv)
hsv_to_rgb = np.vectorize(colorsys.hsv_to_rgb)

def shift_hue(arr, hout):
    r, g, b, a = np.rollaxis(arr, axis=-1)
    h, s, v = rgb_to_hsv(r, g, b)
    h = (h + hout) % 1.0
    r, g, b = hsv_to_rgb(h, s, v)
    arr = np.dstack((r, g, b, a))
    return arr

def shiftHue(image, amount):
    """
    Colorize PIL image `original` with the given
    `hue` (hue within 0-360); returns another PIL image.
    """
    img = image.convert('RGBA')
    arr = np.array(np.asarray(img).astype('float'))
    new_img = Image.fromarray(shift_hue(arr, amount/360.).astype('uint8'), 'RGBA')
    return new_img

def is_greyscale(im):
    """
    Check if image is monochrome (1 channel or 3 identical channels)
    """
    rgb = im.split()
    if ImageChops.difference(rgb[0],rgb[1]).getextrema()[1]!=0: 
        return False
    if ImageChops.difference(rgb[0],rgb[2]).getextrema()[1]!=0: 
        return False
    return True

def processFolder(folder):
    hues = (50, 100, 150, 200, 250) 
    for root, dir, files in os.walk(folder):
        for f in files:
            # create the folder
            try:
                os.makedirs(os.path.join(outdir, root))
            except OSError:
                pass
                #print "already exists"
        
            fullname = os.path.join(root, f)
            try:
                img = Image.open(fullname)
                #if is_greyscale(img): continue
                basename, ext = os.path.splitext(fullname) 
                for v in range(0, len(hues)): 
                    outname = "{}_v{:d}.png".format(basename, v+1) 
                    outname = os.path.join(outdir, outname)
                    img2 = shiftHue(img, hues[v])
                    img2.save(outname)
                    
                # save the original image as well 
                outname = "{}.png".format(basename)
                outname = os.path.join(outdir, outname)        
                img.save(outname) 
                print outname                               
    
            except IOError:
                pass #ignore .DS_Store and the likes


folders = ("01egg", "02baby", "03worm", "04adult", "05accessories")
for f in folders: processFolder(f);
