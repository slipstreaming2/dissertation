line=$(head -n 1 minizinc.txt)
timing=$(head -n 1 timeout.txt)

[[ -d "${1}/solutions" ]] || mkdir "${1}/solutions"

for f in ${1}/*.*; do
    base_name=$(basename ${f})
    printf "${base_name} \n"
    $line --solver chuffed -t ${timing} "${f}" "${2}" -s --output-mode json --json-stream > ${1}/solutions/${base_name}.txt
done 