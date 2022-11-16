from ast import literal_eval
import json
import sys

# infile = sys.argv[1]
identLocation = 1
varLocation = 3


def readFile(fileName):
    f = open(fileName, "r")
    toCheck = {}
    identifier = ""
    builder = ""
    foundLetting = False # multiline letting
    lines = f.readlines()
    for line in lines: 
        line = line.replace("\n", "").split()
        if len(line) == 0: # empty lines
            continue
        if line[0] == 'letting':
            if foundLetting:
                toCheck[identifier] = literal_eval(builder)
                builder = ""
            identifier = line[identLocation]
            line = line[varLocation:] # assuming use of 'be' or '=' with space
            foundLetting = True 
        if foundLetting:
            builder += "".join(line)
    if 'true' in builder:
        builder = builder.replace('true', 'True')
    if 'false' in builder:
        builder = builder.replace('false', 'False')
    toCheck[identifier] = literal_eval(builder) # last join
    return toCheck

def quasigroup(solutionFile, paramFile):
    # solutionFile = readFile("./quasigroup/quasigroup.param.solution")
    # paramFile = readFile("./quasigroup/quasigroup.param")
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

def quasigroupOcc(paramFile, solutionFile):
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
    cpu = 0
    memory = 1
    storage = 2
    assignment = solutionFile["AssignmentMatrix"]
    vmType = solutionFile["VMType"]
    cpuAssign = solutionFile["CPU"]
    memoryAssign = solutionFile["Memory"]
    storageAssign = solutionFile["Storage"]
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
        usedComp = 0
        for i in range(numComp):
            usedComp += assignment[i][k]
        if usedComp >= 1:
            currVmType = vmType[k]-1
            assert cpuAssign[k] == vmSpecs[currVmType][cpu]
            assert storageAssign[k] == vmSpecs[currVmType][storage]
            assert memoryAssign[k] == vmSpecs[currVmType][memory]
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
    minizincTravel = eprimeSolution[target]
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
    distance = []

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
    
    for i in range(nbTeams):
        assert len(set(opponent[i])) == len(opponent[i])
    
    for i in range(nbRounds):
        column = [opponent[j][i] for j in range(nbTeams)]
        assert len(set(column)) == len(column)

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

    for i in range(nbTeams):
        if venue[i][0] == 1:
            assert travel[i][0] == 0
        else:
            assert travel[i][0] == distance[i][opponent[i][0]-1]
    
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
    
    plan1d = solutionFile["plan1d"]
    # plan2dT = solutionFile["plan2dT"]
    plan2d = solutionFile["plan2d"]
    numberOfShifts = 3

    assert len(plan2d) == numWeeks
    assert len(plan2d[0]) == daysPerWeek

    plan2dT = [ [0]*numWeeks for _ in range(daysPerWeek) ]
    for i in range(daysPerWeek):
        for j in range(numWeeks):
            plan2dT[i][j] = plan2d[j][i]

    # print(plan2dT)
    # print(plan2d)

    # shift requirements respected
    for i in range(daysPerWeek):
        for j in range(numberOfShifts+1):
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
    vehicle = solutionFile["vehicle"] # which vehicle visits which customer
    load = solutionFile["load"]
    arrivalTime = solutionFile["arrivalTime"] # arrival time at node
    departureTime = solutionFile["departureTime"] # departure time at node UNUSED??
    slack = solutionFile["slack"] # time waiting, slack time if necessary
    objective = solutionFile["objective"]
    start_load = solutionFile["start_load"] # UNUSED????

    NumCustomers = paramFile["M"] # num nodes in MIP model
    NumVehicles = paramFile["K"] # num vehicles
    Demand = paramFile["Demand"]
    TravelTime = paramFile["TravelTime"]
    TimeWindows = paramFile["TimeWindows"]
    PDs = paramFile["PDs"]
    Capacity = paramFile["Capacity"]
    
    START_DEPOT_NODES = range(NumCustomers, NumCustomers+NumVehicles)
    END_DEPOT_NODES = range(NumCustomers+NumVehicles, NumCustomers+2*NumVehicles)


    # for n in range(NumCustomers+NumVehicles, NumCustomers+2*NumVehicles):
    #     assert successor[n] == n-NumVehicles+1


    def circuit(toCheck):
        starting = toCheck[0]
        end_index = 1
        count = 1
        while starting != end_index:
            count += 1
            starting = toCheck[starting-1]
        assert len(toCheck) == count

        # assert len(set(toCheck)) == len(toCheck)
        # for i in range(toCheck):
        #     toCheck[i]  

        # orderSucc = [0 for _ in range(toCheck)]
        # orderSucc[0] = 1
        # for i in range(toCheck):
        #     orderSucc[toCheck[i]-1] = 1 if orderSucc[i] == len(toCheck) else orderSucc[i]+1
        #     assert toCheck[i] != i+1
        # assert len(set(orderSucc)) == len(orderSucc)

    circuit(successor) # needed?
    circuit(predecessor) # needed?


    # predecessor/successor constraint
    for n in range(NumCustomers+2*NumVehicles):
        assert successor[predecessor[n]-1] == n+1
        assert predecessor[successor[n]-1] == n+1

    # vehicle constraints
    for n in range(NumCustomers):
        assert vehicle[predecessor[n]-1] == vehicle[n]
        assert vehicle[successor[n]-1] == vehicle[n]
    # ---------------------------- #

    # pickups and deliveries
    for n in range(NumCustomers):
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

    # note custom eprime file
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

    



# es_solution_file = readFile("./wordpress/wordpress.param.solution")
# es_param_file = readFile("./wordpress/wordpress.param") 




# checks inputted file solutions against params
in_param = sys.argv[1] # eprime param
solution_file = ""
try:
    if len(sys.argv) > 3:
        solution_file = json.load(open(sys.argv[2], 'r')) # json solution
    else:
        solution_file = readFile(sys.argv[2])

    param_file = readFile(in_param)
    print("checking " + in_param)
    if 'quasigroup' in in_param:
        quasigroup(solution_file, param_file)
    elif 'wordpress' in in_param:
        wordpress(solution_file, param_file)
    elif 'tournament' in in_param:
        checkTournament(solution_file, param_file)
    elif 'roster' in in_param:
        checkRoster(solution_file, param_file)
    elif 'mspsp' in in_param:
        checkMSP(solution_file, param_file)
    elif 'cvr' in in_param:
        checkCVR(solution_file, param_file)
    print(in_param + " passed")
except FileNotFoundError:
    print('no solution found for ' + in_param)

