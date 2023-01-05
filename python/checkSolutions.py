from ast import literal_eval
import json
import sys

identLocation = 1
varLocation = 3


def readFile(fileName):
    f = open(fileName, "r")
    toCheck = {} # the dictionary of identifiers and respective values
    identifier = "" # identifier of letting
    builder = "" # builder of letting value
    foundLetting = False # multiline letting
    lines = f.readlines()
    for line in lines: 
        line = line.replace("\n", "").split()
        if len(line) == 0: # empty lines
            continue
        if line[0] == 'letting':
            if foundLetting: # evaluate the built value
                toCheck[identifier] = literal_eval(builder)
                builder = ""
            identifier = line[identLocation]
            line = line[varLocation:] # assuming use of 'be' or '=' with space
            foundLetting = True 
        if foundLetting:
            builder += "".join(line)
    # replace true and false with capitalize values
    if 'true' in builder:
        builder = builder.replace('true', 'True')
    if 'false' in builder:
        builder = builder.replace('false', 'False')
    toCheck[identifier] = literal_eval(builder) # last join
    return toCheck

# reads in minizinc solutions
def readMinizinc(fileName):
    f = open(fileName, "r")
    solutions = {}
    lines = f.readlines()
    for line in lines:
        lineJson = json.loads(line)
        lineType = lineJson["type"]
        if lineType == "solution":
            solutions.update(lineJson["output"]["json"])
        if lineType == "comment" and lineJson["comment"] == "% Time limit exceeded!":
            return {}
    f.close()
    return solutions

# reads the objective files and returns the last objective solution
def readObjective(fileName):
    f = open(fileName, "r")
    lines = f.readlines()
    lastSolution = []
    currSolution = []
    builder = "" # builds the array line
    is_building = False
    for line in lines:
        if "-----" in line: # end of current solution
            lastSolution = currSolution.copy()
            currSolution = []
        else:
            # skip comments or empty lines
            if len(line) == 0 or '%' in line or ('=' not in line and not is_building):
                continue
            # start building if multiline
            if not is_building and ';' not in line:
                is_building = True 
            if is_building:
                builder += line
            else: # not building, strip and add solution
                # strip
                line = line.replace(";\n", "")
                currSolution.append(line)
            if ';' in line and is_building: # end of builder line
                builder = builder.replace(";", "")
                builder = builder.replace("\n", "")
                currSolution.append(builder)
                builder = ""
                is_building = False
    f.close()
    return lastSolution

# reads in cvr objective
def readObjectiveCVR(fileName, param_file):
    lastSolution = readObjective(fileName) # gets array of values
    if len(lastSolution) == 0:
        return {}
    if checking_type == "minizinc":
        return getMiniZincObjective(lastSolution)
    
    maxNodes = param_file["M"]+2*param_file["K"]
    solution = {}
    for line in lastSolution:
        # eprime identifier formed of underscores, need to match 
        # solution format without underscores
        underscore_split = line.split("_")
        equal_split = line.split("=")
        # value of line
        val = literal_eval(equal_split[-1].strip())
        # add value into dictionary
        if 'objective' in equal_split[0] or 'start_load' in equal_split[0]:
            solution[equal_split[0].strip()] = val
        else:
            # add in solution
            name = underscore_split[0].strip()
            if name not in solution:
                solution[name] = [-1 for _ in range(maxNodes)]
            spltLine = underscore_split[1].split("=")
            # index of array
            index = literal_eval(spltLine[0].lstrip("0").strip())
            solution[name][index-1] = val
    return solution 


def getMiniZincObjective(lastSolution):
    solution = {}
    for line in lastSolution:
        getMiniZincLine(line,solution)
    return solution

def getMiniZincLine(line, solution):
    line = line.replace(' ', '')
    line = line.split('=')
    solution[line[0]] = literal_eval(line[-1])

# translates the minizinc array into eprime array
def translateArray(arrayLine):
    splitArray = arrayLine.split('|')
    if len(splitArray) == 1:
        return splitArray[0]
    newArray = splitArray[0] + "[" + splitArray[1]
    for i in range(2, len(splitArray)-1):
        newArray += "],[" + splitArray[i] 
    newArray += "]" + splitArray[len(splitArray) - 1]
    return newArray


def getTournamentObjective(lastSolution):
    solution = {}
    for line in lastSolution:
        spltline = line.split('=')
        # identfier
        val = spltline[0].strip()
        if '[' in line:
            solution[val] = literal_eval(translateArray(spltline[1].strip()))
        else:
            getMiniZincLine(line, solution)
    return solution

