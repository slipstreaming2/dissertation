line=$(head -n 1 eprime.txt)
for f in ${1}/*.param; do
    ${line} "$2" "$f" -chuffed -run-solver -out-solution "${f}.cse.solution" -out-info "${f}.cse.info" -active-ac-cse
    ${line} "$2" "$f" -chuffed -run-solver
done 



[[ -d ${1}/../solutions ]] || mkdir ${1}/../solutions
[[ -d ${1}/../solutions/cse ]] || mkdir ${1}/../solutions/cse
[[ -d ${1}/../timing ]] || mkdir ${1}/../timing
[[ -d ${1}/../timing/cse ]] || mkdir ${1}/../timing/cse
[[ -d ${1}/../minion ]] || mkdir ${1}/../minion
[[ -d ${1}/../fzn ]] || mkdir ${1}/../fzn

mv ${1}/*cse.solution ${1}/../solutions/cse
mv ${1}/*.solution ${1}/../solutions
mv ${1}/*cse.info ${1}/../timing/cse
mv ${1}/*.info ${1}/*.infor ${1}/../timing
mv ${1}/*.minion ${1}/../minion
mv ${1}/*.fzn ${1}/../fzn