line=$(head -n 1 constants/eprime.txt)
# mzn_chuffed=$(head -n 1 constants/eprime_chuffed_path.txt) #TODO fix later
timing=$(head -n 1 constants/timeout.txt)
runs=$(head -n 1 constants/numberOfRuns.txt)
# TODO MOVE THIS OUT
declare -a rnd=("1" "7" "12")

save_location="${1}/${3}"

chosen_solver=${5}

# printf "using ${chosen_solver} \n"

solver_options="-t ${timing} -f"
if [[ -z ${6} ]]; then
    solver_options="-t ${timing}"
fi

[[ -d ${save_location} ]] || mkdir ${save_location}
[[ -d ${save_location}/solutions ]] || mkdir ${save_location}/solutions
[[ -d ${save_location}/symmetry ]] || mkdir ${save_location}/symmetry
[[ -d ${save_location}/timing ]] || mkdir ${save_location}/timing
[[ -d ${save_location}/minion ]] || mkdir ${save_location}/minion
[[ -d ${save_location}/fzn ]] || mkdir ${save_location}/fzn
[[ -d ${save_location}/timing/infor ]] || mkdir ${save_location}/timing/infor

function create_directories() {
    [[ -d ${save_location}/timing/infor/${1} ]] || mkdir ${save_location}/timing/infor/${1}
    [[ -d ${save_location}/timing/${1} ]] || mkdir ${save_location}/timing/${1}
}

function create_and_move() {
    [[ -d ${save_location}/solutions/${2} ]] || mkdir ${save_location}/solutions/${2}
    create_directories ${2}
    create_directories ${2}/${3}
}


function print_eprime_commands() {
    naming="${3}_${4}"
    to_rem="mv ${save_location}/minion/*.json ${save_location}/symmetry"
    for f in ${1}/*.param; 
    do
        base_name=$(basename ${f})
        create_and_move ${1} ${naming} $base_name ${base_name}${6}_${chosen_solver}
        for ((k=1;k<=runs;k++));
        do 
            run_tag=${base_name}${6}_${chosen_solver}_run${k}.${naming}
            # delete all unnecessary files
            if [[ $5 == "y" ]]; then 
                to_rem="rm -rf ${save_location}/minion/${run_tag}.minion; rm -rf ${save_location}/minion/*.json; rm -rf ${save_location}/fzn/${run_tag}.fzn"
            fi    
            printf '%s\n' "${line} $2 $f -${3} -${4} -${chosen_solver} -run-solver \
            -out-solution ${save_location}/solutions/${naming}/${base_name}${6}_${chosen_solver}.${naming}.solution \
            -out-info ${save_location}/timing/${naming}/$base_name/${run_tag}.info \
            -out-minion ${save_location}/minion/${run_tag}.minion \
            -out-flatzinc ${save_location}/fzn/${run_tag}.fzn \
            -solver-options \"${solver_options} -r ${rnd[${k}-1]}\"; \
            # -chuffed-bin ${mzn_chuffed}; \ # give a different bin for chuffed than default
            mv ${save_location}/timing/${naming}/$base_name/${run_tag}.infor ${save_location}/timing/infor/${naming}/${base_name}; \
            ${to_rem}"
        done
    done
}


print_eprime_commands ${1} ${2} "O0" "S0" $4
print_eprime_commands ${1} ${2} "O2" "S1" $4
# print_eprime_commands ${1} ${2} "O2" "S2" $4
print_eprime_commands ${1} ${2} "O3" "S2" $4
