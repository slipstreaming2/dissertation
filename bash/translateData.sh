[[ -d ../data/${2} ]] || mkdir ../data/${2}
[[ -d ../data/${2}/${3} ]] || mkdir ../data/${2}/${3}
declare -a opt=("O2" "O3")
declare -a symm=("S0" "S1")

save_type=".info"
if [[ "${3}" == "minizinc" ]];
then 
    save_type=".txt"
    [[ -d ${1}/json ]] || mkdir ${1}/json
    for f in ${1}/*${save_type}; do
        base_name=$(basename ${f})
        python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/${base_name} ${3}
    done 
else 
    for i in "${opt[@]}"
    do 
        for j in "${symm[@]}"
        do 
            [[ -d ../data/${2}/${3}/"${i}_${j}" ]] || mkdir ../data/${2}/${3}/"${i}_${j}"
        done
    done 
    [[ -d ../data/${2}/${3}/"O0_S0" ]] || mkdir ../data/${2}/${3}/"O0_S0"
fi

if [[ ${3} == "eprime" ]]
then 
    for i in "${opt[@]}"
    do 
        for j in "${symm[@]}"
        do 
            for f in ${1}/"${i}_${j}"/*${save_type}; 
            do
                base_name=$(basename ${f})
                python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/"${i}_${j}"/${base_name} ${3}
            done 
        done
    done 
    for f in ${1}/"O0_S0"/*${save_type}; 
    do
        base_name=$(basename ${f})
        python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/"O0_S0"/${base_name} ${3}
    done 
fi

#  for f in ${1}/cse/*${save_type}; do
#         base_name=$(basename ${f})
#         python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/cse/${base_name} ${3}
#     done 