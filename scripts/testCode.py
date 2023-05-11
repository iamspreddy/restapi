# import the regex module
import re

string = "wqtegqey4532dttt"
print("Original string: ", string)
newString = re.sub("t", "T", string)
sster = string.replace("t", "T")

print("The new string: ", newString)
print("The new string: ", sster)

x = "srtbd"
for i, n in enumerate(x):
    print(i, n)
print(x)
