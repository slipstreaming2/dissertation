import sys
from pathlib import Path

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
        value_of_letting = value_of_letting.replace(";","")
        param_file.write("letting " + line[ident_location] + " = " + value_of_letting + "\n")
    param_file.close()

input_output_file = sys.argv[1]
directory = sys.argv[2]
output_file = input_output_file.split("/")
output_file = output_file[-1]

Path(directory).mkdir(parents=True, exist_ok=True)
translateFile(input_output_file, directory + "/" + output_file)