timing=$(head -n 1 constants/timeout.txt)
runs=$(head -n 1 constants/numberOfRuns.txt)
declare -a rnd=("1" "7" "12")

solver_location=${1}
save_location=${2}

solver_options=${3}

[[ -d ${save_location}/objective ]] || mkdir ${save_location}/objective

function run_instance() {
    naming="${2}_${3}"
    [[ -d ${save_location}/objective/${naming} ]] || mkdir ${save_location}/objective/${naming}
    for f in ${save_location}/fzn/*run1*${naming}*.fzn; 
    do
        base_name=$(basename ${f})
        [[ -d ${save_location}/objective/${naming}/${base_name} ]] || mkdir ${save_location}/objective/${naming}/${base_name}
        for ((k=1;k<=runs;k++));
        do 
            run_tag=${base_name}${solver_options}_run${k}.txt    
            echo "${solver_location} ${solver_options} -a -f -v -r ${rnd[${k}-1]} -t ${timing} $f | python timingObjective.py > ${save_location}/objective/${naming}/${base_name}/${run_tag}"
        done
    done
}

run_instance ${2} "O0" "S0" 
run_instance ${2} "O2" "S1" 
run_instance ${2} "O2" "S2" 
run_instance ${2} "O3" "S2" 