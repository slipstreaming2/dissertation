save_type=".dzn"
if [[ ${1} == *"json"* ]];
then 
    save_type=".json"
fi

eprimeSave="${1}/../param/param"

for f in ${1}/*${save_type}; do
    if [ ${save_type} == ".json" ]
    then 
        python ../python/jsonTranslator.py "$f" "$eprimeSave"
    else
        if [ $# -eq 1 ];
        then 
            python ../python/translator.py "$f" "$eprimeSave"
        else
            python ../python/translator.py "$f" "$eprimeSave" "${2}"
        fi
    fi
done