import time
import sys

start_time = time.time()

for line in sys.stdin:
    if  "--" in line:
        # d.append(time.time()-start_time)
        p = (time.time()-start_time)
        print(p)
    sys.stdout.write(line)
    sys.stdout.flush()