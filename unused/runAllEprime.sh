line=$(head -n 1 eprime.txt)
timing=$(head -n 1 timeout.txt)
runs=$(head -n 1 numberOfRuns.txt)
declare -a opt=("O2" "O3")
declare -a symm=("S0" "S1" "S2")

save_location="${1}/${3}"

chosen_solver="gecode"

if [[ -z ${4} ]]; then 
    chosen_solver="chuffed"
fi 

printf "using ${chosen_solver} \n"

solver_options="-t ${timing} -f"
if [[ -z ${5} ]]; then
    solver_options="-t ${timing}"
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
    [[ -d ${save_location}/timing/infor/${1} ]] || mkdir ${save_location}/timing/infor/${1}
    [[ -d ${save_location}/timing/${1} ]] || mkdir ${save_location}/timing/${1}
}


function create_and_move() {
    mv ${1}/*.fzn ${save_location}/fzn
    mv ${1}/*.minion ${save_location}/minion
    [[ -d ${save_location}/solutions/${2} ]] || mkdir ${save_location}/solutions/${2}
    create_directories ${2}
    create_directories ${2}/${3}
    mv ${1}/*${2}*.solution ${save_location}/solutions/${2}
    mv ${1}/*${2}*.info ${save_location}/timing/${2}/${3}
    mv ${1}/*${2}*.infor ${save_location}/timing/infor/${2}/${3}
}


function run_instance() {
    naming="${3}_${4}"
    for f in ${1}/*.param; 
    do
        base_name=$(basename ${f})
        for ((k=1;k<=runs;k++));
        do 
            ${line} "$2" "$f" -${3} -${4} -${chosen_solver} -run-solver -out-solution "${f}.${naming}.solution" -out-info "${f}_run${k}.${naming}.info" -solver-options "${solver_options}"
            create_and_move ${1} ${naming} $base_name
        done
    done
}

for i in "${opt[@]}"
do 
    for j in "${symm[@]}"
    do 
        run_instance $1 $2 $i $j
        if [[ j=="S2" ]]; then 
            mv ${1}/*.json ${save_location}/symmetry
        fi 
    done
done 

run_instance ${1} ${2} "O0" "S0"

# for f in ${1}/*.param; 
# do
     
#     ${line} "$2" "$f" -O0 -S0 -chuffed -run-solver -out-solution "${f}.O0_S0.solution" -out-info "${f}.O0_S0.info" -solver-options "-t ${timing}"
#     create_and_move "${1}" "O0_S0"
# done 