def m1(n):
    print("This is from m1 method:", n)


def m2(self):
    print("This is from m2 method")


def m3(self):
    print("Hello World")


class Sp:
    def m4(k):
        print("Hello World:", k)
    m1(2)
    m4(34)
