import os

f = open("C:/Users/Purushotham-3186/Desktop/spreddy.txt", "rt")
#print(f.readline())
x= len(f.readlines())
print(x)
f.readlines()
for i in f:
    print(i, end='')
f.close()
