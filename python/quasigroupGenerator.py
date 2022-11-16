import random

N = 50

res = [[0 for _ in range(N)] for _ in range(N)]

# https://www.geeksforgeeks.org/latin-square/
# with alterations to support storage into array
def generateLatinSquare(n):
    first_half_end = n + 1
    for i in range(1, n + 1):
        j = 0
        first_half_start = first_half_end
        while (first_half_start <= n):
            print(first_half_start, end=" ")
            res[i-1][j] = first_half_start
            j += 1
            first_half_start += 1

        for second_half_start in range(1, first_half_end):
            print(second_half_start, end=" ")
            res[i-1][j] = second_half_start
            j += 1
        first_half_end -= 1
        print()
    print()

generateLatinSquare(N)
# print(res)

filledHoles = 0
needToFill = int(0.42*N*N)
high = int(0.6*N)
low = high-1
count = 0

# punch a number of holes into the generated latin square to create a quasigroup
# while filledHoles < needToFill:
for i in range(N):
    numZeros = random.randrange(low,high+1)
    for z in range(numZeros):
        ind = random.randrange(N)
        res[i][ind] = 0
        count += 1

print(res)
print(count)


