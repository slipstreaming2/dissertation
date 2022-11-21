for f in ${1}/*.param; do 
    f_base_name=$(basename ${f})
    arrIN=(${f_base_name//./ }) # split on '.'
    for js in ${2}/${arrIN[0]}.json/*.json; do 
        python ../python/checkSolutions.py "$f" "$js" minizinc
    done
done