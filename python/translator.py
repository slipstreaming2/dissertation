import sys
import ast
from pathlib import Path
import json

def translateArray(arrayLine):
    splitArray = arrayLine.split('|')
    if len(splitArray) == 1:
        return splitArray[0]
    newArray = splitArray[0] + "[" + splitArray[1]
    for i in range(2, len(splitArray)-1):
        newArray += "],[" + splitArray[i] 
    newArray += "]" + splitArray[len(splitArray) - 1]
    return newArray


def readInArray(lines, index):
    firstLine = lines[index].split('=')[1]
    stoppedIndex = index
    if ";" in firstLine:
        return (translateArray(firstLine), stoppedIndex)
    for i in range(index+1, len(lines)):
        lineToAdd = lines[i]
        firstLine += lines[i] 
        if ";" in lineToAdd:
            stoppedIndex = i
            break
    return (translateArray(firstLine), stoppedIndex)


def stripEverything(toStrip):
    return toStrip.replace(" ","").replace("\n", "").replace("\t","").replace(";","")

def translateFile(file_to_convert, newFileName):
    mini_file = open(file_to_convert, "r")
    print(newFileName)
    param_file = open(newFileName + ".param", "w")
    param_file.write("language ESSENCE' 1.0\n")
    lines = mini_file.readlines()
    ident_location = 0
    val_location = 1
    i = 0
    while i < len(lines):
        line = lines[i]
        # print(line)
        line = line.split("=")
        if len(line) < 2: # new line or empty line
            i += 1
            continue
        value_of_letting = line[val_location]
        if "[" in value_of_letting:
            (value_of_letting, stoppedIndex) = readInArray(lines, i)
            i = stoppedIndex
        i += 1

        ident = stripEverything(line[ident_location])
        value_of_letting = stripEverything(value_of_letting)
        jsonOfFile[ident] = value_of_letting # used for sets
        if ident in setLens:
            setLens[ident] = ast.literal_eval(jsonOfFile[setLens[ident]])
        if '{' in value_of_letting:
            value_of_letting = convertSetToOccurrence(ident, ast.literal_eval(value_of_letting))

        param_file.write("letting " + ident + " = " + str(value_of_letting) + "\n")
    param_file.close()



def convertSetToOccurrence(identName, val):
    if type(val) is list:
        for i in range(len(val)):
            val[i] = convertSetToOccurrence(identName, val[i])
        return val
    # is a set
    else:
        setAsOcc = [0 for _ in range(setLens[identName])]
        for i in val:
            setAsOcc[i-1] = 1
        return setAsOcc



input_output_file = sys.argv[1]
directory = sys.argv[2]
output_file = input_output_file.split("/")
output_file = output_file[-1]

jsonOfFile = {}
setLens = {}
if len(sys.argv) > 3:
    setLens = json.loads(sys.argv[3])

Path(directory).mkdir(parents=True, exist_ok=True)
translateFile(input_output_file, directory + "/" + output_file)