line=$(head -n 1 constants/eprime.txt)
roster="../eprime_models/roster/rosterGenerator/rosterGenerate.eprime "

for weeks in {12..52..3}
do
    for s_min in {2..3}
    do
        for s_max in {3..4}
        do 
            ${line} ${roster} -params "letting numberOfWeeks=${weeks} letting s_min=${s_min} letting s_max=${s_max}" -chuffed -run-solver -out-solution "${weeks}_${s_min}_${s_max}.solution"
            if [ -f "${weeks}_${s_min}_${s_max}.solution" ]; then 
                ${line} ${roster} -in-param "${weeks}_${s_min}_${s_max}.solution" -param-to-json
                python ../python/jsonTranslator.py "${weeks}_${s_min}_${s_max}.solution.json" ../instances_and_solutions/roster/minizinc/instances "${weeks}_${s_min}_${s_max}"
                mv *.solution ../instances_and_solutions/roster/generatedInstances 
                mv *.json ../instances_and_solutions/roster/generatedInstances/json
            fi
        done 
    done 
done



