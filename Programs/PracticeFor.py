words = ["dhoni", "purushu", 'prathima', "devi", 'reddy']
for i in words:
    # if i: if u want to restrict for certain point add your condition here
    my_list = list(i)
    my_list.reverse()
    rev = "".join(my_list)
    print(rev)
exit()
