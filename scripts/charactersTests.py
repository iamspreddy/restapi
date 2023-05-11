s = "purushothama"
count = 0
a = ''
for i in s:
    if i == "u":
        count = count + 1
        valOfI = i
        if i not in a:
            a += i

s = {a: count}
print(s)
print(valOfI, ":", count)
if count == 2:
    print("duplicate", valOfI, " value", count)
