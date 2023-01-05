import sys 
from pathlib import Path 
import json 

# translates either a MiniZinc file, or a json file into Essence' param file type
# newFileName: path to save the file under
# file_to_convert: if a JSON file exists, ie. for roster generation, use this JSON file to save param file
# data: if kept none, then open json MiniZinc file to convert. Otherwise use JSON for Roster generation
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

# translates the given roster json file to a minizinc json file
# newFileName: the original essence' solution filename (ex. name.json.solution)
# file_to_convert: the JSON file path to open and convert
# fileName: the roster filename to give (ex. "weeks_s_min_s_max")
# directory:  
def translateToMinizinc(newFileName, file_to_convert, fileName, directory):
    json_file = json.load(open(file_to_convert, "r"))
    splitFileName = fileName.split(".")[0]
    splitFileName = splitFileName.split("_") # extracting weeks_s_min_s_max
    weekIndex = 0
    s_minIndex = 1
    s_maxIndex = 2
    json_to_save = {}
    json_to_save["shiftRequirements"] = json_file["shiftRequirements"]
    json_to_save["numberOfWeeks"] = int(splitFileName[weekIndex])
    json_to_save["s_min"] = int(splitFileName[s_minIndex])
    json_to_save["s_max"] = int(splitFileName[s_maxIndex])
    
    # place json file into instances folder under MiniZinc directory (instances_and_solutions\roster\minizinc\instances)
    with open(newFileName.replace(".solution", ""), "w") as f:
        json.dump(json_to_save, f)
    
    # the directory in which to save the param files
    eprimeDirectory = directory + "/../../eprime/param/" + fileName 
    # create the associated param file
    translateFile(newFileName=eprimeDirectory, data=json_to_save)

input_output_file = sys.argv[1]
directory = sys.argv[2]
output_file = input_output_file.split("/")
output_file = output_file[-1]

# minizinc file to translate into
if len(sys.argv) > 3:
    translateToMinizinc(directory + "/" + output_file, input_output_file, sys.argv[3], directory=directory)
else:
    # create the directory if it does not exist for essence' param
    Path(directory).mkdir(parents=True, exist_ok=True)
    translateFile(directory + "/" + output_file, input_output_file)