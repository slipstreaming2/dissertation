for f in ${1}/*.param; do 
    for js in ${2}/*.json; do 
        base_name=$(basename ${js})
        f_base_name=$(basename ${f})
        b=${f_base_name%.param*} 
        a=${base_name%.txt.json*} 
        if [ $b == $a ];
        then
            python ../python/checkSolutions.py "$f" "$js" minizinc
            break
        fi
    done
done