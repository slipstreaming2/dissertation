line=$(head -n 1 constants/minizinc.txt)
timing=$(head -n 1 constants/timeout.txt)
runs=$(head -n 1 constants/numberOfRuns.txt)
declare -a rnd=("1" "7" "12")

solutionDir=${3}

chosen_solver=${4}

[[ -d "${1}/${solutionDir}" ]] || mkdir "${1}/${solutionDir}"

for f in ${1}/*.*; do
    base_name=$(basename ${f})
    to_run="$line --solver ${chosen_solver} -t ${timing} "${f}" "${2}" -s --output-mode json --json-stream"
    
    [[ -d "${1}/${solutionDir}/${base_name}" ]] || mkdir "${1}/${solutionDir}/${base_name}"
    for ((i=1;i<=runs;i++)); do 
        target="${1}/${solutionDir}/${base_name}/${base_name}${5}_run${i}.txt"
        if [[ -z ${5} ]]; then
            echo "${to_run} -r ${rnd[${i}-1]} > ${target}"
        else
            echo "${to_run} -f -r ${rnd[${i}-1]} > ${target}"
        fi
        done
done 