# reads in TTPPV values
# an absolute pain given it is formed of 2d arrays
def readObjectiveTTPPV(fileName):
    lastSolution = readObjective(fileName)
    if len(lastSolution) == 0:
        return {}
    if checking_type == "minizinc":
        return getTournamentObjective(lastSolution) 
    solution = {}
    solution["opponent"] = [[]]
    solution["travel"] = [[]]
    solution["objective"] = 0
    solution["venue"] = [[]]
    twoDSols = ["opponent", "travel", "venue"]
    for line in lastSolution:
        spltLine = line.split(" ")
        var = spltLine[0].split("_")
        varName = var[0]
        if varName in solution:
            # the value
            val = literal_eval(line.split('=')[-1].strip())
            # has a 2d solution
            if varName in twoDSols:
                # get the index for the first dimension
                indx1 = literal_eval(var[1].lstrip('0').strip())
                # if the index does not exist yet, append on new array
                if len(solution[varName]) < indx1:
                    solution[varName].append([])
                solution[varName][indx1-1].append(val)
            else: # objective
                solution[varName] = val
    return solution



def quasigroup(solutionFile, paramFile):
    paramDimensions = paramFile["N"]
    latinSquare = solutionFile["puzzle"]
    inputPuzzle = paramFile["start"]

    # solution file matches inputted dimension
    assert len(latinSquare) == paramDimensions and len(latinSquare[0]) == paramDimensions
    
    for i in range(paramDimensions):
        horizSet = []
        colSet = []
        for j in range(paramDimensions):
            numCheck = latinSquare[i][j]
            # numbers are within range and are integers
            assert numCheck > 0 and numCheck <= paramDimensions and float(numCheck).is_integer()
            horizSet.append(numCheck)
            colSet.append(latinSquare[j][i])
            # check puzzle matches input
            if inputPuzzle[i][j] != 0:
                assert numCheck == inputPuzzle[i][j]

        # implicitly asserting all numbers in range are included
        assert len(set(horizSet)) == paramDimensions
        assert len(set(colSet)) == paramDimensions

def quasigroupOcc(solutionFile, paramFile):
    paramDimensions = paramFile["N"]
    latinSquare = solutionFile["puzzle"]
    inputPuzzle = paramFile["start"]

    # toCheck = [[0]*paramDimensions]*paramDimensions
    # for i in range(paramDimensions):
    #     for j in range(paramDimensions):
    #         for k in range(paramDimensions):
    #             if latinSquare[i][j][k] == 1:
    #                 toCheck[i][j] = k+1
    #                 break
    # feed to check back into quasigroup    


    for i in range(paramDimensions):
        for j in range(paramDimensions):
            # puzzle matches input
            if inputPuzzle[i][j] != 0:
                assert(latinSquare[i][j][inputPuzzle[i][j]-1] == 1)
            # only one number per cell
            assert(sum(latinSquare[i][j]) == 1)

    # each row is distinct
    for i in range(paramDimensions):
        for k in range(paramDimensions):
            num = 0
            for j in range(paramDimensions):
                num += latinSquare[i][j][k]
            assert(num == 1)
    
    # each column is distinct
    for j in range(paramDimensions):
        for k in range(paramDimensions):
            num = 0
            for i in range(paramDimensions):
                num += latinSquare[i][j][k]
            assert(num == 1)

