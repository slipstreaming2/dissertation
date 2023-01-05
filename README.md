# dissertation

# Installation
In order to generate new data, both Savile Row and MiniZinc need to be downloaded. The version used to generate this data was 1.9.1 for Savile Row, 2.6.4 x86_64 for MiniZinc. 

The Savile Row Linux bundle can be downloaded from:
[https://savilerow.cs.st-andrews.ac.uk/releases.html](https://savilerow.cs.st-andrews.ac.uk/releases.html)

The MiniZinc bundle can be downloaded from:
[https://www.minizinc.org/software.html](https://www.minizinc.org/software.html)

Place both directories one above this, or alternatively modify the constant path to the executables in bash\constants\eprime.txt and bash\constants\minizinc.txt respectively. 

# Folder Structure
# bash
Contains all of the python scripts and bash files used for the experiments.

### constants
 - eprime.txt 
  The relative path location of the savilerow executable
 - minizinc.txt
  The relative path location of the minizinc executable
 - numberOfRuns.txt
  The number of runs to perform for the experiments
 - timeout.txt
  The timeout to impose upon the solvers

### checkAllSolutions.py
 - checks all solutions and objective intermediate solutions
 
to run: `python checkAllSolutions.py`

### checkEprimeSolutions.sh
 - bash script to check all eprime solutions of based off of param and solution path passed in
 
to run: `.\checkEprimeSolutions.sh <eprime_param_path> <solution_path>`

example: `.\checkEprimeSolutions.sh ..\instances_and_solutions\wordpress\eprime\param ..\instances_and_solutions\wordpress\eprime\noFree_chuffed\solutions`

### checkMiniZincSolutions.sh
 - bash script to check all minizinc solutions based off of ESSENCE' PARAM path and solution path passed in

to run: `.\checkMiniZincSolutions.sh <eprime_param_path> <solution_path>`

example: `.\checkMiniZincSolutions.sh ..\instances_and_solutions\roster\eprime\param ..\instances_and_solutions\roster\minizinc\noFree_chuffed`

### generateCommands.py
 - script to print out all commands to run for the experiments
 - for the experiments the output was piped into a file, such as experiments.txt, to then feed into GNU parallel
 
 to run: `python generateCommands.py`
 
 example: `python generateCommands.py > experiments.txt`
 
 example: `parallel -j 16 < experiments.txt`
 
 The -j restricts the number of cores used to 16, change this number as you like.

### generateEprimeOptCommands.sh
 - script to print Essence' CVRPTW and TTPPV intermediate objective solutions
 - this script is usually piped into a .txt file to then use with GNU parallel
 - runs the respective eprime flatzinc geneated file with a solver (Chuffed)
 - NOTE the flatzinc files MUST exist before this command is run, this is assuming this script file is run after normal timing experiments have concluded
 
 to run: `.\generateEprimeOptCommands.sh <solver_executable_location> <txt_file_save_location> <flag -f|>`
 
 example: `.\generateEprimeOptCommands.sh ..\..\savilerow-1.9.1-linux\bin\fzn-chuffed ..\instances_and_solutions\cvrptw\eprime\noFree_chuffed`

### generateMinizincCommands.sh
 - script to print minizinc experiment commands
 - usually this script is piped into a text file then run with GNU parallel

to run: `.\generateMinizincCommands.sh <path_to_minizinc_instance_folder> <path_to_minizinc_model> <path_to_save_under_relative_to_instance_folder> <solver> <-f|>`

example: `.\generateMinizincCommands.sh ..\instances_and_solutions\tournament\minizinc\instances ..\miniZinc_files\tournament\tournament.mzn ..\free_chuffed chuffed -f`

Above example runs with free flag

### generateRoster.sh
 - script to generate and create eprime and minizinc instance files plus directories for the rostering problem

to run: `.\generateRoster.sh`

### genMiniZincObjectiveComms.sh
 - prints objective experiment commands to time intermediate solutions from CVRPTW and TTPPV (tournament)
 
to run: `.\genMiniZincObjectiveComms.sh <path_to_minizinc_instance_folder> <path_to_minizinc_model> <path_to_save_under_relative_to_instance_folder> <solver> <flag -f|>`

example: `.\genMiniZincObjectiveComms.sh ..\instances_and_solutions\tournament\minizinc\instances ..\miniZinc_files\tournament\tournament.mzn ..\noFree_chuffed chuffed`

Above example does not run with free flag

### genObjectiveComms.py
 - script to print out objective commands for minizinc and eprime for CVPRTW and TTPPV
 - used to pipe commands into a file to then pipe into GNU parallel to run

to run: `python genObjectiveComms.py`

### runAllEprimeCommands.sh
 - prints all eprime experiment commands for passed in param folder

to run: `.\runAllEprimeCommands.sh <path_to_param_folder> <path_to_eprime_model> <save_path_relative_to_param_folder> <y|n to remove fzn and minion files> <solver> <flag -f|>`

example: `.\runAllEprimeCommands.sh ..\instances_and_solutions\wordpress\eprime\param ..\eprime_models\wordpressNoSymm\wordpressNoSymm.eprime ..\..\..\wordpressNoSymm\param\noFree_chuffed y chuffed`

### timingObjective.py
 - python file to read in output of eprime intermediate solutions and print timing
 - outputs are piped into this program

to run: `python timingObjective.py`

example: `fzn-chuffed -a -v example.fzn | python timingObjective.py`

### translateAll.sh
 - translates all passed in minzinc dzn or json files into param files in same problem directory
 - if the minizinc file has sets, expect a json string in the second argument giving the occurrence sizes of the sets from the parameter file 

to run: `.\translateAll.sh <path_to_minizinc_instance> <optional_json_for_occurrence_translation>`

example: `.\translateAll.sh ..\instances_and_solutions\wordpress\minizinc\instances`

example: `.\translateAll.sh ..\instances_and_solutions\mspsp\minizinc\instances  "{\"has_skills\": \"n_skills\", \"suc\": \"n_tasks\"}"`

In the above example, n_skills gives the size of the occurrence representation of the set for has_skills

# eprime_models
All of the Essence' (Eprime) models and generators used for the experiments  

# instances_and_solutions
For each respective problem, it contains the Essence' and MiniZinc timings, solutions, and instances.

This is broken down as:
```
problem_name
    |
    --- eprime
        |
        --- `<noFree|free>_<chuffed>`
            |
            --- solutions
                |
                ---optimisation `<O(0|2|3)_S(0|1|2)>`
                    |
                    ---`<instance_name>_<solver>.<O(0|2|3)_S(0|1|2)>.solution`
            --- timings
                |
                ---instance_name
                    |
                    ---`<instance_name>_<solver>_run<1|2|3>.<O(0|2|3)_S(0|1|2)>.info`
        |
        --- param
            |
            ---`<instance_name>`
    |
    --- minizinc
        |
        ---<noFree|free>_<chuffed>
            |
            ---instance_name
                |
                ---<instance_name>_<free|noFree>_run<1|2|3>.txt
        |
        ---instances
            |
            ---<instance_name>
```

# miniZinc_files
Contains all of the respective MiniZinc models for the problems and generators for instances using a MiniZinc model

# python
All of the graphing, translating, and generator Python files

### graphs
 - png images of graphs used in paper

### checkSolutions.py
 - checks the respective solutions of each problem against the model constraints written in Python

To run:
`python checkSolutions.py <path_to_essence'_parameter_file> <path_to_solution_file> <minizinc | "">`

NOTE the parameter file MUST be a essence' .param file, even when checking MiniZinc solutions

Example:
`python checkSolutions.py ..\instances_and_solutions\tournament\param\circ8abal.dzn.param ..\instances_and_solutions\tournament\minizinc\noFree_chuffed\circ8abal.dzn\circ8abal.dzn_run1.txt minizinc`

The above example checks the MiniZinc solution

Example:
`python checkSolutions.py ..\instances_and_solutions\tournament\param\circ8abal.dzn.param ..\instances_and_solutions\tournament\eprime\noFree_chuffed\solutions\O0_S0\circ8abal.dzn.param_chuffed.O0_S0.solution`

The above example checks the Eprime solution

### eprime_data.json
 - exported eprime data to use in objective graphs, used to add initialisation times to objective graphs for eprime

### graphing.ipynb
- Jupyter notebook of all non-objective related graphs, including solver-vs-solver, cactus, and bar graphs
- includes calculations for significance intervals

### jsonTranslator.py
- translates JSON files into Essence' param files.

To run:
`python jsonTranslator.py <minizinc_json_file_path> <eprime_save_location_path>`

Example:
`python jsonTranslator.py ..\instances_and_solutions\cvrptw\json\A_7v_48l.json ..\instances_and_solutions\cvrptw\param`

Translates Roster generated JSON files into MiniZinc instance files

To run:
`python jsonTranslator.py <minizinc_json_file_path> <eprime_save_location_path>`

Example:
`python jsonTranslator.py "${weeks}_${s_min}_${s_max}.solution.json" ..\instances_and_solutions\roster\minizinc\instances "${weeks}_${s_min}_${s_max}"`


### objectiveGraphs.ipynb
- Juptyer notebook of all objective graphs for CVRPTW and Tournament (TTPPV)

### quasigroupGenerator.py
- creates random quasigroup instances of size N from the variable N in the file

To run:
`python quasigroupGenerator.py`

### rosterGenerator.py
- creates random roster shift requirements as described by the [CSPLib](https://www.csplib.org/Problems/prob087/data/)

### translator.py
- translates inputted MiniZinc dzn file into a Essence' param file, including translating sets into an occurrence representation

To run:
`python translator.py <mzn_file_path_to_translate> <eprime_directory_to_save_into>`

Example:
`python translator.py ..\instances_and_solutions\quasigroup\minizinc\instances\qwh-o30-h374-01.dzn ..\instances_and_solutions\quasigroup\eprime\param`

If converting a MiniZinc file with sets, a third argument in JSON format gives the variable with the set reprepsentation mapped to the variable in the parameter file of the size of the set. In the below example, n_skills gives the size of the occurrence representation of the set

Example:
`python translator.py ..\instances_and_solutions\mspsp\easy_01.dzn ..\instances_and_solutions\mspsp\eprime\param "{\"has_skills\": \"n_skills\", \"suc\": \"n_tasks\"}"`