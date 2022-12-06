# import fileinput
# import time

# start_time = time.time()

# for line in fileinput.input():
#     if  "--" in line:
#         p = (time.time()-start_time)
#         print(p)

import fileinput
import time
import sys

start_time = time.time()
d = []

for line in sys.stdin:
    if  "--" in line:
        # d.append(time.time()-start_time)
        p = (time.time()-start_time)
        print(p)
        sys.stdout.flush()

for i in d:
    print(i)