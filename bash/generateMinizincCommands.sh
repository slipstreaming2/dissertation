line=$(head -n 1 minizinc.txt)
timing=$(head -n 1 timeout.txt)
runs=$(head -n 1 numberOfRuns.txt)
declare -a rnd=("1" "7" "12")

solutionDir=${3}

chosen_solver=${4}

if [[ $5 == "y" ]]; then
    [[ -d "${1}/${solutionDir}" ]] || mkdir "${1}/${solutionDir}"
fi

for f in ${1}/*.*; do
    base_name=$(basename ${f})
    to_run="$line --solver ${chosen_solver} -t ${timing} "${f}" "${2}" -s --output-mode json --json-stream"

    if [[ $5 == "y" ]]; then
        [[ -d "${1}/${solutionDir}/${base_name}" ]] || mkdir "${1}/${solutionDir}/${base_name}"
    else
        for ((i=1;i<=runs;i++)); do 
            target="${1}/${solutionDir}/${base_name}/${base_name}_${6}run${i}.txt"
            if [[ -z ${6} ]]; then
                echo "${to_run} -r ${rnd[${i}-1]} > ${target}"
            else
                echo "${to_run} -f -r ${rnd[${i}-1]} > ${target}"
            fi
        done
    fi
done 