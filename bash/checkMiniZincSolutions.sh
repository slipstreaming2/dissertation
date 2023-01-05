for f in ${1}/*.param; do 
    f_base_name=$(basename ${f})
    arrIN=(${f_base_name//./ }) # split on '.'
    endName="dzn"
    if [[ -d  ${2}/${arrIN[0]}.json ]]; then
        endName="json"
    fi
    for sol in ${2}/${arrIN[0]}.${endName}/*; do 
        python ../python/checkSolutions.py "$f" "$sol" minizinc
    done
done