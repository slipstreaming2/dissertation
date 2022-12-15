import os

# problemList = ["cvrptw", "mspsp", "quasigroup", "roster", "tournament", "wordpress"]
# problemList = ["cvrptw", "tournament"]
problemList = ["mspsp"]
# solvers = ["chuffed", "gecode"]
solvers = ["chuffed"]
flags = ["noFree", "free"]
# flags = ["noFree"]
instances_solutions_path = "../instances_and_solutions/"

minizinc_path = "../miniZinc_files/"
minizinc_instance_path = "minizinc/instances"

savileRow_bin = "../../savilerow-1.9.1-linux/bin/"

for problem in problemList:
    for solver in solvers:
        for flag in flags:
            toAddFlag = "" if flag == "noFree" else "-f"
            def mzn_path(mzn_model=problem, save_path="../"):
                arg1 = instances_solutions_path + problem + "/" + minizinc_instance_path
                arg2 = minizinc_path + mzn_model + "/" + mzn_model + ".mzn"
                # arg3 = save_path + "objective/" + flag + "_" + solver
                arg3 = save_path + "noStdLib/" + flag + "_" + solver
                return ("./genMiniZincObjectiveComms.sh " + arg1 + " " + arg2 + " " +
                    arg3 + " " + solver + " " + toAddFlag)

            os.system(mzn_path())
            # if problem == "wordpress":
            #     os.system(mzn_path(mzn_model="wordpressNoSymm", save_path="../../../wordpressNoSymm/minizinc/"))
            # elif problem == "quasigroup":
            #     os.system(mzn_path(mzn_model="quasigroupOcc", save_path="../../../quasigroupOcc/minizinc/"))
            # # print(mzn_path())

            # if solver == "chuffed" and flag == "free":
            #     continue
            
            # def eprime_os_path():
            #     fzn_solver = savileRow_bin + "fzn-" + solver
            #     saving_path = instances_solutions_path + problem + "/eprime/" + flag + "_" + solver
            #     return ("./generateEprimeOptCommands.sh " + fzn_solver + " " + saving_path  + " " + toAddFlag)
            # # print(eprime_os_path())
            # os.system(eprime_os_path()) 