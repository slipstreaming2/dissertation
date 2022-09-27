from ast import literal_eval

# infile = sys.argv[1]
identLocation = 1
varLocation = 3


def readFile(fileName):
    f = open(fileName, "r")
    toCheck = {}
    identifier = ""
    builder = ""
    foundLetting = False
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
    solutionFile = readFile("quasigroup.param.solution")
    paramFile = readFile("quasigroup.param")
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

quasigroup()


def wordpress():
    solutionFile = readFile("wordpress.param.solution")
    paramFile = readFile("wordpress.param")

