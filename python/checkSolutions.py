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
    toCheck[identifier] = literal_eval(builder) # last join
    return toCheck

def quasigroup():
    solutionFile = readFile("./quasigroup/quasigroup.param.solution")
    paramFile = readFile("./quasigroup/quasigroup.param")
    print(solutionFile)
    print(paramFile)
    paramDimensions = paramFile["N"]
    latinSquare = solutionFile["puzzle"]
    inputPuzzle = paramFile["initBoard"]

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

# quasigroup()


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

    

# es_solution_file = readFile("./wordpress/wordpress.param.solution")
# es_param_file = readFile("./wordpress/wordpress.param") 

# checks inputted file solutions
in_param = sys.argv[1]
es_solution_file = readFile(in_param + ".solution")
es_param_file = readFile(in_param)
print("checking " + in_param)
wordpress(es_solution_file, es_param_file)