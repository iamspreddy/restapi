s = "purushothama"
count = 0
for i in s:
    if i == "u":
        count = count + 1
        valOfI = i

print(valOfI, ":", count)
if count == 2:
    print("duplicate",valOfI," value", valOfI)
