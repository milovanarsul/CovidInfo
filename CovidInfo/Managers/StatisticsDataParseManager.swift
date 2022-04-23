//
//  ParseStatisticsData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.04.2022.
//

import Foundation

struct CovidData: Codable {
    var currentDayStats: CurrentDayStats
    var historicalData: [String: HistoricalData]
}

struct CurrentDayStats: Codable {
    var parsedOnString: String
    var averageAge: String
    var numberInfected: Int
    var numberCured: Int
    var numberDeceased: Int
    var percentageOfWomen: Double
    var percentageOfMen: Double
    var percentageOfChildren: Double
    var numberTotalDosesAdministered: Int
    var distributionByAge: [String : Int]
    var countyInfectionsNumbers: [String : Int]
    var incidence: [String : Double]
}

struct HistoricalData: Codable {
    var parsedOnString: String
    var numberInfected: Int
    var numberCured: Int
    var numberDeceased: Int
    var numberTotalDosesAdministered: Int
    var distributionByAge: [String : Int]
    //var vaccines: Vaccines
}

func parseStatisticsJSON(){
    let urlString = "https://d35p9e4fm9h3wo.cloudfront.net/smallData.json"
    if let url = URL(string: urlString){
        if let data = try? Data(contentsOf: url){
            do {
                let stats = try JSONDecoder().decode(CovidData.self, from: data)
                createDataAssets(currentDayStats: stats.currentDayStats, historicalData: stats.historicalData)
            } catch {
                print(error)
            }
        }
    }
}

func getNumberdaysGraph(array: [Any], days: Int) -> [Any]{
    var daysArray = [Any]()
    for index in 0..<days{
        daysArray.append(array[index])
    }
    return daysArray
}

enum typeOfCase {
    case cases
    case recovered
    case deaths
}

func mergeDataArrays(currentDayStats: CurrentDayStats, historicalData: [Dictionary<String, HistoricalData>.Element], typeOfCase: typeOfCase) -> [Double]{
    var array = [Double]()
    
    switch typeOfCase {
    case .cases:
        array = [Double(currentDayStats.numberInfected)]
    case .recovered:
        array = [Double(currentDayStats.numberCured)]
    case .deaths:
        array = [Double(currentDayStats.numberDeceased)]
    }
    
    for (_, value) in historicalData {
        switch typeOfCase {
        case .cases:
            array.append(Double(value.numberInfected))
        case .recovered:
            array.append(Double(value.numberCured))
        case .deaths:
            array.append(Double(value.numberDeceased))
        }
    }
    
    return array
}

func getCasesForDays(currentDayStats: CurrentDayStats, historicalData: [Dictionary<String, HistoricalData>.Element], typeOfCase: typeOfCase, days: Int) -> [Double]{
    var array = [Double]()
    
    switch typeOfCase {
    case .cases:
        array = [Double(currentDayStats.numberInfected) - Double(historicalData[1].value.numberInfected)]
    case .recovered:
        array = [Double(currentDayStats.numberCured) - Double(historicalData[1].value.numberCured)]
    case .deaths:
        array = [Double(currentDayStats.numberDeceased) - Double(historicalData[1].value.numberDeceased)]
    }
    
    for index in 0...days {
        if index + 1 < days{
            switch typeOfCase {
            case .cases:
                array.append(Double(historicalData[index].value.numberInfected - historicalData[index+1].value.numberInfected))
            case .recovered:
                array.append(Double(historicalData[index].value.numberCured - historicalData[index+1].value.numberCured))
            case .deaths:
                array.append(Double(historicalData[index].value.numberDeceased - historicalData[index+1].value.numberDeceased))
            }
        }
    }
    
    array.remove(at: days-1)
    return array
}

func casesWithValues(currentDayStats: CurrentDayStats, historicalData: [Dictionary<String, HistoricalData>.Element], typeOfCase: typeOfCase, days: Int) -> [(String, Double)]{
    var array = [(String, Double)]()
    let currentDaydate = formatDate(date: currentDayStats.parsedOnString)
    
    switch typeOfCase {
    case .cases:
        array = [(currentDaydate, Double(currentDayStats.numberInfected - historicalData[1].value.numberInfected))]
    case .recovered:
        array = [(currentDaydate, Double(currentDayStats.numberCured - historicalData[1].value.numberCured))]
    case .deaths:
        array = [(currentDaydate, Double(currentDayStats.numberDeceased - historicalData[1].value.numberDeceased))]
    }
    
    for index in 0...days {
        if index + 1 < days{
            let historicalDataDate = formatDate(date: historicalData[index].value.parsedOnString)
            switch typeOfCase {
            case .cases:
                array.append((historicalDataDate, Double(historicalData[index].value.numberInfected - historicalData[index + 1].value.numberInfected)))
            case .recovered:
                array.append((historicalDataDate, Double(historicalData[index].value.numberCured - historicalData[index + 1].value.numberCured)))
            case .deaths:
                array.append((historicalDataDate, Double(historicalData[index].value.numberDeceased - historicalData[index + 1].value.numberDeceased)))
            }
        }
    }
    
    return array
}