def wordpress(solutionFile, paramFile):
    wpress = 0
    mySql = 1
    dns = 2
    http = 3
    varnish = 4
    # cpu = 0
    # memory = 1
    # storage = 2
    assignment = solutionFile["AssignmentMatrix"]
    vmType = solutionFile["VMType"]
    occVect = solutionFile["OccupancyVector"]
    # cpuAssign = solutionFile["CPU"]
    # memoryAssign = solutionFile["Memory"]
    # storageAssign = solutionFile["Storage"]
    priceAssign = solutionFile["Price"]
    
    # inputNumAssingments = paramFile["WPInstances"]
    # numVM = paramFile["VM"]
    inputNumAssingments = 3
    numVM = 8
    vmSpecs = paramFile["VMSpecs"]
    vmPrice = paramFile["VMPrice"]
    compReq = paramFile["CompREQ"]
    numComp = paramFile["NoComponents"]
    hardwareReq = paramFile["HardwareREQ"]

    usingDns = sum(assignment[dns]) > 0
    usingHttp = sum(assignment[http]) > 0
    assert (usingDns^usingHttp) # xor

    # REQUIRE PROVIDE
    if usingDns:
        assert sum(assignment[wpress]) <= sum(assignment[dns])*7
        # upper bound
        assert sum(assignment[dns]) == 1
    else:
        assert sum(assignment[wpress]) <= sum(assignment[http])*3
    assert sum(assignment[wpress]) * 2 <= sum(assignment[mySql]) * 3 

    # lower bounds
    assert sum(assignment[varnish]) >= 2
    assert sum(assignment[mySql]) >= 2
    assert sum(assignment[wpress]) >= inputNumAssingments

    # CAPACITY
    # chosen components on VM is within VM specifications
    for k in range(numVM):
        for h in range(hardwareReq):
            sumReq = 0
            for i in range(numComp):
                sumReq += assignment[i][k]*compReq[i][h]
            assert sumReq <= vmSpecs[vmType[k]-1][h]
    
    # resources match the specs of each VM
    for k in range(numVM):
        # usedComp = 0
        # for i in range(numComp):
        #     usedComp += assignment[i][k]
        # if usedComp >= 1:
        if occVect[k] == 1:
            currVmType = vmType[k]-1
            # assert cpuAssign[k] == vmSpecs[currVmType][cpu]
            # assert storageAssign[k] == vmSpecs[currVmType][storage]
            # assert memoryAssign[k] == vmSpecs[currVmType][memory]
            assert priceAssign[k] == vmPrice[currVmType]
    
    # varnish and mySQL cannot be deployed on the same machine
    for k in range(numVM):
        assert assignment[varnish][k] + assignment[mySql][k] <= 1
    
    # dns and http must be deployed on their own VM
    # varnish cannot be deployed with dns and http
    for k in range(numVM):
        for i in [wpress, mySql, varnish]:
            assert assignment[dns][k]+assignment[i][k] <= 1
            assert assignment[http][k]+assignment[i][k] <= 1

    
def compareWordPress(eprimeSolution, minizincSolution):
    target = "Price"
    eprimePrice = eprimeSolution[target]
    minizincPrice = minizincSolution[target]
    cmpMiniZincEssence(eprimePrice, minizincPrice)

def cmpMiniZincEssence(essenceVal, minizincVal):
    if essenceVal == minizincVal:
        print("equivalent")
    elif essenceVal < minizincVal:
        print("essence' smaller than minizinc")
    else:
        print("minizinc smaller than essence'")

def compareTournament(eprimeSolution, minizincSolution):
    target = "travel"
    eprimeTravel = eprimeSolution[target]
    minizincTravel = minizincSolution[target]
    eprimeTotalTravel = sum(map(sum,eprimeTravel))
    minizincTotalTravel = sum(map(sum, minizincTravel))
    cmpMiniZincEssence(eprimeTotalTravel, minizincTotalTravel)


def checkTournament(solutionFile, paramFile):
    nbTeams = paramFile["nbTeams"]
    nbRounds = nbTeams-1
    pv = paramFile["pv"]
    opponent = solutionFile["opponent"]
    venue = solutionFile["venue"]
    travel = solutionFile["travel"]
    distance = [] # circular distances between teams

    # create circular distances
    for i in range(1,nbTeams+1): 
        distance.append([None] * nbTeams)
        for j in range(1,nbTeams+1):
            toAdd = 0
            if i >= j:
                if i-j < j-i+nbTeams:
                    toAdd = i-j
                else:
                    toAdd = j-i+nbTeams
            elif j-i < i-j+nbTeams:
                toAdd = j-i
            else:
                toAdd = i-j+nbTeams
            distance[i-1][j-1] = toAdd

    # predefined venues match venues determined
    for i in range(nbTeams):
        for j in range(nbRounds):
            assert venue[i][j] == pv[i][opponent[i][j]-1]
    
    # cannot play against yourself
    for i in range(nbTeams):
        for j in range(nbRounds):
            assert opponent[i][j] != i+1
    
    # I play you, you play me
    for i in range(nbTeams):
        for j in range(nbRounds):
            assert opponent[opponent[i][j]-1][j] == i+1
    
    # opponent is all different
    for i in range(nbTeams):
        assert len(set(opponent[i])) == len(opponent[i])
    
    # all different column of opponent
    for i in range(nbRounds):
        column = [opponent[j][i] for j in range(nbTeams)]
        assert len(set(column)) == len(column)

    # teams cannot play three consecutive games at home or away
    for i in range(nbTeams):
        currStreak = 0
        currPiece = 1
        for j in range(nbRounds):
            if currPiece == venue[i][j]:
                currStreak += 1
                assert currStreak <= 3
            else:
                currPiece = venue[i][j]
                currStreak = 0

    # assert starting travel
    for i in range(nbTeams):
        if venue[i][0] == 1:
            assert travel[i][0] == 0
        else:
            assert travel[i][0] == distance[i][opponent[i][0]-1]
    
    # assert travel matches distance
    for i in range(nbTeams):
        for j in range(nbRounds-1):
            if venue[i][j] == 1 and venue[i][j+1] == 1: 
                assert travel[i][j+1] == 0
            elif venue[i][j] == 2 and venue[i][j+1] == 1:
                assert travel[i][j+1] == distance[opponent[i][j]-1][i]
            elif venue[i][j] == 1 and venue[i][j+1] == 2:
                assert travel[i][j+1] == distance[i][opponent[i][j+1]-1]
            elif venue[i][j] == 2 and venue[i][j+1] == 2:
                assert travel[i][j+1] == distance[opponent[i][j]-1][opponent[i][j+1]-1]
    
    # assert ending travel
    for i in range(nbTeams):
        if venue[i][nbRounds-1] == 1:
            assert travel[i][nbRounds] == 0
        else:
            assert travel[i][nbRounds] == distance[opponent[i][nbRounds-1]-1][i]
    
    # travelDist = 0
    # for i in range(nbTeams):
    #     for j in range(nbRounds+1):
    #         travelDist += travel[i][j]

    # print(travelDist)

