//
//  StatisticsCharts.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 19.05.2022.
//

import SwiftUI
import SwiftUICharts

struct TodayData: View {
    
    @ObservedObject var currentData: CurrentData
    @ObservedObject var historicData: HistoricData
    
    var body: some View {
        
        let cases = String(currentData.new_cases)
        let sevenDaysCases = dictionaryToDoubleArray(dictionary: historicData.sevenDaysCases!)
        let deaths = String(currentData.new_deaths)
        let sevenDaysDeaths = dictionaryToDoubleArray(dictionary: historicData.sevenDaysDeaths!)
        
        ScrollView {
            HStack{
                LineChartView(data: sevenDaysCases,
                              title: "Cazuri noi",
                              legend: "Astazi: " + cases,
                              style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), dropShadow: true)
                    .disabled(true)
                
                LineChartView(data: sevenDaysDeaths,
                              title: "Decese noi",
                              legend: "Astazi: " + deaths,
                              style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), dropShadow: true)
                    .disabled(true)
            }
        }
        
    }
}
