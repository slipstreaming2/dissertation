[[ -d ../data/${2} ]] || mkdir ../data/${2}
[[ -d ../data/${2}/${3} ]] || mkdir ../data/${2}/${3}
declare -a opt=("O2" "O3")
declare -a symm=("S0" "S1" "S2")

save_type=".info"

function convert_eprime() {
    [[ -d ../data/${2}/${3}/"${4}_${5}" ]] || mkdir ../data/${2}/${3}/"${4}_${5}"
    for path in ${1}/"${i}_${j}"/*; 
    do
        [ -d "${path}" ] || continue # if not a directory, skip
        dirname="$(basename "${path}")"
        dir_to_save="../data/${2}/${3}/"${4}_${5}"/${dirname}"
        [[ -d $dir_to_save ]] || mkdir $dir_to_save
        for f in $path/*${save_type};
        do 
            base_name=$(basename ${f})
            python ../python/jsonGenerator.py ${f} ${dir_to_save}/${base_name} ${3}
        done
    done 
}

if [[ "${3}" == "minizinc" ]];
then 
    save_type=".txt"
    [[ -d $1/json ]] || mkdir $1/json
    for path in ${1}/*; 
    do
        [ -d "${path}" ] || continue # if not a directory, skip
        dirname="$(basename "${path}")"
        [ "$dirname" == "json" ] && continue # skip json directory
        dir_to_save="../data/${2}/${3}/${dirname}"
        dir_json="$1/json/$dirname"
        [[ -d $dir_to_save ]] || mkdir $dir_to_save
        [[ -d $dir_json ]] || mkdir $dir_json
        for f in $path/*${save_type};
        do 
            base_name=$(basename ${f})
            python ../python/jsonGenerator.py ${f} ${dir_to_save}/${base_name} ${3} $dir_json
        done
    done 
else 
    for i in "${opt[@]}"
    do 
        for j in "${symm[@]}"
        do 
            convert_eprime $1 $2 $3 $i $j
        done
    done 
    
    convert_eprime $1 $2 $3 "O0" "S0"
    # [[ -d ../data/${2}/${3}/"O0_S0" ]] || mkdir ../data/${2}/${3}/"O0_S0"

    # for f in ${1}/"O0_S0"/*${save_type}; 
    # do
    #     base_name=$(basename ${f})
    #     python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/"O0_S0"/${base_name} ${3}
    # done 
fi

# if [[ ${3} == "eprime" ]]
# then 
#     for i in "${opt[@]}"
#     do 
#         for j in "${symm[@]}"
#         do 
#             for f in ${1}/"${i}_${j}"/*${save_type}; 
#             do
#                 base_name=$(basename ${f})
#                 python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/"${i}_${j}"/${base_name} ${3}
#             done 
#         done
#     done 
# fi

#  for f in ${1}/cse/*${save_type}; do
#         base_name=$(basename ${f})
#         python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/cse/${base_name} ${3}
#     done 