def checkRoster(solutionFile, paramFile):
    numWeeks = paramFile["numberOfWeeks"]
    daysPerWeek = 7
    s_min = paramFile["s_min"]
    s_max = paramFile["s_max"]
    shiftRequirements = paramFile["shiftRequirements"]
    
    # plan1d = solutionFile["plan1d"]
    # plan2dT = solutionFile["plan2dT"]
    plan2d = solutionFile["plan2d"]
    numberOfShiftTypes = 3

    # matches number of weeks and days, ie dimensions of arrays
    assert len(plan2d) == numWeeks
    assert len(plan2d[0]) == daysPerWeek

    plan2dT = [ [0]*numWeeks for _ in range(daysPerWeek) ]
    for i in range(daysPerWeek):
        for j in range(numWeeks):
            plan2dT[i][j] = plan2d[j][i]

    # shift requirements respected
    for i in range(daysPerWeek):
        for j in range(numberOfShiftTypes+1):
            assert shiftRequirements[i][j] == plan2dT[i].count(j)
    
    # weekend matches
    for i in range(numWeeks):
        assert plan2d[i][5] == plan2d[i][6]
    
    # forward rotating principle
    initShift = plan2d[0][0]
    for i in range(numWeeks):
        for j in range(daysPerWeek):
            assert plan2d[i][j] >= initShift or plan2d[i][j] == 0
            initShift = plan2d[i][j]

    # s_min and s_max
    initShift = plan2d[0][0]
    currStreak = 0
    for i in range(numWeeks):
        for j in range(daysPerWeek):
            if initShift == plan2d[i][j]:
                currStreak += 1
            else:
                assert currStreak >= s_min and currStreak <= s_max
                currStreak = 1
            initShift = plan2d[i][j]
    
    # for i in range(numWeeks):
    #     for j in range(daysPerWeek):
    #         assert plan2d[i][j] == plan1d[i*daysPerWeek + j]
    
    # every 14 days there is a holiday
    numDaysBetween = 0
    currNumHolidays = 0
    for i in range(numWeeks):
        for j in range(daysPerWeek):
            numDaysBetween += 1
            if plan2d[i][j] == 0:
                currNumHolidays += 1
                if currNumHolidays == 2:
                    assert numDaysBetween <= 14
                    currNumHolidays = 0
                    numDaysBetween = 0
    

