def prime(n):
    for n in range(2, n):
        for x in range(2, n):
            if n % x == 0:
                break
        else:
            print(n, "is a prime number:")


prime(3)
