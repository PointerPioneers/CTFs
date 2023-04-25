# i OFTen see star wars

### Description
Whoops... I accidentally overwrote the magicNumber & achVendID in this font file. Can you help me retrieve them?

Flag format: shctf{}

File given: Aurebesh-Patched.zip

Category: forensics

Author: [teeman22](https://github.com/tylzars)

## Observations

A quick search gives us the following hints:
- OTF is font file.
- Aurebesh is a font created by [Pixel Sagas](https://www.pixelsagas.com/?download=aurebesh), which is based on the legendary Star Wars "Galactic Standard" typeface.
- `magicNumber` is set to `0x5F0F3CF5`.
- `achVendID` is a four-chracter identifier for the font vendor, in this case Pixel Sagas is `PXSG`.
     This part was rather vague at first since Pixel Sagas was not listed in Microsoft's [registry of vendor IDs](https://learn.microsoft.com/en-us/typography/vendors/).

## Solution

We first downloaded the original Aurebesh font files and opened one in a hex editor. We found that `magicNumber` is on line 0140 and `achVendID` can be found on line 01F0 as shown here:
![screenshot from original font file](<original-aurebesh.png>)

Afterwards, parts of the flag can be retrieved from these 2 lines in 8 given font files and reassembled to get `shctf{th3r3_1s_always_s0me_h0p3_4r0und}`.
