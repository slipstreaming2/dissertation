line=$(head -n 1 constants/minizinc.txt)
timing=$(head -n 1 constants/timeout.txt)
runs=$(head -n 1 constants/numberOfRuns.txt)
declare -a rnd=("1" "7" "12")

objectiveDir=${3}
model=${2}

chosen_solver=${4}

[[ -d "${1}/../objective" ]] || mkdir "${1}/../objective"
# [[ -d "${1}/../noStdLib" ]] || mkdir "${1}/../noStdLib"
[[ -d "${1}/${objectiveDir}" ]] || mkdir "${1}/${objectiveDir}"


for f in ${1}/*.*; do
    base_name=$(basename ${f})
    to_run="$line --solver ${chosen_solver} -i -s --output-time -t ${timing} ${f} ${model}"
    # to_run="$line --solver ${chosen_solver} -s --output-mode json --json-stream -t ${timing} ${f} ${model}"
    [[ -d "${1}/${objectiveDir}/${base_name}" ]] || mkdir "${1}/${objectiveDir}/${base_name}"

    for ((i=1;i<=runs;i++)); do 
        target="${1}/${objectiveDir}/${base_name}/${base_name}${5}_run${i}.txt"
        echo "${to_run} -r ${rnd[${i}-1]} $5 > ${target}"
    done
done 