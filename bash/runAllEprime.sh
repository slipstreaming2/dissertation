line=$(head -n 1 eprime.txt)
for f in ${1}/*.param; do
    ${line} "$2" "$f" -chuffed -run-solver
done 