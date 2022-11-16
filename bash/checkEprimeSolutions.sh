for f in ${1}/*.param; do 
    base_name=$(basename ${f})
    if [ -z "${2}" ];
    then
        python ../python/checkSolutions.py "$f" "${1}/../solutions/${base_name}.solution"
    else 
        python ../python/checkSolutions.py "$f" "${2}/solutions/${base_name}.solution"
    fi
done