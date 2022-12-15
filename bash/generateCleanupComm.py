import os

problemList = ["cvrptw", "mspsp", "quasigroup", "roster", "tournament", "wordpress"]
# problemList = ["quasigroup", "wordpress"]
solvers = ["chuffed", "gecode"]
# solvers = ["gecode"]
flags = ["noFree", "free"]
# flags = ["noFree"]
instances_solutions_path = "../instances_and_solutions/"
eprime_path = "../eprime_models/"
minizinc_path = "../miniZinc_files/"

eprime_instance_path = "eprime/param"
minizinc_instance_path = "minizinc/instances"

for problem in problemList:
    for solver in solvers:
        for flag in flags:
            if solver == "chuffed" and flag == "free":
                continue
            def eprime_os_path(save_path="../", rem="y"):
                return ("./cleanup.sh " + instances_solutions_path
                    + problem + "/" + eprime_instance_path + " " +
                    rem + " " + save_path + flag + "_" + solver)
            
            if problem == "cvrptw" or problem == "tournament":
                os.system(eprime_os_path(rem="n"))
            else:
                os.system(eprime_os_path())

            if problem == "wordpress":
                os.system(eprime_os_path(save_path="../../../wordpressNoSymm/eprime/")) 
            elif problem == "quasigroup":
                os.system(eprime_os_path(save_path="../../../quasigroupOcc/eprime/")) 