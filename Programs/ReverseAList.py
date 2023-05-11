words=["Hello","dhoni","reddy","SP","deviprathima"]
for i in words:
    if i:
        my_list=list(i)
        my_list.reverse()
        rev = "".join(my_list)
        print(rev)
exit()