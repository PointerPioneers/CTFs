"""
Chinese Remainder Theorem:
GCD ( Greatest Common Divisor ) or HCF ( Highest Common Factor )
If GCD(a,b) = 1, then for any remainder ra modulo a and any remainder rb modulo b
there exists integer n, such that n = ra (mod a) and n = ra(mod b).  If n1 and n2 are
two such integers, then n1=n2(mod ab)
Algorithm :
1. Use extended euclid algorithm to find x,y such that a*x + b*y = 1
2. Take n = ra*by + rb*ax
"""
from __future__ import annotations


# Extended Euclid
def extended_euclid(a: int, b: int) -> tuple[int, int]:
	"""
	>>> extended_euclid(10, 6)
	(-1, 2)
	>>> extended_euclid(7, 5)
	(-2, 3)
	"""
	if b == 0:
		return (1, 0)
	(x, y) = extended_euclid(b, a % b)
	k = a // b
	return (y, x - k * y)


# Uses ExtendedEuclid to find inverses
def chinese_remainder_theorem(n1: int, r1: int, n2: int, r2: int) -> int:
	"""
	>>> chinese_remainder_theorem(5,1,7,3)
	31
	Explanation : 31 is the smallest number such that
				(i)  When we divide it by 5, we get remainder 1
				(ii) When we divide it by 7, we get remainder 3
	>>> chinese_remainder_theorem(6,1,4,3)
	14
	"""
	(x, y) = extended_euclid(n1, n2)
	m = n1 * n2
	n = r2 * x * n1 + r1 * y * n2
	return (n % m + m) % m


# ----------SAME SOLUTION USING InvertModulo instead ExtendedEuclid----------------


# This function find the inverses of a i.e., a^(-1)
def invert_modulo(a: int, n: int) -> int:
	"""
	>>> invert_modulo(2, 5)
	3
	>>> invert_modulo(8,7)
	1
	"""
	(b, x) = extended_euclid(a, n)
	if b < 0:
		b = (b % n + n) % n
	return b


# Same a above using InvertingModulo
def chinese_remainder_theorem2(n1: int, r1: int, n2: int, r2: int) -> int:
	"""
	>>> chinese_remainder_theorem2(5,1,7,3)
	31
	>>> chinese_remainder_theorem2(6,1,4,3)
	14
	"""
	x, y = invert_modulo(n1, n2), invert_modulo(n2, n1)
	m = n1 * n2
	n = r2 * x * n1 + r1 * y * n2
	return (n % m + m) % m


g1 = 5022225517476497605877399366748368620021314905607244538337574754752194491022409016639198066584026460166648163900702327501551384049951747738224379425890194
m1 = 853484640463359180266671265063600655712321007736533343886637999335213589546995628567903259572174486376140943868271144617720680793886666146895920808603600

g2 = 128945344249933994754613559070132252591170864381079754393449145366446449096051451209397952964419125393883920978301309373929576608680732252443689613646320
m2 = 84561551174731731688654253549852839387791620867301708446629563112914637575673171902197151453691808890010359658686607434834672450008137567012834223840282

if __name__ == '__main__':
	r = chinese_remainder_theorem(g1, m1, g2, m2)
	
	while True:
		print(r)
		input()
		r += g1*g2
