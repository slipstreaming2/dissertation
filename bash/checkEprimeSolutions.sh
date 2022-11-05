for f in ${1}/*.param; do 
    base_name=$(basename ${f})
    python ../python/checkSolutions.py "$f" "${1}/../solutions/${base_name}.solution"
done