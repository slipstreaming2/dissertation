for f in ${1}/*.param; do 
    base_name=$(basename ${f})
    for dir in ${2}/*/; do 
        dir=${dir%*/}
        python ../python/checkSolutions.py "$f" "${dir}/${base_name}"*
    done 
done