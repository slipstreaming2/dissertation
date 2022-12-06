[[ -d ../data/${4} ]] || mkdir ../data/${4}
[[ -d ../data/${4}/${3} ]] || mkdir ../data/${4}/${3}
[[ -d ../data/${2} ]] || mkdir ../data/${2}
# declare -a opt=("O2" "O3")
# declare -a symm=("S0" "S1" "S2")

save_type=".info"
function convert_eprime() {
    [[ -d ../data/${2}/"${4}_${5}" ]] || mkdir ../data/${2}/"${4}_${5}"
    echo ${1}/"${4}_${5}"
    for path in ${1}/"${4}_${5}"/*; 
    do
        [ -d "${path}" ] || continue # if not a directory, skip
        dirname="$(basename "${path}")"
        dir_to_save="../data/${2}/${4}_${5}/${dirname}"
        [[ -d $dir_to_save ]] || mkdir $dir_to_save
        for f in $path/*${save_type};
        do 
            base_name=$(basename ${f})
            echo "yo"
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
        dir_to_save="../data/${2}/${dirname}"
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
    # for i in "${opt[@]}"
    # do 
    #     for j in "${symm[@]}"
    #     do 
    #         convert_eprime $1 $2 $3 $i $j
    #     done
    # done 
    
    convert_eprime $1 $2 $3 "O0" "S0"
    convert_eprime $1 $2 $3 "O2" "S1"
    convert_eprime $1 $2 $3 "O2" "S2"
    convert_eprime $1 $2 $3 "O3" "S2"
    # convert_eprime $1 $2 $3 "O3" "S1"
fi