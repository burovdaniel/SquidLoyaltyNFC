# SquidLoyaltyNFC
Reverse Engineering the Squid Loyalty NFC tags
This repo holds a bash script and some information on data data stored on Squid loyalty tags.
More detial on the tags can be found [here].

The bash script creates an NTAG213 nfc tag based on a given 7 byte UID.
This tag can then emualted with the right device. In my case I have been succecful with a flipper zero.

To run the bash script you need to make it excutable with the chmod command. And to make sure that the template file is the same directory as the script.

Run the script and will be prompted to enter the UID that then will create the nfc file.







[here]:https://danielburov.com/Squid-nfc/
