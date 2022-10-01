def translateArray(arrayLine):
    arrayLine = arrayLine.replace(";","")
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

def translateFile(filePathToConvert, newFileName):
    mini_file = open(filePathToConvert, "r")
    param_file = open(newFileName + ".param", "w")
    param_file.write("language ESSENCE' 1.0\n")
    lines = mini_file.readlines()
    ident_location = 0
    val_location = 1
    assembledLine = ""
    i = 0
    while i < len(lines):
        line = lines[i]
        line = line.split("=")
        if len(line) == 0:
            continue 
        if 
        elif not isReadingArray:
            param_file.write("letting " + line[ident_location] + " = ")
            if "|" in line[val_location]:

                isReadingArray = True 
                endOfLine = ";" in line[val_location]
                line = line[val_location].split("|")
                assembledLine += line[0] + "["
                for i in range(1, len(line)):
                    arrToAdd = ""
                    if ";" not in line[i]:
                        arrToAdd += "]"
                    if i+1 < len(line) and ";" not in line[i+1]:
                        arrToAdd += ",["
                    assembledLine += line[i] + arrToAdd

                    assembledLine += "],[" + line[i]
            elif ";" in line[val_location]: 
                param_file.write(line[val_location].replace(";", "") + "\n")
        else: # reading in array
            
            if ";" in line[val_location]:


                        
