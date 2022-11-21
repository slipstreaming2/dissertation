import sys 
import json
from ast import literal_eval
from pathlib import Path 

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
    statDict["timeout"] = False
    for line in lines:
        lineJson = json.loads(line)
        lineType = lineJson["type"]
        if lineType == "statistics":
            statDict.update(lineJson["statistics"])
        elif lineType == "solution":
            solutionDict.update(lineJson["output"]["json"])
        elif lineType == "comment" and lineJson["comment"] == "% Time limit exceeded!":
            statDict["timeout"] = True
            

    
statFile = sys.argv[1]
dataSaveLocation = sys.argv[2]
statInfo = {}
if "eprime" in sys.argv[3]:
    # .info files
    statInfo = readMinionStats(statFile)
else:
    miniSolution = {}
    readMinizinc(statFile, statInfo, miniSolution)
    slashes = [i for i in range(len(statFile)) if statFile[i] == '/']
    # Path(statFile[:slashes[-1]+1] + "json").mkdir(parents=True, exist_ok=True)
    with open(sys.argv[4] + "/" + statFile[slashes[-1]+1:] + ".json", "w") as f:
        json.dump(miniSolution, f)

with open(dataSaveLocation + ".json", "w") as f:
    json.dump(statInfo, f)

print('extracted data from ' + statFile)
# print(miniStats)
# print(miniSolution)

# minizinc_sol = open("./wordpress/minizinc.json", "r")
# minizinc_sol = json.load(minizinc_sol)
# wordpress(minizinc_sol, es_param_file)

