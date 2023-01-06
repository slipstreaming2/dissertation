import math

# randomly creates roster files based off of CSPLib method
# https://www.csplib.org/Problems/prob087/data/
rows = 7 # num weekdays
cols = 4 # num shift types

M = [[0 for _ in range(cols)] for _ in range(rows)]

w = 12 # number of weeks

for i in range(rows):
    for j in range(cols):
        if i < w % 4:
            M[i][j] = math.ceil(w / 4)
        else:
            M[i][j] = int(w / 4)

print('weeks =', w)

print('shift requirements = ', M)