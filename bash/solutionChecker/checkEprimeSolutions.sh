python_path=$(head -n 1 checkSolutions_path.txt)

for f in ${1}/*.param; do 
    base_name=$(basename ${f})
    # for dir in ${2}/O0_S0; do 
    for dir in ${2}/*/; do 
        for sol in ${dir}${base_name}*; do 
            if [[ $3 == "objective" ]]; then
                for obj in $sol/*; do 
                    python ${python_path} "$f" "${obj}"
                done
            else
                python ${python_path} "$f" "${sol}"
            fi
        done
    done 
done