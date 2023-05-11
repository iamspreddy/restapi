str1 = "thihcdpep"
count = 0
varI = ""
a = ''
s = {}
for i in str1:
    if i == "p":
        count = count + 1
        if count <= 2:
            vol = str1.index(i)
            print(vol)
            # str1.replace(vol, '&')
            print(str1)
            a = a + i
            print(a)
        varI = i
s[a]
print(varI, ":", count)
print(s)