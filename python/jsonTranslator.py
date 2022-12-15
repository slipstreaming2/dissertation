import sys 
from pathlib import Path 
import json 

def translateFile(newFileName, file_to_convert="", data=None):
    if data == None:
        mini_file = open(file_to_convert, "r")
        data = json.load(mini_file) 
    print(newFileName)
    param_file = open(newFileName + ".param", "w")
    param_file.write("language ESSENCE' 1.0\n")

    for i in data:
        param_file.write("letting " + str(i) + " = " + str(data[i]) + "\n")
    param_file.close()

def translateToMinizinc(newFileName, file_to_convert, fileName, directory):
    json_file = json.load(open(file_to_convert, "r"))
    splitFileName = fileName.split(".")[0]
    splitFileName = splitFileName.split("_")
    weekIndex = 0
    s_minIndex = 1
    s_maxIndex = 2
    json_to_save = {}
    json_to_save["shiftRequirements"] = json_file["shiftRequirements"]
    json_to_save["numberOfWeeks"] = int(splitFileName[weekIndex])
    json_to_save["s_min"] = int(splitFileName[s_minIndex])
    json_to_save["s_max"] = int(splitFileName[s_maxIndex])
    
    with open(newFileName.replace(".solution", ""), "w") as f:
        json.dump(json_to_save, f)
    
    eprimeDirectory = directory + "/../eprime/param/" + fileName 
    translateFile(newFileName=eprimeDirectory, data=json_to_save)

input_output_file = sys.argv[1]
directory = sys.argv[2]
output_file = input_output_file.split("/")
output_file = output_file[-1]

if len(sys.argv) > 3:
    translateToMinizinc(directory + "/" + output_file, input_output_file, sys.argv[3], directory=directory)
else:
    Path(directory).mkdir(parents=True, exist_ok=True)
    translateFile(directory + "/" + output_file, input_output_file)