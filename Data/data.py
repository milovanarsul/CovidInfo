import json
from urllib.request import urlopen
from datetime import datetime

def downloadJSON():
    json_file = urlopen("https://covid.ourworldindata.org/data/owid-covid-data.json")
    file = json.load(json_file)
    for key,value in file.items():
        statisticsData = file[key]['data']
        for data in list(statisticsData):
            for dataKey, dataValue in data.items():
                if dataKey == "date" and dataValue <= "2021-12-31" :
                    statisticsData.remove(data)
    
    return file

def loadJSON():
    file = open("/Users/milovanarsul/Documents/CovidInfo/Scripts/historicalData-shrinked.json")
    return json.load(file)

def parseData(jsonFile, country, dataKey):
    buffer = {}

    key = jsonFile[country]
    for data in list(key['data']):
        if dataKey in data:
            date = datetime.strptime(data['date'], '%Y-%m-%d').strftime('%d-%m-%y')
            buffer[date] = data[dataKey]

    return buffer

def parseValues(jsonFile, country):
    buffer = {}

    buffer['cases'] = parseData(jsonFile, country, 'new_cases')
    buffer['sevenDaysCases'] = parseData(jsonFile, country, 'new_cases_smoothed')
    buffer['deaths'] = parseData(jsonFile, country, 'new_deaths')
    buffer['sevenDaysDeaths'] = parseData(jsonFile, country, 'new_cases_smoothed')
    buffer['icu'] = parseData(jsonFile, country, 'icu_patients')
    buffer['hospital'] = parseData(jsonFile, country, 'hosp_patients')
    buffer['tests'] = parseData(jsonFile, country, 'new_tests')
    buffer['sevenDaysTests'] = parseData(jsonFile, country, 'new_tests_smoothed')
    buffer['sevenDaysPositiveRate'] = parseData(jsonFile, country, 'positive_rate')
    buffer['vaccinations'] = parseData(jsonFile, country, 'new_vaccinations')
    buffer['sevenDaysVaccinations'] = parseData(jsonFile, country, 'new_vaccinations_smoothed')
    buffer['icu'] = parseData(jsonFile, country, 'icu_patients')
    

    return buffer


def parseJSON(jsonFile):
    parsedJSON = {}
    countries = []

    for key, value in jsonFile.items():
        countries.append(key)

    for country in countries:
        parsedJSON[country] = parseValues(jsonFile, country)
        
    return parsedJSON

def resultedJSON(parsedJSON):
    with open('Data/data.json', 'w') as outfile:
        json.dump(parsedJSON, outfile)

def main():
    jsonFile = downloadJSON()
    parsedJSON = parseJSON(jsonFile)
    resultedJSON(parsedJSON)

main()
