line=$(head -n 1 minizinc.txt)
timing=$(head -n 1 timeout.txt)
runs=$(head -n 1 numberOfRuns.txt)

solutionDir=${3}

chosen_solver=${4}

printf "using ${chosen_solver} \n"

[[ -d "${1}/${solutionDir}" ]] || mkdir "${1}/${solutionDir}"

function run_iteration() {
    to_run=$1
    target=${2}${3}.txt
    
    if [[ -z ${4} ]]; then
        ${to_run} > ${target}
    else
        ${to_run} -f > ${target}
    fi
}

export -f run_iteration


function run_parallel_instance() {
    base_name=$(basename ${8})
    printf "${base_name} \n"

    to_run="$5 --solver ${4} -t ${6} ${8} ${2} -s --output-mode json --json-stream"
    [[ -d "${1}/${3}/${base_name}" ]] || mkdir "${1}/${3}/${base_name}"

    target_partial="${1}/${3}/${base_name}/${base_name}_run"

    seq 1 $7 | parallel -q run_iteration "$to_run" $target_partial {} $9
}

export -f run_parallel_instance

ls -d ${1}/*.* | parallel run_parallel_instance ${1} ${2} $solutionDir $chosen_solver $line $timing $runs {} $5