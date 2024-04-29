# Bubble-Sort-MASM
A Simple bubble sort program sorts a list of HEX values representing ASCII characters, and outputs the sorted result.
Feel free to use this however you wish, this is just a small sample program.
The code uses the MASM32 SDK and its adjacent libraries, and these are therefore required for the program to start and run.
The code is also written using 32-bit assembly to allow MACROs and procedures from MASM32 to be called, though most of the Variables
used are 16 bits, and therefore utilise the 16 bit registers.
The code is set to run on the .686 architecture - Its compatible with any architecture succeeding the .386. The reason for this was I
aimed to include some form of branchless code, but never got round to it.

At default assembly, using the Microsoft Linker, the executable size is 2.56kB.
Using a few linker commands, specifically 'ml /coff main.asm /link /merge:.rdata=.text /merge:.data=.text /align:16 /subsystem:console',
the size is cut to roughly 960kB.
