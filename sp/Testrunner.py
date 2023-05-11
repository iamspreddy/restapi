# x='dsfsdfwe5fewfw'
# print(x)
# j=x.index('f',3)
# print(j)
# k=x.rindex('f',10)
# print(k)
# print("Enter checking number:")
# x = int(input())
# count = 0
# print("checking whether the number is prime number or not.....")
# """Logic implementation"""
# for i in range(x):
#     if x % 2 == 0:
#         print("this is not a prime machi")
#         break
#     elif x % 2 != 0:
#         count = count + 1
# 
#     if count == 2:
#         print("given number is  a prime number")
#         break


def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True


def get_primes(n):
    primes = []
    for i in range(2, n + 1):
        if is_prime(i):
            primes.append(i)
    return primes


x=is_prime(30)
print(x)
y=get_primes(30)
print(y)