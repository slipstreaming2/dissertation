import sys 
import json
from ast import literal_eval

def readMinionStats(pathToFile):
    stats = open(pathToFile, "r")
    statTypeLoc = 0
    statValLoc = 1
    lines = stats.readlines()
    statsDict = {}
    for line in lines:
        line = line.split(":")
        if len(line) <= 1: 
            continue
        statsDict[line[statTypeLoc]] = literal_eval(line[statValLoc])
    return statsDict

def readMinizinc(pathToFile, statDict, solutionDict):
    miniStats = open(pathToFile, "r")
    lines = miniStats.readlines()
    for line in lines:
        lineJson = json.loads(line)
        lineType = lineJson["type"]
        if lineType == "statistics":
            statDict.update(lineJson["statistics"])
        if lineType == "solution":
            solutionDict.update(lineJson["output"]["json"])
    
statFile = sys.argv[1]
dataSaveLocation = sys.argv[2]
statInfo = {}
if sys.argv[3] == "eprime":
    # .info files
    statInfo = readMinionStats(statFile)
else:
    miniSolution = {}
    readMinizinc(statFile, statInfo, miniSolution)


with open(dataSaveLocation + ".json", "w") as f:
    json.dump(statInfo, f)




# print(miniStats)
# print(miniSolution)

# minizinc_sol = open("./wordpress/minizinc.json", "r")
# minizinc_sol = json.load(minizinc_sol)
# wordpress(minizinc_sol, es_param_file)

