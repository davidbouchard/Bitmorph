#!/bin/bash
original=$(<hueShift.sql)
dest=hueShift.sql
replace1=_v1.png
replace2=_v2.png
replace3=_v3.png
replace4=_v4.png
replace5=_v5.png
replace_1=",1);"
replace_2=",2);"
replace_3=",3);"
replace_4=",4);"
replace_5=",5);"

result1="${original//".png"/$replace1}"
result_1="${result1//");"/$replace_1}"
echo "res1"
result2="${original//".png"/$replace2}"
result_2="${result2//");"/$replace_2}"
echo "res2"
result3="${original//".png"/$replace3}"
result_3="${result3//");"/$replace_3}"
echo "res3"
result4="${original//".png"/$replace4}"
result_4="${result4//");"/$replace_4}"
echo "res4"
result5="${original//".png"/$replace5}"
result_5="${result5//");"/$replace_5}"
echo "res5"
echo "$result_1" >> "$dest"
echo "write1"
echo "$result_2" >> "$dest"
echo "write2"
echo "$result_3" >> "$dest"
echo "write3"
echo "$result_4" >> "$dest"
echo "write4"
echo "$result_5" >> "$dest"
echo "write5"

