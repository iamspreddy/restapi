def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True


"""write prime number in between from given range"""
for n in range(1, 30):
    if is_prime(n):
        print(n)
"""check given number is prime or not"""
x = is_prime(21)
print(x)
