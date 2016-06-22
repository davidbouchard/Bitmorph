import re 

c = 0
def repl(match):
    global c
    #hex
    #id = '{:0>6s}'.format(hex(c)[2:]).upper()
    #decimal 
    id = '{:06d}'.format(c)
    c = c + 1
    return id

#regex = '\d'
regex = '\*'
#input = "test * * 2 3 4 5 5 6 2 3 4 5 2 3 4 6 5 6" 

input = "".join(open('table_creation.sql').readlines())

m = re.sub(regex, repl, input) 

print m 