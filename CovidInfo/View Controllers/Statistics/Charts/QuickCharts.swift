//
//  TodaysCharts.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.05.2022.
//

import SwiftUI
import SwiftUICharts

struct QuickCharts: View {
    @ObservedObject var currentData: CurrentData
    @ObservedObject var historicData: HistoricData

    var body: some View{
    let sevenDaysCases = dictionaryToDoubleArray(dictionary: historicData.sevenDaysCases!)
    let sevenDaysDeaths = dictionaryToDoubleArray(dictionary: historicData.sevenDaysDeaths!)

    HStack{
        LineChartView(data: sevenDaysCases,
                   title: "Cazuri noi",
                   legend: "Astazi: " + String(currentData.new_cases),
                   style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), dropShadow: true)
        .disabled(true)

        LineChartView(data: sevenDaysDeaths,
                   title: "Decese noi",
                   legend: "Astazi: " + String(currentData.new_deaths) ,
                   style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), dropShadow: true)
        .disabled(true)
        }
    }
}
