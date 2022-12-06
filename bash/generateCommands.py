import os

# problemList = ["cvrptw", "mspsp", "quasigroup", "roster", "tournament", "wordpress"]
problemList = ["quasigroup", "wordpress"]
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
            toAddFlag = "" if flag == "noFree" else "_free"
            def mzn_path(mzn_model=problem, save_path="../"):
                return ("./minizincRun.sh " + instances_solutions_path +
                    problem + "/" + minizinc_instance_path + " " +
                    minizinc_path + mzn_model + "/" + mzn_model + ".mzn " +
                    save_path + flag + "_" + solver + " " + solver + " " + toAddFlag)

            # os.system(mzn_path())
            # # print(mzn_path())
            # if problem == "wordpress":
            #     os.system(mzn_path(mzn_model="wordpressNoSymm", save_path="../../../wordpressNoSymm/minizinc/"))
            #     # print(mzn_path(mzn_model="wordpressNoSymm", save_path="../../../wordpressNoSymm/minizinc/"))
            # elif problem == "quasigroup":
            #     os.system(mzn_path(mzn_model="quasigroupOcc", save_path="../../../quasigroupOcc/minizinc/"))
                # print(mzn_path(mzn_model="quasigroupOcc", save_path="../../../quasigroupOcc/minizinc/"))

            if solver == "chuffed" and flag == "free":
                continue
            
            def eprime_os_path(eprime_model=problem, save_path="../"):
                return ("./eprimeRun.sh " + instances_solutions_path
                    + problem + "/" + eprime_instance_path + " " +
                    eprime_path + eprime_model + "/" + eprime_model + ".eprime " +
                    save_path + flag + "_" + solver + " " + solver + " " + toAddFlag)
            # print(eprime_os_path())
            os.system(eprime_os_path()) 

            if problem == "wordpress":
                os.system(eprime_os_path(eprime_model="wordpressNoSymm", save_path="../../../wordpressNoSymm/eprime/")) 
                # print(eprime_os_path(eprime_model="wordpressNoSymm", save_path="../../../wordpressNoSymm/eprime/")) 
            elif problem == "quasigroup":
                os.system(eprime_os_path(eprime_model="quasigroupOcc", save_path="../../../quasigroupOcc/eprime/")) 
                # print(eprime_os_path(eprime_model="quasigroupOcc", save_path="../../../quasigroupOcc/eprime/")) 














# for problem in problemList:
#     for solver in solvers:
#         for flag in flags:
#             toAddFlag = "" if flag == "noFree" else "_free"
#             # print("./minizincRun.sh " + instances_solutions_path
#             #         + problem + "/" + minizinc_instance_path + " " +
#             #         minizinc_path + problem + "/" + problem + ".mzn " +
#             #         "../" + flag + "_" + solver + " " + solver + " " + toAddFlag)
#             # os.system("./minizincRun.sh " + instances_solutions_path
#             #         + problem + "/" + minizinc_instance_path + " " +
#             #         minizinc_path + problem + "/" + problem + ".mzn " +
#             #         "../" + flag + "_" + solver + " " + solver + " " + toAddFlag)
#             # if problem == "wordpress":
#             #     os.system("./minizincRun.sh " + instances_solutions_path
#             #         + problem + "/" + minizinc_instance_path + " " +
#             #         minizinc_path + "wordpressNoSymm/wordpressNoSymm.mzn "
#             #         + "../../../wordpressNoSymm/minizinc/" + flag + "_" + solver + " " + solver + " " + toAddFlag)
#             # elif problem == "quasigroup":
#             #     os.system("./minizincRun.sh " + instances_solutions_path +
#             #         problem + "/" + minizinc_instance_path + " " +
#             #         minizinc_path + "quasigroupOcc/quasigroupOcc.mzn "
#             #         + "../../../quasigroupOcc/minizinc/" + flag + "_" + solver + " " + solver + " " + toAddFlag)


#             if solver == "chuffed" and flag == "free":
#                 continue
#             # print("./eprimeRun.sh " + instances_solutions_path
#             #         + problem + "/" + eprime_instance_path + " " +
#             #         eprime_path + problem + "/" + problem + ".eprime " +
#             #         "../" + flag + "_" + solver + " " + solver + " " + toAddFlag)
#             os.system("./eprimeRun.sh " + instances_solutions_path
#                     + problem + "/" + eprime_instance_path + " " +
#                     eprime_path + problem + "/" + problem + ".eprime " +
#                     "../" + flag + "_" + solver + " " + solver + " " + toAddFlag) 

#             if problem == "wordpress":
#                 os.system("./eprimeRun.sh " + instances_solutions_path
#                     + problem + "/" + eprime_instance_path + " " +
#                     eprime_path + "wordpressNoSymm/wordpressNoSymm.eprime " +
#                     "../../../wordpressNoSymm/eprime/" + flag + "_" + solver + " " + solver + " " + toAddFlag)
#             elif problem == "quasigroup":
#                 os.system("./eprimeRun.sh " + instances_solutions_path + 
#                         problem + "/" + eprime_instance_path + " " +
#                         eprime_path + "quasigroupOcc/quasigroupOcc.eprime " +
#                         "../../../quasigroupOcc/eprime/" + flag + "_" + solver + " " + solver + " " + toAddFlag)