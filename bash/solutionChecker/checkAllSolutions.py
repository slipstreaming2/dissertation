import os

instances_and_solutions_path = "../../instances_and_solutions/"
eprime_param_path = "eprime/param"

eprime_solution_path = "solutions"
minizinc_solution_path = ""

flags = ["free", "noFree"]
# flags = ["noFree"]
solvers = ["chuffed"]

substitute = {}
substitute["quasigroupOcc"] = "quasigroup"
substitute["wordpressNoSymm"] = "wordpress"

for problem in os.scandir(instances_and_solutions_path):
    # if 'cvrptw' not in problem.path:
    #     continue
    param_file = problem.path + "/" + eprime_param_path
    if problem.name in substitute:
        param_file = instances_and_solutions_path + substitute[problem.name] + "/" + eprime_param_path
    if problem.name == "mspsp":
        param_file = problem.path + "/eprime/non-occurrence"

    has_objective = False
    has_noStdLib = False
    for dirs in os.scandir(problem.path + "/minizinc"):
        if dirs.name == "objective":
            has_objective = True
        if 'noStdLib' in dirs.name:
            has_noStdLib = True

    for flag in flags:
        for solver in solvers:
            folder = flag + "_" + solver
            os.system("./checkMiniZincSolutions.sh " + param_file + " " + problem.path + "/minizinc/" + folder)
            if has_objective:
                os.system("./checkMiniZincSolutions.sh " + param_file + " " + problem.path + "/minizinc/objective/" + folder)
                if has_noStdLib:
                    os.system("./checkMiniZincSolutions.sh " + param_file + " " + problem.path + "/minizinc/noStdLibObjective/" + folder)
                os.system("./checkEprimeSolutions.sh " + param_file + " " + problem.path + "/eprime/" + folder + "/objective" + " objective")
            elif has_noStdLib:
                 os.system("./checkMiniZincSolutions.sh " + param_file + " " + problem.path + "/minizinc/noStdLib" + folder)
                 
            if flag == 'free':
                continue
            os.system("./checkEprimeSolutions.sh " + param_file + " " + problem.path + "/eprime/" + folder + "/" + eprime_solution_path)
            