def checkCVR(solutionFile, paramFile):
    successor = solutionFile["successor"]
    predecessor = solutionFile["predecessor"]
    vehicle = {}
    # with -O2 vehicle var deleted or not all values present
    if 'vehicle' in solutionFile and -1 not in solutionFile["vehicle"]:
        vehicle = solutionFile["vehicle"] # which vehicle visits which customer
    load = solutionFile["load"]
    arrivalTime = solutionFile["arrivalTime"] # arrival time at node
    # departureTime = solutionFile["departureTime"] # departure time at node UNUSED??
    slack = solutionFile["slack"] # time waiting, slack time if necessary
    objective = solutionFile["objective"]
    # start_load = solutionFile["start_load"] # UNUSED????

    NumCustomers = paramFile["M"] # num nodes in MIP model
    NumVehicles = paramFile["K"] # num vehicles
    Demand = paramFile["Demand"]
    TravelTime = paramFile["TravelTime"]
    TimeWindows = paramFile["TimeWindows"]
    PDs = paramFile["PDs"]
    Capacity = paramFile["Capacity"]
    
    START_DEPOT_NODES = range(NumCustomers, NumCustomers+NumVehicles)
    END_DEPOT_NODES = range(NumCustomers+NumVehicles, NumCustomers+2*NumVehicles)

    
    for n in range(NumCustomers+NumVehicles+1, NumCustomers+2*NumVehicles-1):
        assert successor[n] == n+1-NumVehicles+1

    # def circuitEprime(toCheck, toCheckOrder):
    #     maxNodes = NumCustomers + 2*NumVehicles
    #     nonNegToCheck = [i for i in toCheck if i != -1]
    #     nonNegToCheckOrder = [i for i in toCheckOrder if i != -1]

    #     assert len(set(nonNegToCheck)) == len(nonNegToCheck)
    #     for i in range(len(toCheck)):
    #         if toCheck[i] != -1:
    #             assert toCheck[i] != i+1
        
    #     assert len(set(nonNegToCheckOrder)) == len(nonNegToCheckOrder)
    #     if toCheckOrder[0] != -1:
    #         assert toCheckOrder[0] == 1
    #     print(toCheckOrder, toCheck)
    #     for i in range(maxNodes):
    #         if toCheckOrder[i] != -1 and toCheck[i] != -1:
    #             if toCheckOrder[i] == maxNodes:
    #                 assert toCheckOrder[toCheck[i]-1] == 1
    #             else:
    #                 assert toCheckOrder[toCheck[i]-1] == toCheckOrder[i] + 1


    def circuit(toCheck):
        starting = toCheck[0]
        end_index = 1
        count = 1
        assert len(set(toCheck)) == len(toCheck)
        while starting != end_index:
            count += 1
            starting = toCheck[starting-1]
        assert len(toCheck) == count

    # if checking_type == 'minizinc':
    circuit(successor) # needed?
    circuit(predecessor) # needed?
    # else:
    #     circuitEprime(successor, solutionFile['successorOrder'])
    #     circuitEprime(predecessor, solutionFile['predecessorOrder'])

    # predecessor/successor constraint
    for n in range(NumCustomers+2*NumVehicles):
        assert successor[predecessor[n]-1] == n+1
        assert predecessor[successor[n]-1] == n+1

    # if len(vehicle) > 0:
        # vehicle constraints
    for n in range(NumCustomers):
        assert vehicle[predecessor[n]-1] == vehicle[n]
        assert vehicle[successor[n]-1] == vehicle[n]
    # ---------------------------- #

    # pickups and deliveries
    for n in range(NumCustomers):
        # if len(vehicle) > 0:
        assert vehicle[n] == vehicle[PDs[n][1]-1]
        assert arrivalTime[n] >= arrivalTime[PDs[n][1]-1]
    # ---------------------------- #
    
    # time constraints
    for n in range(NumCustomers):
        assert arrivalTime[n] + slack[n] + TravelTime[n][successor[n]-1] == arrivalTime[successor[n]-1]
        assert arrivalTime[n] >= TimeWindows[n][0] # arrival time greater than window
        assert arrivalTime[n] <= TimeWindows[n][1] # arrival time smaller than window
    # ---------------------------- #
    
    # load constraitns
    for n in range(NumCustomers):
        assert load[n] + Demand[n] == load[successor[n]-1]
        # if len(vehicle) > 0:
        assert load[n] <= Capacity[vehicle[n]-1]
    
    for n in START_DEPOT_NODES:
        assert load[n] == load[successor[n]-1]
    
    # ----------------------------#
    
    assert objective == sum([arrivalTime[depot] for depot in END_DEPOT_NODES]) - sum([arrivalTime[depot] for depot in START_DEPOT_NODES])




