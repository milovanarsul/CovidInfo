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
        
        ScrollView(.vertical, showsIndicators: false){
        }
    
    /*
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
       */
    }
}

struct SevenDaysCharts: View {
    @ObservedObject var currentData: CurrentData
    @ObservedObject var historicData: HistoricalData
    
    var body: some View{
        
        ScrollView(.vertical, showsIndicators: false){
        }
        
        /*
        let sevenDaysCases = dictionaryToTuple(dictionary: historicData.sevenDaysCases!)
        let sevenDaysDeaths = dictionaryToTuple(dictionary: historicData.sevenDaysDeaths!)
        
        VStack{
            BarChartView(data: ChartData(values: sevenDaysCases), title: "Cazuri in ultimele 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
            
            BarChartView(data: ChartData(values: sevenDaysDeaths), title: "Decese in ultimele 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
        }
        .background(.clear)
        .padding(EdgeInsets(top: 0, leading: -7, bottom: 0, trailing: -7))
         */
    }
}
