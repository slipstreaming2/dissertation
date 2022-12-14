line=$(head -n 1 minizinc.txt)
timing=$(head -n 1 timeout.txt)
runs=$(head -n 1 numberOfRuns.txt)

solutionDir=${3}

chosen_solver=${4}

printf "using ${chosen_solver} \n"

# if [[ -z ${3} ]]; then
#     solutionDir="solutions"
# fi

[[ -d "${1}/${solutionDir}" ]] || mkdir "${1}/${solutionDir}"

for f in ${1}/*.*; do
    base_name=$(basename ${f})
    printf "${base_name} \n"

    to_run="$line --solver ${chosen_solver} -t ${timing} "${f}" "${2}" -s --output-mode json --json-stream"
    [[ -d "${1}/${solutionDir}/${base_name}" ]] || mkdir "${1}/${solutionDir}/${base_name}"

    for ((i=1;i<=runs;i++)); do 
        target="${1}/${solutionDir}/${base_name}/${base_name}_run${i}.txt"

        if [[ -z ${5} ]]; then
            ${to_run} > ${target}
        else
            ${to_run} -f > ${target}
        fi
    done
done 