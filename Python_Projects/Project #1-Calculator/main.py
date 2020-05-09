import re

print("Calculator")

previous = 0
run = True
print("Type 'quit' to exit\n")

def performMath():
    global run
    global previous
    equation = ''
    if previous == 0:
        equation = input("Enter equation: ")
    else: 
        equation = input(str(previous))


    if equation == 'quit':
        print("Goodbye!")
        run = False
    else:
        equation = re.sub('[a-zA-Z,.:()""]', '', equation)
        if previous == 0:
            previous = eval(equation)
        else:
            previous = eval(str(previous) + equation)
        print('The answer is:', previous)

while run:
    performMath()