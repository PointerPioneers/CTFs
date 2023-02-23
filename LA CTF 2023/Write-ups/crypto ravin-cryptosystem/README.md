# crypto/ravin-cryptosystem

## Approach 1: chall description is raving

The description of this challenge says that it involves RSA, with a small enough modulus so that it can be factored.
This was confirmed by looking a bit more at the Python script, where `n` is the modulus:

```py
p = number.getPrime(100)
q = number.getPrime(100)
n = p*q
```
Looking up the function used for generating prime numbers, we found that the `p` and `q` involved are 100-bit numbers. The current minimum recommendation is that these numbers have at least 1024 bits.

Because of this, we started by trying to factorise these numbers. We looked up how to do this, and found our result on [dCode](https://www.dcode.fr/prime-factors-decomposition), which gave us `p = 861346721469213227608792923571` and `q = 1157379696919172022755244871343` within a couple seconds.

Because of our background in cryptography, we knew how to attack RSA in this scenario: to perform RSA decryption, you need the ciphertext `c`, the private key `d` and the modulus `n`. Of these, only `d` was still unknown to us. However, since we know `p` and `q`, we can use the same process for computing `d` as is done during RSA key generation:
- compute $\varphi(n) = (p - 1)(q - 1)$
- compute $d \equiv e^{-1} \mod \varphi(n)$

Doing this, we got `phi_n = 996905207436360486995498787815587704556495732409544689330940` and `d = 331272435533348470112882380961103941740259152240948841787833`. With this, we can perform RSA decryption using $m \equiv c^d \mod n$, from which we got `m = 736145502400954707780384614530985023141828296658621567180940`. 

Then, we converted this message back to text, but this did not give us the flag we expected to get. We checked our approach for mistakes, and we verified some of the numbers we calculated throughout the computation. This didn't provide any clarity, so we looked deeper at the Python code.

## Approach 2: `fastpow` is not so pow
Most of the code made sense to us, but there was one exception: the `fastpow` method had a comment in the same 'style' as the description of the challenge. 

The function is supposed to perform modular exponentiation, by computing $b^p \text{ (mod } mod)$. However, we noticed an issue with the code:
```py
def fastpow(b, p, mod):
    # idk this is like repeated squaring or something i heard it makes pow faster
    a = 1
    while p:
        p >>= 1
		...
```
Here, you can see that in the first iteration of the while loop (assuming p is non-zero), p is shifted to right by 1 bit. Because this is done before doing anything with the bit that was cut off, so the function performs the same future steps in case this bit was 0 or 1, so it will return the same result in both cases. However, this cannot be correct, as such a change of the exponent will (in most cases) also change the result.

This told us that there was something wrong with this function, so we looked more into what it was really doing. There was an attempt to implement a binary right-to-left method, which is a way of computing modular exponentiation. However, there is one small mistake the implementation makes: it switched the order of the computation steps in the loop.

Looking at the pseudocode on [Wikipedia](https://en.wikipedia.org/wiki/Modular_exponentiation#Right-to-left_binary_method):
```
while exponent > 0 do
	if (exponent mod 2 == 1) then
		result := (result * base) mod modulus
	exponent := exponent >> 1
	base := (base * base) mod modulus
```
We can see that we first need to check the rightmost bit of the exponent and multiply the result if needed, then we shift the exponent and cut off the right bit, then we square the base.

However, the Python implementation in `ravin.py` first shifts the exponent, then squares the base and only then it checks the rightmost bit. With this information in mind, we tried to find what this function was actually computing, so that we could try to reverse it in order to decrypt the ciphertext.

With the exponent `e = 65537 = 2^16 + 1`, we went through the steps this function takes (`old_b` denotes the value of `b` the function was called with):
1. Shift the exponent to the right, now `e = 2^15`.
2. Square `b`, now `b = old_b^2`.
3. Repeat steps 1 and 2 for 15 iterations total, now `e = 2` and `b = old_b^32768`.
4. One last time, we shift the exponent, so `e = 1`.
5. Square `b`, changing it to `b = old_b^65536`.
6. Finally we change the result `a`, setting it to `old_b^65536` (as `a` has not changed in any previous iterations).

Therefore, instead of computing `b^e` (in our case of `e`), it computed `b^(e-1) = b^(2^16)`. Because this is just repeated squaring, we can reverse this by repeated square rooting. 
This took us surprisingly long, as we didn't have the tools ready to perform these kinds of computations (this was our first CTF after all).
We also started with the wrong exponent, we mistakenly used `16` instead of `2^16`, which made this last step even longer.

We ended up finding [SageMath](https://www.sagemath.org/), which we used as follows, after some trial and error:
```sage
sage: n = 996905207436360486995498787817606430974884117659908727125853
sage: e = 65537
sage: c = 375444934674551374382922129125976726571564022585495344128269
sage: mod(c, n).nth_root(e - 1)
40549930713646101196507797105878967309586158452159869
```

Therefore, `m = 40549930713646101196507797105878967309586158452159869`. Converting this back to a string (first to hexadecimal, then to UTF-8), we got the flag: `lactf{g@rbl3d_r6v1ng5}`.

## Reflection
Looking back on how we solved the challenge, there are a few points we could've done better on:
- Due to our lack of experience, we didn't know the right tools for these kind of computations. However, we did find the right tool (SageMath) during the CTF period, so this one shouldn't be a problem anymore in the future, for much of crypto at least.
- We should've started by reading the code a bit more carefully. It didn't take long to spot that there was something wrong with their modular exponentiation function once we looked at it more critically, so we could've skipped the first approach immediately if we had seen this before.