def checkMSP(solutionFile, paramFile):
    n_skills = paramFile["n_skills"]
    n_workers = paramFile["n_workers"]
    has_skills = paramFile["has_skills"]
    n_tasks = paramFile["n_tasks"]
    d = paramFile["d"]
    rr = paramFile["rr"]
    suc = paramFile["suc"]

    rc = [len({j for j in range(n_workers) if i+1 in has_skills[j]}) for i in range(n_skills)]

    s = solutionFile["s"]
    w = solutionFile["w"]
    objective = solutionFile["objective"]

    # note custom eprime file, non-occurrence representation
    for i in range(n_tasks):
        for j in suc[i]:
            assert s[i] + d[i] <= s[j-1]
    
    for i in range(n_tasks):
        TWorkers = {j for j in range(n_workers) if True in [rr[k-1][i] > 0 for k in has_skills[j]]}
        for k in range(n_skills):
            if rr[k][i] > 0:
                m = [j for j in TWorkers if k+1 in has_skills[j]]
                assert sum([1 if w[j][i] else 0 for j in m]) >= rr[k][i]
        for j in range(n_workers):
            if j not in TWorkers:
                assert w[j][i] == False

    
    for j in range(n_workers):
        WTasks = {i for i in range(n_tasks) if True in [rr[k-1][i] > 0 for k in has_skills[j]]}
        if len(WTasks) > 1:
            for k in WTasks:
                assert 1 >= sum([1 for i in WTasks if (s[i] <= s[k] and s[k] < s[i] + d[i] and w[j][i])])

    for i in range(n_tasks):
        for j in range(n_tasks):
            if i < j and j+1 not in suc[i] and i+1 not in suc[j]:
                if True in (rr[k][i]+rr[k][j] > rc[k] for k in range(n_skills)):
                    assert s[i] + d[i] <= s[j] or s[j] + d[j] <= s[i]
    
    for k in range(n_skills):
        RTasks = {i for i in range(n_tasks) if rr[k][i] > 0 }
        sum_rr = sum([rr[k][i] for i in RTasks])
        if len(RTasks) > 1 and sum_rr > rc[k]:
            for j in RTasks:
                assert rc[k] >= sum([rr[k][i] for i in RTasks if (s[i] <= s[j] and s[j] < s[i]  + d[i])])
    
    for i in range(n_tasks):
        if len(suc[i]) == 0:
            assert s[i]+d[i] <= objective

# method determines if all variables are present to check solutions
# O2 optimisations and above in Essence' leads to variable deletions
# it is difficult to determine the validity of the solutions
# note no optimisations (O0) does not delete variables and gives correct solutions
# assuming the authors created a correct optimisation reformulation, the step up 
# from O0 to O2 gives same valid solutions
def determine_valid_objective():
    if checking_type == "essence'":
        for keys in solution_dict.keys():
            val = solution_dict[keys]
            if type(val) == list and -1 in val:
                print('missing values in objective solution')
                print()
                return False
    return True


# checks inputted file solutions against params
in_param = sys.argv[1] # eprime param
solution_dict = {}
solution_filename = sys.argv[2]
checking_type = "essence'" if len(sys.argv) <= 3 else "minizinc"
print("checking " + checking_type + " " + in_param.split('/')[-1] + " against " + solution_filename)
try:
    param_file = readFile(in_param)
    # if checking objective solutions
    if 'OBJECTIVE' in solution_filename.upper():
        if 'cvrptw' in solution_filename:
            solution_dict = readObjectiveCVR(solution_filename, param_file)
        else: # tournament/ttppv
            solution_dict = readObjectiveTTPPV(solution_filename)
        if not determine_valid_objective():
            exit(0)        

    else: # otherwise normal solution
        if len(sys.argv) > 3: # minizinc
            # solution_file = json.load(open(sys.argv[2], 'r')) # json solution
            solution_dict = readMinizinc(solution_filename) # json solution
        else:
            solution_dict = readFile(solution_filename) # read in eprime solution file

    # empty solutions file, no solution found
    if len(solution_dict) == 0:
        raise FileNotFoundError()
    if 'quasigroupOcc' in solution_filename:
        quasigroupOcc(solution_dict, param_file)
    elif 'quasigroup' in in_param:
        quasigroup(solution_dict, param_file)
    elif 'wordpress' in in_param:
        wordpress(solution_dict, param_file)
    elif 'tournament' in in_param:
        checkTournament(solution_dict, param_file)
    elif 'roster' in in_param:
        checkRoster(solution_dict, param_file)
    elif 'mspsp' in in_param:
        checkMSP(solution_dict, param_file)
    elif 'cvr' in in_param:
        checkCVR(solution_dict, param_file)
    print(solution_filename + " passed")
except FileNotFoundError:
    print('no solution found for ' + checking_type + " " + in_param + ' using ' + solution_filename)

print()