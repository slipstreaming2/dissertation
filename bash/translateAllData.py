import os

problemList = ["cvrptw", "mspsp", "quasigroup", "quasigroupOcc", "roster", "tournament", "wordpress", "wordpressNoSymm"]
solvers = ["gecode", "chuffed"]
flags = ["noFree", "free"]

instances_solutions_path = "../instances_and_solutions/"
eprime_path = "eprime/"
eprime_timing = "timing"
minizinc_path = "minizinc/"

for problem in problemList:
    for solver in solvers:
        for flag in flags:
            first_half = "./translateData.sh " + instances_solutions_path + problem + "/"
            save_location = problem 
            folder_name = flag + "_" + solver 
            os.system(first_half + minizinc_path + folder_name + " " + problem + "/minizinc/" + folder_name + " minizinc " + problem)
            # print(first_half + minizinc_path + folder_name + " " + problem + "/minizinc/" + folder_name + " minizinc " + problem)
            if solver == "chuffed" and flag == "free":
                continue
            # print(first_half + eprime_path + folder_name + "/" + eprime_timing + " " + problem + "/eprime/" + folder_name + " eprime "  + problem)
            os.system(first_half + eprime_path + folder_name + "/" + eprime_timing + " " + problem + "/eprime/" + folder_name + " eprime "  + problem)