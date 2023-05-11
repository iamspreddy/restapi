vowels = "aeiouAEIOU"
String = input("Enter your String: ")
count = 0
ltv = []
for char in String:
    if char in vowels:
        count += 1
    ltv = [char]

print(set(ltv))
print("Number of vowels in the given string: ", count)
