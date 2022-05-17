import json
from time import strftime
from urllib.request import urlopen
from datetime import datetime
from datetime import date

roDays = {
    "Monday" : "Luni",
    "Tuesday" : "Marti",
    "Wednesday" : "Miercuri",
    "Thursday" : "Joi",
    "Friday" : "Vineri",
    "Saturday" : "Sambata",
    "Sunday" : "Duminica"
}

roMonths = {
    "January" : "Ianuarie",
    "February" : "Februarie",
    "March" : "Matie",
    "April" : "Aprilie",
    "May" : "Mai",
    "June" : "Iunie",
    "July" : "Iulie",
    "August" : "August",
    "September" : "Septembrie",
    "October" : "Octombrie",
    "November" : "Noiembrie",
    "December" : "Decembrie"
}

today = date.today().strftime("%d-%m-%y")
currentMonth = datetime.strptime(today, '%d-%m-%y').strftime('%B')

def downloadJSON():
    json_file = urlopen("https://covid.ourworldindata.org/data/owid-covid-data.json")
    file = json.load(json_file)
    for key,value in file.items():
        statisticsData = file[key]['data']
        for data in list(statisticsData):
            for dataKey, dataValue in data.items():
                if dataKey == "date" and dataValue <= "2022-01-01":
                    statisticsData.remove(data)
    
    return file

def parseDataForMonth(dataList, month, dataKey):
    buffer = {}

    for data in dataList:
        if dataKey in data:
            date = datetime.strptime(data['date'], '%Y-%m-%d').strftime('%d-%m-%y')
            dataMonth = datetime.strptime(date, '%d-%m-%y').strftime('%B')

            if month == dataMonth and data[dataKey] != None:
                buffer[date] = data[dataKey]
    
    return buffer
    
def parseData(jsonFile, country, dataKey):
    statistic = {}
    buffer = {}

    key = jsonFile[country]
    dataList = list(key['data'])

    for (key,value) in roMonths.items():
        buffer[value] = parseDataForMonth(dataList, key, dataKey)

    for data in dataList:
        if dataKey in data:
            date = datetime.strptime(data['date'], '%Y-%m-%d').strftime('%d-%m-%y')
            statistic[date] = data[dataKey]

    buffer['All'] = statistic
    return buffer

def parseDataForWeek(jsonFile, country, dataKey):
    buffer = {}

    key = jsonFile[country]
    dataList = list(key['data'])
    dataList.reverse()

    if len(dataList) > 7:
        for index in range(0, 7):
            data = dataList[index]
            if dataKey in data:
                day = roDays[datetime.strptime(data['date'], '%Y-%m-%d').strftime('%A')]
                buffer[day] = data[dataKey]
    
    return buffer

def parseValues(jsonFile, country):
    buffer = {}

    buffer['cases'] = parseData(jsonFile, country, 'new_cases')
    buffer['sevenDaysCases'] = parseDataForWeek(jsonFile, country, 'new_cases')
    buffer['deaths'] = parseData(jsonFile, country, 'new_deaths')
    buffer['sevenDaysDeaths'] = parseDataForWeek(jsonFile, country, 'new_deaths')
    buffer['icu'] = parseData(jsonFile, country, 'icu_patients')
    buffer['hospital'] = parseData(jsonFile, country, 'hosp_patients')
    buffer['tests'] = parseData(jsonFile, country, 'new_tests')
    buffer['sevenDaysTests'] = parseDataForWeek(jsonFile, country, 'new_tests')
    buffer['sevenDaysPositiveRate'] = parseDataForWeek(jsonFile, country, 'positive_rate')
    buffer['vaccinations'] = parseData(jsonFile, country, 'new_vaccinations')
    buffer['sevenDaysVaccinations'] = parseDataForWeek(jsonFile, country, 'new_vaccinations')
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
    with open('Data/data2022.json', 'w') as outfile:
        json.dump(parsedJSON, outfile)

def main():
    jsonFile = downloadJSON()
    parsedJSON = parseJSON(jsonFile)
    resultedJSON(parsedJSON)

main()
