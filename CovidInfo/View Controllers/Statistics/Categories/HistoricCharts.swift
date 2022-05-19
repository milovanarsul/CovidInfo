//
//  HistoricCharts.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 19.05.2022.
//

import SwiftUI
import SwiftUICharts

struct HistoricCharts: View {
    var body: some View {
        
        let historicData = manualHistoricData
    
        let casesPerMonth = dictionaryToTuple(dictionary:(historicData!.cases?.perMonth![month!])!)
        let deathsPerMonth = dictionaryToTuple(dictionary:(historicData!.deaths?.perMonth![month!])!)
        let icuPerMonth = dictionaryToTuple(dictionary:(historicData!.icu?.perMonth![month!])!)
        let hospitalPerMonth = dictionaryToTuple(dictionary:(historicData!.hospital?.perMonth![month!])!)
        let testsPerMonth = dictionaryToTuple(dictionary:(historicData!.tests?.perMonth![month!])!)
        let vaccinationsPerMonth = dictionaryToTuple(dictionary:(historicData!.vaccinations?.perMonth![month!])!)
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 20){
                BarChartView(data: ChartData(values: casesPerMonth), title: "Cazuri in luna " + month!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: deathsPerMonth), title: "Decese in luna " + month!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: icuPerMonth), title: "Pacienti ATI in luna " + month!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: hospitalPerMonth), title: "Pacienti internati in luna " + month!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: testsPerMonth), title: "Teste realizate in luna " + month!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: vaccinationsPerMonth), title: "Vaccinari in luna " + month!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
            }
        }
    }
}

struct HistoricCharts_Previews: PreviewProvider {
    static var previews: some View {
        HistoricCharts()
    }
}
