# Hamming Distance Combinational Circuit in Verilog

Hi! Welcome to my repository. This is a digital logic project I made to calculate the Hamming Distance between two binary numbers using Verilog.

I am building this as part of my journey learning about cyber security and hardware design.

## What is Hamming Distance?

Hamming distance is basically just counting how many bits (0s and 1s) are different between two inputs of the exact same length.

For example, if we have two 4-bit numbers:

- Input A: `1 0 1 0`
- Input B: `1 0 0 1`
The distance is **2** because the last two bits are different.

### Why is this a Security Project?

Hamming distance is super important in hardware security and cryptography. It is used for:

- **Biometrics:** When a fingerprint scanner checks your finger, it's never a 100% perfect match because of dirt or sweat. The hardware uses Hamming distance to see if it's "close enough" to unlock your phone.
- **Cryptography:** To check if a secret key has been corrupted or if a hash function is good (changing one bit of a password should completely scramble the hash).
- **Error Detection:** Catching bits that get flipped by hackers or noisy signals during data transmission.

### How I Used Verilog for the Combinational Circuit

It designed as a **combinational circuit**. This means it doesn't use any clocks or memory (like flip-flops)—the signals just flow straight through the logic gates to give the answer instantly.

Here is how the circuit works under the hood:

1. **Finding the Differences (XOR Gates):**
    First, I pass the two inputs through a bunch of XOR (Exclusive-OR) gates. XOR is perfect for this because it only outputs a `1` if the two inputs are *different*. If they are the same, it outputs `0`.
2. **Counting the Differences (Adder Tree):**
    This was the hard part! After the XOR gates give me a new binary string showing where the differences are, I have to count how many `1`s there are in that string. To do this without a clock or a "for loop" (since it's a combinational circuit), I had to wire up a tree of Half Adders and Full Adders to literally add all the bits together and output a final binary number.

### Files in this Repo

- `hamming.v` - This is the main Verilog file with the combinational logic (the XORs and Adders).

- `hamming_tb.v` - This is my testbench file. I wrote some dummy inputs in here to simulate the circuit and make sure it outputs the right distances.

### How to Run It

You don't need real hardware to test this.

1. You can copy the code into a free online simulator like [EDA Playground](https://www.edaplayground.com/).
2. Or, if you have Icarus Verilog installed on your computer, you can run:

   ```bash
   iverilog -o hamming_sim hamming.v hamming_tb.v
   vvp hamming_sim
