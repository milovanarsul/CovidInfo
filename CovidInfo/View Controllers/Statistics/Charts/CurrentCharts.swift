//
//  TodaysCharts.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.05.2022.
//

import SwiftUI
import SwiftUICharts

struct CasesAndDeaths: View {
    @ObservedObject var currentData: CurrentData
    @ObservedObject var historicData: HistoricalData

    var body: some View{
    
    let sevenDaysCases = dictionaryToDoubleArray(dictionary: historicData.sevenDaysCases!)
    let sevenDaysDeaths = dictionaryToDoubleArray(dictionary: historicData.sevenDaysDeaths!)

    HStack{
        LineChartView(data: sevenDaysCases,
                   title: "Cazuri noi",
                   legend: "Astazi: " + String(Int(currentData.new_cases)),
                      style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), rateValue: percentageIncrease(value1: Int(currentData.new_cases), value2: Int(sevenDaysCases.first!)), dropShadow: true)
        .disabled(true)

        LineChartView(data: sevenDaysDeaths,
                   title: "Decese noi",
                   legend: "Astazi: " + String(Int(currentData.new_deaths)) ,
                      style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.green, textColor: .black, legendTextColor: .black, dropShadowColor: .clear),
                      rateValue: percentageIncrease(value1: Int(currentData.new_cases), value2: Int(sevenDaysDeaths.first!)),
                      dropShadow: true)
        .disabled(true)
        }
    }
}

struct SevenDaysCharts: View {
    @ObservedObject var currentData: CurrentData
    @ObservedObject var historicData: HistoricalData
    
    var body: some View{
    
        let sevenDaysCases = dictionaryToTuple(dictionary: historicData.sevenDaysCases!)
        let sevenDaysDeaths = dictionaryToTuple(dictionary: historicData.sevenDaysDeaths!)
        
        let test1 = dictionaryToTuple(dictionary: (DataManager.historicData?.first?.value.cases?.all!)!)
        let test2 = dictionaryToTuple(dictionary: (DataManager.historic2021Data?.first?.value.cases?.all!)!)
        let test3 = dictionaryToTuple(dictionary: (DataManager.historic2020Data?.first?.value.cases?.all!)!)
        let test = [test1, test2, test3].flatMap {$0}
        
        VStack{
            BarChartView(data: ChartData(values: sevenDaysCases), title: "Cazuri in ultimele 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: false)
            
            BarChartView(data: ChartData(values: sevenDaysDeaths), title: "Decese in ultimele 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
        }
        .background(.clear)
        .padding(EdgeInsets(top: 0, leading: -7, bottom: 0, trailing: -7))
    }
}
