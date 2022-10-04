save_type=".info"
if [ ${3} == "minizinc" ];
then 
    save_type=".txt"
fi
for f in ${1}/*${save_type}; do
    base_name=$(basename ${f})
    python ../python/jsonGenerator.py ${f} ../data/${2}/${3}/${base_name} ${3}
done 