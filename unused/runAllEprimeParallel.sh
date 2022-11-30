line=$(head -n 1 eprime.txt)
timing=$(head -n 1 timeout.txt)
runs=$(head -n 1 numberOfRuns.txt)
declare -a opt=("O0" "O2" "O3")
declare -a symm=("S0" "S1" "S2")

save_location="${1}/${3}"

chosen_solver="gecode"

if [[ -z ${4} ]]; then 
    chosen_solver="chuffed"
fi 

printf "using ${chosen_solver} \n"

is_using_free=1
solver_options="-t ${timing} -f"
if [[ -z ${5} ]]; then
    is_using_free=0
    # solver_options="-t ${timing}"
fi

# if [[ -z ${3} ]]; then
#     save_location="${1}/.."
# fi

[[ -d ${save_location} ]] || mkdir ${save_location}
[[ -d ${save_location}/solutions ]] || mkdir ${save_location}/solutions
[[ -d ${save_location}/symmetry ]] || mkdir ${save_location}/symmetry
[[ -d ${save_location}/timing ]] || mkdir ${save_location}/timing
[[ -d ${save_location}/minion ]] || mkdir ${save_location}/minion
[[ -d ${save_location}/fzn ]] || mkdir ${save_location}/fzn
[[ -d ${save_location}/timing/infor ]] || mkdir ${save_location}/timing/infor


function create_directories() {
    [[ -d ${2}/timing/infor/${1} ]] || mkdir ${2}/timing/infor/${1}
    [[ -d ${2}/timing/${1} ]] || mkdir ${2}/timing/${1}
}

export -f create_directories


function create_and_move() {
    base_name=$(basename ${3})
    [[ -d ${4}/solutions/${2} ]] || mkdir ${4}/solutions/${2}
    create_directories ${2} $4
    create_directories ${2}/${base_name} $4
    mv ${1}/$base_name*.${2}.solution ${4}/solutions/${2}
    mv ${1}/$base_name*.${2}.info ${4}/timing/${2}/${base_name}
    mv ${1}/$base_name*.${2}.infor ${4}/timing/infor/${2}/${base_name}
}

export -f create_and_move


function run_parallel_instance_eprime() {
    solver_options="-t ${7} -f" 
    if [[ ${8} == 0 ]]; then
        solver_options="-t ${7}"
    fi
    run_tag=${4}_run${6}.${3}
    # printf "$1 -out-info ${4}_run${6}.${3}.info -solver-options ${solver_options}"
    $1 -out-info ${run_tag}.info -out-flatzinc ${run_tag}.fzn -out-minion ${run_tag}.minion -solver-options "${solver_options}"
    create_and_move ${2} ${3} ${4} ${5}
}

export -f run_parallel_instance_eprime

function run_parallel() {
    # printf "at parallel ${7} $2 $6 -${3} -${4} -${9} -run-solver -out-solution ${6}.${5}.solution -out-flatzinc ${6}.${5}.fzn -out-minion ${6}.${5}.minion/n/n"
    # base_name=${6}
    partial_run="${7} $2 $6 -${3} -${4} -${9} -run-solver -out-solution ${6}.${5}.solution"
    # printf "$partial_run"
    seq 1 $8 | parallel -q run_parallel_instance_eprime "$partial_run" $1 $5 $6 ${10} {} ${11} ${12}
}
export -f run_parallel

function run_instance() {
    if [ "${9}" == "O0" ] && [ "${10}" != "S0" ]; then 
        return
    else
        naming="${9}_${10}"
        ls -d ${1}/*.param | parallel run_parallel ${1} $2 $9 ${10} $naming {} $3 $4 $5 $6 $7 $8
    fi 
}






# function run_parallel() {
#     # printf "${7} "$2" "$6" -${3} -${4} -${9} -run-solver -out-solution "${6}.${5}.solution" -out-info "${6}_run${k}.${5}.info" -solver-options "$11 $12 $13" \n"
#     # base_name=${6}
#     solver_options="-t ${11} -f"
#     if [[ ${12} == 0 ]]; then
#         solver_options="-t ${11}"
#     fi

#     for ((k=1;k<=$8;k++));
#     do 
#         ${7} "$2" "$6" -${3} -${4} -${9} -run-solver -out-solution "${6}.${5}.solution" -out-info "${6}_run${k}.${5}.info" -solver-options "${solver_options}" -out-flatzinc "${6}.${5}.fzn" -out-minion "${6}.${5}.minion"
#         create_and_move ${1} ${5} ${6} ${10}
#     done
# }
# export -f run_parallel

# function run_instance() {
#     naming="${9}_${10}"
#     ls -d ${1}/*.param | parallel run_parallel ${1} $2 $9 ${10} $naming {} $3 $4 $5 $6 $7 $8
# }

export -f run_instance

parallel run_instance $1 $2 $line $runs $chosen_solver $save_location $timing $is_using_free ::: "${opt[@]}" ::: "${symm[@]}" 


# for i in "${opt[@]}"
# do 
#     for j in "${symm[@]}"
#     do 
#         run_instance $1 $2 $i $j
#         if [[ j=="S2" ]]; then 
#             
#         fi 
#     done
# done 

# run_instance $1 $2 $line $runs $chosen_solver $save_location $timing $is_using_free "O0" "S0"

mv ${1}/*.fzn ${save_location}/fzn 
mv ${1}/*.minion ${save_location}/minion
mv ${1}/*.json ${save_location}/symmetry

# for f in ${1}/*.param; 
# do
     
#     ${line} "$2" "$f" -O0 -S0 -chuffed -run-solver -out-solution "${f}.O0_S0.solution" -out-info "${f}.O0_S0.info" -solver-options "-t ${timing}"
#     create_and_move "${1}" "O0_S0"
# done 