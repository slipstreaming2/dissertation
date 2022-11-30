import os

problemList = ["cvrptw", "mspsp", "quasigroup", "roster", "tournament", "wordpress"]
# problemList = ["quasigroup", "wordpress"]
# solvers = ["chuffed", "gecode"]
solvers = ["gecode"]
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
            toAddFlag = "" if flag == "noFree" else "_free"
            # print("./minizincRun.sh " + instances_solutions_path
            #         + problem + "/" + minizinc_instance_path + " " +
            #         minizinc_path + problem + "/" + problem + ".mzn " +
            #         "../" + flag + "_" + solver + " " + solver + " " + toAddFlag)
            # os.system("./minizincRun.sh " + instances_solutions_path
            #         + problem + "/" + minizinc_instance_path + " " +
            #         minizinc_path + problem + "/" + problem + ".mzn " +
            #         "../" + flag + "_" + solver + " " + solver + " " + toAddFlag)
            
            if solver == "chuffed" and flag == "free":
                continue
            # print("./eprimeRun.sh " + instances_solutions_path
            #         + problem + "/" + eprime_instance_path + " " +
            #         eprime_path + problem + "/" + problem + ".eprime " +
            #         "../" + flag + "_" + solver + " " + solver + " " + toAddFlag)
            os.system("./eprimeRun.sh " + instances_solutions_path
                    + problem + "/" + eprime_instance_path + " " +
                    eprime_path + problem + "/" + problem + ".eprime " +
                    "../" + flag + "_" + solver + " " + solver + " " + toAddFlag) 

            if problem == "wordpress":
                # os.system("./minizincRun.sh " + instances_solutions_path
                #     + problem + "/" + minizinc_instance_path + " " +
                #     minizinc_path + "wordpressNoSymm/wordpressNoSymm.mzn "
                #     + "../../../wordpressNoSymm/minizinc/" + flag + "_" + solver + " " + solver + " " + toAddFlag)
                os.system("./eprimeRun.sh " + instances_solutions_path
                    + problem + "/" + eprime_instance_path + " " +
                    eprime_path + "wordpressNoSymm/wordpressNoSymm.eprime " +
                    "../../../wordpressNoSymm/eprime/" + flag + "_" + solver + " " + solver + " " + toAddFlag)
            elif problem == "quasigroup":
                # os.system("./minizincRun.sh " + instances_solutions_path +
                #     problem + "/" + minizinc_instance_path + " " +
                #     minizinc_path + "quasigroupOcc/quasigroupOcc.mzn "
                #     + "../../../quasigroupOcc/minizinc/" + flag + "_" + solver + " " + solver + " " + toAddFlag)
                os.system("./eprimeRun.sh " + instances_solutions_path + 
                        problem + "/" + eprime_instance_path + " " +
                        eprime_path + "quasigroupOcc/quasigroupOcc.eprime " +
                        "../../../quasigroupOcc/eprime/" + flag + "_" + solver + " " + solver + " " + toAddFlag)