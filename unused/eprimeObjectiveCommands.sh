# line=$(head -n 1 constants/eprime.txt)
# timing=$(head -n 1 constants/timeout.txt)
# runs=$(head -n 1 constants/numberOfRuns.txt)
line=$(head -n 1 eprime.txt)
timing=$(head -n 1 timeout.txt)
runs=$(head -n 1 numberOfRuns.txt)
declare -a opt=("O2" "O3")
declare -a symm=("S0" "S1" "S2")
declare -a rnd=("1" "7" "12")

save_location="${1}"

chosen_solver=$3

solver_options="-t ${timing} -a -v -f"

[[ -d ${save_location}/objective ]] || mkdir ${save_location}/objective

function run_instance() {
    naming="${3}_${4}"
    [[ -d ${save_location}/objective/${naming} ]] || mkdir ${save_location}/objective/${naming}
    for f in ${save_location}/../param/*.param; 
    do
        base_name=$(basename ${f})
        [[ -d ${save_location}/objective/${naming}/$base_name ]] || mkdir ${save_location}/objective/${naming}/$base_name
        for ((k=1;k<=runs;k++));
        do 
            run_tag=${base_name}_${chosen_solver}_run${k}.${naming}  
            printf '%s\n' "${line} $2 $f -${3} -${4} -${chosen_solver} -run-solver \
            -solutions-to-stdout \
            -out-info ${run_tag}.info \
            -out-minion ${run_tag}.minion \
            -out-flatzinc ${run_tag}.fzn \
            -solver-options \"${solver_options} -r ${rnd[${k}-1]}\" \
            | python timingObjective.py > ${save_location}/objective/${naming}/${base_name}/${run_tag}.txt; \
            rm -f *.minion *.fzn *.info *.infor *.json"
        done
    done
}

run_instance ${1} ${2} "O0" "S0" 
run_instance ${1} ${2} "O2" "S1"
run_instance ${1} ${2} "O2" "S2"
# run_instance ${1} ${2} "O3" "S1"
run_instance ${1} ${2} "O3" "S2"