import math

rows = 7
cols = 4

M = [[0 for _ in range(cols)] for _ in range(rows)]

w = 12

for i in range(rows):
    for j in range(cols):
        if i < w % 4:
            M[i][j] = math.ceil(w / 4)
        else:
            M[i][j] = int(w / 4)

print(M)