import json
from urllib.request import urlopen


json_file = urlopen("https://covid.ourworldindata.org/data/owid-covid-data.json")
file = json.load(json_file)
for key,value in file.items():
    statisticsData = file[key]['data']
    for data in list(statisticsData): #contains one data
        for dataKey, dataValue in data.items(): #contains one date
            if dataKey == "date" and dataValue <= "2022-03-31" :
                statisticsData.remove(data)

with open("historicalData-shrinked.json", "w") as outfile:
    json.dump(file, outfile)
                
                
                
                