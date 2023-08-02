line=$(head -n 1 constants/minizinc.txt)
timing=$(head -n 1 constants/timeout.txt)
runs=$(head -n 1 constants/numberOfRuns.txt)
declare -a optimisations=("O0" "O1" "O5")
declare -a rnd=("1" "7" "12")

solutionDir=${1}/${3}

chosen_solver=${4}

using_free_flag=${5}

function create() {
    [[ -d ${1} ]] || mkdir ${1}
}

create ${solutionDir}


function print_mzn_command() {
    optimize_level=${3}
    create ${solutionDir}/${optimize_level}
    # param files
    for f in ${1}/*.*; do
        base_name=$(basename ${f})
        to_run="$line --solver ${chosen_solver} -t ${timing} "${f}" "${2}" -s --output-mode json --json-stream"
        create ${solutionDir}/${optimize_level}/${base_name}
        for ((i=1;i<=runs;i++)); do 
            target=${solutionDir}/${optimize_level}/${base_name}/${base_name}_${optimize_level}${5}_run${i}.txt
            # empty flag, no free flag
            if [[ -z ${4} ]]; then
                echo "${to_run} -${optimize_level} -r ${rnd[${i}-1]} > ${target}"
            else
                echo "${to_run} -f -${optimize_level} -r ${rnd[${i}-1]} > ${target}"
            fi
            done
    done 
}

for opt in "${optimisations[@]}"
do 
    print_mzn_command ${1} ${2} ${opt} ${using_free_flag}
done
