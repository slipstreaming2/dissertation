import os

problemList = ["cvrptw", "mspsp", "quasigroup", "roster", "tournament", "wordpress"]
# problemList = ["wordpress", "mspsp", "quasigroup", "tournament"]
# problemList = ["mspsp"]
solvers = ["chuffed"]
flags = ["free"]
# flags = ["noFree"]
instances_solutions_path = "../instances_and_solutions/"
eprime_path = "../eprime_models/"
minizinc_path = "../miniZinc_files/"

eprime_instance_path = "eprime/param"
minizinc_instance_path = "minizinc/instances"

for problem in problemList:
    for solver in solvers:
        for flag in flags:
            toAddFlag = "" if flag == "noFree" else "_free"
            def mzn_path(mzn_model=problem, save_path="../"):
                arg1 = instances_solutions_path + problem + "/" + minizinc_instance_path
                arg2 = minizinc_path + mzn_model + "/" + mzn_model + ".mzn"
                arg3 = save_path + flag + "_" + solver
                return ("./generateMinizincCommands.sh " + arg1 + " " + arg2 + " " +
                     arg3 + " " + solver + " " + toAddFlag)

            os.system(mzn_path())
            if problem == "wordpress":
                os.system(mzn_path(mzn_model="wordpressNoSymm", save_path="../../../wordpressNoSymm/minizinc/"))
            elif problem == "quasigroup":
                os.system(mzn_path(mzn_model="quasigroupOcc", save_path="../../../quasigroupOcc/minizinc/"))

            # if solver == "chuffed" and flag == "free":
            #     continue
            
            def eprime_os_path(eprime_model=problem, save_path="../"):
                isDeletingFzn = "y"
                arg1 = instances_solutions_path + problem + "/" + eprime_instance_path
                arg2 = eprime_path + eprime_model + "/" + eprime_model + ".eprime"
                arg3 = save_path + flag + "_" + solver
                return ("./runAllEprimeCommands.sh " + arg1 + " " + arg2 + " " + 
                arg3 + " " + isDeletingFzn + " " + solver + " " + toAddFlag)
            os.system(eprime_os_path()) 

            if problem == "wordpress":
                os.system(eprime_os_path(eprime_model="wordpressNoSymm", save_path="../../../wordpressNoSymm/eprime/")) 
            elif problem == "quasigroup":
                os.system(eprime_os_path(eprime_model="quasigroupOcc", save_path="../../../quasigroupOcc/eprime/")) 