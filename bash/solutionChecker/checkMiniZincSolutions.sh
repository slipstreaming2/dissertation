python_path=$(head -n 1 checkSolutions_path.txt)

for f in ${1}/*.param; do 
    f_base_name=$(basename ${f})
    arrIN=(${f_base_name//./ }) # split on '.'
    endName="dzn"
    if [[ -d  ${2}/${arrIN[0]}.json ]]; then
        endName="json"
    fi
    for dir in ${2}/*/; do
        for sol in ${dir}/${arrIN[0]}.${endName}/*; do 
            python ${python_path} "$f" "$sol" minizinc
        done
done