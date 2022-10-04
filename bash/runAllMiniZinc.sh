line=$(head -n 1 minizinc.txt)
for f in ${1}/*.dzn; do
    base_name=$(basename ${f})
    $line --solver chuffed  "${f}" "${2}" -s --output-mode json --json-stream > ${1}/solutions/${base_name}.txt
done 