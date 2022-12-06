line=$(head -n 1 eprime.txt)
timing=$(head -n 1 timeout.txt)
runs=$(head -n 1 numberOfRuns.txt)
declare -a opt=("O2" "O3")
declare -a symm=("S0" "S1" "S2")
declare -a rnd=("1" "7" "12")

save_location="${1}/${3}"

chosen_solver=$5

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


if [[ $4 == "y" ]]; then
    mv ${save_location}/minion/*.json ${save_location}/symmetry   
fi


function create_directories() {
    [[ -d ${save_location}/timing/infor/${1} ]] || mkdir ${save_location}/timing/infor/${1}
    [[ -d ${save_location}/timing/${1} ]] || mkdir ${save_location}/timing/${1}
}


function create_and_move() {
    [[ -d ${save_location}/solutions/${2} ]] || mkdir ${save_location}/solutions/${2}
    create_directories ${2}
    create_directories ${2}/${3}
    # mv ${1}/${4}*${2}.solution ${save_location}/solutions/${2}
    # mv ${1}/${4}*${2}.info ${save_location}/timing/${2}/${3}
    # mv ${1}/${4}*${2}.infor ${save_location}/timing/infor/${2}/${3}
}


function run_instance() {
    naming="${3}_${4}"
    for f in ${1}/*.param; 
    do
        base_name=$(basename ${f})
        if [[ $5 == "n" ]]; then 
            create_and_move ${1} ${naming} $base_name ${base_name}${6}_${chosen_solver}
            for ((k=1;k<=runs;k++));
            do 
                run_tag=${base_name}${6}_${chosen_solver}_run${k}.${naming}    
                # echo ${line} "$2" "$f" -${3} -${4} -${chosen_solver} -run-solver -out-solution ${f}${6}_${chosen_solver}.${naming}.solution -out-info ${run_tag}.info -out-minion ${run_tag}.minion -out-flatzinc ${run_tag}.fzn  -solver-options \"${solver_options} -r ${rnd[${k}-1]}\"
                echo ${line} "$2" "$f" -${3} -${4} -${chosen_solver} -run-solver \
                -out-solution ${save_location}/solutions/${naming}/${base_name}${6}_${chosen_solver}.${naming}.solution \
                -out-info ${save_location}/timing/${naming}/$base_name/${run_tag}.info \
                -out-minion ${save_location}/minion/${run_tag}.minion \
                -out-flatzinc ${save_location}/fzn/${run_tag}.fzn  \
                -solver-options \"${solver_options} -r ${rnd[${k}-1]}\"
                
            done
        else              
            mv ${save_location}/timing/${naming}/$base_name/${base_name}${6}_${chosen_solver}*${naming}.infor ${save_location}/timing/infor/${naming}/${base_name}
        fi
    done
}

# for i in "${opt[@]}"
# do 
#     for j in "${symm[@]}"
#     do 
#         run_instance $1 $2 $i $j $4
#     done
# done 

run_instance ${1} ${2} "O0" "S0" $4
run_instance ${1} ${2} "O2" "S1" $4
run_instance ${1} ${2} "O2" "S2" $4
# run_instance ${1} ${2} "O3" "S1" $4
run_instance ${1} ${2} "O3" "S2" $4