# line=$(head -n 1 eprime.txt)
# timing=$(head -n 1 timeout.txt)
# flags = -chuffed -run-solver -solver-options -t ${timing}

# for f in ${1}/*.param; do
#     ${line} "$2" "$f" -chuffed -run-solver -out-solution "${f}.cse.solution" -out-info "${f}.cse.info" -active-ac-cse -solver-options "-t ${timing}"
#     ${line} "$2" "$f" -chuffed -run-solver -solver-options "-t ${timing}"
# done 



# [[ -d ${1}/../solutions ]] || mkdir ${1}/../solutions
# [[ -d ${1}/../solutions/cse ]] || mkdir ${1}/../solutions/cse
# [[ -d ${1}/../timing ]] || mkdir ${1}/../timing
# [[ -d ${1}/../timing/infor ]] || mkdir ${1}/../timing/infor
# [[ -d ${1}/../timing/cse ]] || mkdir ${1}/../timing/cse
# [[ -d ${1}/../minion ]] || mkdir ${1}/../minion
# [[ -d ${1}/../fzn ]] || mkdir ${1}/../fzn

# mv ${1}/*cse.solution ${1}/../solutions/cse
# mv ${1}/*.solution ${1}/../solutions
# mv ${1}/*cse.info ${1}/../timing/cse
# mv ${1}/*.info ${1}/../timing
# mv ${1}/*.infor ${1}/../timing/infor
# mv ${1}/*.minion ${1}/../minion
# mv ${1}/*.fzn ${1}/../fzn

line=$(head -n 1 eprime.txt)
timing=$(head -n 1 timeout.txt)
declare -a opt=("O2" "O3")
declare -a symm=("S0" "S1")

[[ -d ${1}/../solutions ]] || mkdir ${1}/../solutions
[[ -d ${1}/../timing ]] || mkdir ${1}/../timing
[[ -d ${1}/../minion ]] || mkdir ${1}/../minion
[[ -d ${1}/../fzn ]] || mkdir ${1}/../fzn
[[ -d ${1}/../timing/infor ]] || mkdir ${1}/../timing/infor

function create_and_move() {
    mv ${1}/*.fzn ${1}/../fzn
    mv ${1}/*.minion ${1}/../minion
    [[ -d ${1}/../solutions/${2} ]] || mkdir ${1}/../solutions/${2}
    [[ -d ${1}/../timing/infor/${2} ]] || mkdir ${1}/../timing/infor/${2}
    [[ -d ${1}/../timing/${2} ]] || mkdir ${1}/../timing/${2}
    mv ${1}/*${2}.solution ${1}/../solutions/${2}
    mv ${1}/*${2}.info ${1}/../timing/${2}
    mv ${1}/*${2}.infor ${1}/../timing/infor/${2}
}

for i in "${opt[@]}"
do 
    for j in "${symm[@]}"
    do 
        for f in ${1}/*.param; 
        do
            ${line} "$2" "$f" -${i} -${j} -chuffed -run-solver -out-solution "${f}.${i}_${j}.solution" -out-info "${f}.${i}_${j}.info" -solver-options "-t ${timing}"
            create_and_move "${1}" "${i}_${j}"
        done
        
    done
done 

for f in ${1}/*.param; 
do
    ${line} "$2" "$f" -O0 -S0 -chuffed -run-solver -out-solution "${f}.O0_S0.solution" -out-info "${f}.O0_S0.info" -solver-options "-t ${timing}"
    create_and_move "${1}" "O0_S0"
done 