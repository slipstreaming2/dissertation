for f in ${1}/*.param; do 
    python ../python/checkSolutions.py "$f"
done