#!/bin/bash

# Get the 4 hexadecimal values from the user
echo "Enter the UID (7 hex bytes separated by spaces):"
read hex1 hex2 hex3 hex4 hex5 hex6 hex7

# Convert the hexadecimal values to binary
bin1=$(echo "ibase=16; $hex1" | bc)
bin2=$(echo "ibase=16; $hex2" | bc)
bin3=$(echo "ibase=16; $hex3" | bc)
bin4=$(echo "ibase=16; $hex4" | bc)
bin5=$(echo "ibase=16; $hex5" | bc)
bin6=$(echo "ibase=16; $hex6" | bc)
bin7=$(echo "ibase=16; $hex7" | bc)

#calcualte the 1st check byte
checkByte1=$(printf "%02s" $(echo "obase=16 ; $((136^bin1^bin2^bin3))" | bc))

#calculate the 2nd check byte
checkByte2=$(printf "%02s" $(echo "obase=16 ; $((bin4^bin5^bin6^bin7))" | bc))

#hex encoding
asciiValue=($hex1$hex2$hex3$hex4$hex5$hex6$hex7)
hexValue=$(echo -n "$asciiValue" | xxd -p)
splitHex=$(echo $hexValue| sed 's/\(..\)/\1 /g')
en1=${splitHex:0:5}
en2=${splitHex:6:11}
en3=${splitHex:18:11}
en4=${splitHex:30:11}

# Output the result
echo "1st check byte is: $checkByte1"
echo "2nd check byte is: $checkByte2"
echo "hex encoding1 is:  $en1"
echo "hex encoding2 is:  $en2"
echo "hex encoding3 is:  $en3"
echo "hex encoding4 is:  $en4"

#creating the nfc tag
templateFile="nfc_template.nfc"
outputFileName="tag"

#check if file exists if not create it 
if [[ -e $outputFileName.nfc || -L $outputFileName.nfc ]] ; then
    i=0
    while [[ -e $outputFileName-$i.nfc || -L $outputFileName-$i.nfc ]] ; do
        let i++
    done
    outputFileName=$outputFileName-$i
fi
touch -- "$outputFileName".nfc

#replace template with marked values
sed "s/HEX1/$hex1/g; s/HEX2/$hex2/g; s/HEX3/$hex3/g; s/HEX4/$hex4/g; s/HEX5/$hex5/g; s/HEX6/$hex6/g; s/HEX7/$hex7/g; s/CHECKBYTE1/$checkByte1/g; s/CHECKBYTE2/$checkByte2/g; s/EN1/$en1/g; s/EN2/$en2/g; s/EN3/$en3/g; s/EN4/$en4/g; " "$templateFile" > "$outputFileName".nfc

