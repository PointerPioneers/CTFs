# i OFTen see star wars

### Description
Whoops... I accidentally overwrote the magicNumber & achVendID in this font file. Can you help me retrieve them?

Flag format: shctf{}

File given: Aurebesh-Patched.zip

Category: forensics. 430 points. 43 solves

Author: [teeman22](https://github.com/tylzars)


## Observations

A quick search gives us the following hints:
- OTF is a font file.
- Aurebesh is a font created by [Pixel Sagas](https://www.pixelsagas.com/?download=aurebesh), which is based on the legendary Star Wars "Galactic Standard" typeface.
- `magicNumber` is set to `0x5F0F3CF5`.
- `achVendID` is a four-character identifier for the font vendor, in this case, Pixel Sagas is `PXSG`.
     This part was rather vague at first since Pixel Sagas was not listed in Microsoft's [registry of vendor IDs](https://learn.microsoft.com/en-us/typography/vendors/).

## Solution

We first downloaded the original Aurebesh font files and opened one in a hex editor. We found that `magicNumber` is on line 0140 and `achVendID` can be found on line 01F0 as shown here:

![screenshot from original font file](<original-aurebesh.png>)

Afterward, parts of the flag can be retrieved from these 2 lines in 8 given font files and reassembled to get `shctf{th3r3_1s_always_s0me_h0p3_4r0und}`.

## Reflection
This was a rather straightforward challenge since the description already gave away a lot of information on where to find the flag. However, for some (unknown) reasons, my brain (one of the solvers') didn't register that parts of the flag are scattered among the given files. To make the matter worse, I used the 7th file to compare, which resulted in seemingly random letters on lines 0140 and 01F0. So my train of thought was to correct these hexadecimal back to the original values then run the font file and there would be a pop-up or something similar. But unfortunately, that is not how a font file works (should have realized that earlier). I then used the Hint: *The font files are ordered starting at Aurberesh-1 to Aurberesh-8. The flag should be reassembled in this order.* and immediately figured out my misunderstanding.