func formatDate(date: String) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let formatedDate = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "dd-MM-yyyy"
    let resultedDate = dateFormatter.string(from: formatedDate!)
    
    return resultedDate
}

func stringDoubleTupleArray(array: [(String, Double)]) -> [StringDoubleTuple] {
    var resultedArray = [StringDoubleTuple]()
    
    for arrayItem in array{
        resultedArray.append(StringDoubleTuple(string: arrayItem.0, double: arrayItem.1))
    }
    
    return resultedArray
}

func stringDoubleTuple(object: [StringDoubleTuple]) -> [(String, Double)] {
    var resultedArray = [(String, Double)]()
    
    for it in object {
        resultedArray.append((it.string!, it.double!))
    }
    
    return resultedArray
}

func createDataAssets(currentDayStats: CurrentDayStats, historicalData: [String: HistoricalData]){
    let sortedHistoricalData = historicalData.sorted( by: {$0.1.parsedOnString > $1.1.parsedOnString})
    
    let todaysCases = currentDayStats.numberInfected - sortedHistoricalData[0].value.numberInfected
    let todaysDeaths = currentDayStats.numberDeceased - sortedHistoricalData[0].value.numberDeceased
    let todaysCured = todaysCases - todaysDeaths
    
    let totalNumberOfCases = currentDayStats.numberInfected
    let totalNumberDeceased = currentDayStats.numberDeceased
    let totalNumberCured = totalNumberOfCases - totalNumberDeceased
    
    let confirmedCasesValues: [Double] = mergeDataArrays(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .cases)
    let curedCasesValues: [Double] = mergeDataArrays(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .recovered)
    let mortalitiesValues: [Double] = mergeDataArrays(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .deaths)
    
    let confirmedCasesDays: [Double] = getCasesForDays(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .cases, days: 8)
    let deathsDays: [Double] = getCasesForDays(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .deaths, days: 8)
    
    let confirmedCasesSevenDays: [(String,Double)] = casesWithValues(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .cases, days: 7)
    let deathsSevenDays: [(String, Double)] = casesWithValues(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .deaths, days: 7)
    
    let daysIntoTheMonth: Int = Int(currentDayStats.parsedOnString.suffix(2))!
    let confirmedCasesCurrentMonth: [(String, Double)] = casesWithValues(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .cases, days: daysIntoTheMonth)
    let deathsCurrentMonth: [(String, Double)] = casesWithValues(currentDayStats: currentDayStats, historicalData: sortedHistoricalData, typeOfCase: .deaths, days: daysIntoTheMonth)
    
    var countyIncidence = [String : Double]()
    for (key, value) in currentDayStats.incidence{
        countyIncidence[counties[key]!] = value
    }
    
    let statisticsData = StatisticsData(context: context)
    statisticsData.todaysNewCases = Int64(todaysCases)
    statisticsData.todaysNewDeaths = Int64(todaysDeaths)
    statisticsData.todaysRecovered = Int64(todaysCured)
    statisticsData.totalNumberOfCases = Int64(totalNumberOfCases)
    statisticsData.totalNumberCured = Int64(totalNumberCured)
    statisticsData.totalNumberDeceased = Int64(totalNumberDeceased)
    statisticsData.allTimeConfirmedCasesValues = confirmedCasesValues
    statisticsData.allTimeCuredCasesValues = curedCasesValues
    statisticsData.allTimeMortalitiesValues = mortalitiesValues
    statisticsData.casesForTheLastSevenDays = confirmedCasesDays
    statisticsData.deathsForTheLastSevenDays = deathsDays
    statisticsData.sevenDaysConfirmedCasesWithDates = stringDoubleTupleArray(array: confirmedCasesSevenDays)
    statisticsData.sevenDaysDeathsWithDates = stringDoubleTupleArray(array: deathsSevenDays)
    statisticsData.casesForThePastMonth = stringDoubleTupleArray(array: confirmedCasesCurrentMonth)
    statisticsData.deathsForThePastMonth = stringDoubleTupleArray(array: deathsCurrentMonth)
    statisticsData.incidence = countyIncidence
    
    try! context.save()
}
