//
//  HistoricCharts.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 19.05.2022.
//

import SwiftUI
import SwiftUICharts

struct Historic2022Charts: View {
    @ObservedObject var historicData: HistoricalData
    
    var body: some View {
        
        let casesPerMonth = dictionaryToTuple(dictionary: (historicData.cases?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let deathsPerMonth = dictionaryToTuple(dictionary: (historicData.deaths?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let icuPerMonth = dictionaryToTuple(dictionary:(historicData.icu?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let hospitalPerMonth = dictionaryToTuple(dictionary:(historicData.hospital?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let testsPerMonth = dictionaryToTuple(dictionary:(historicData.tests?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let vaccinationsPerMonth = dictionaryToTuple(dictionary:(historicData.vaccinations?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 20){
                BarChartView(data: ChartData(values: casesPerMonth), title: "Cazuri in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: deathsPerMonth), title: "Decese in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: icuPerMonth), title: "Pacienti ATI in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: hospitalPerMonth), title: "Pacienti internati in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: testsPerMonth), title: "Teste realizate in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: vaccinationsPerMonth), title: "Vaccinari in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
            }
        }
    }
}

struct Historic2021Charts: View {
    @ObservedObject var historicData: OldHistoricalData
    
    var body: some View {
        let casesPerMonth = dictionaryToTuple(dictionary: (historicData.cases?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let deathsPerMonth = dictionaryToTuple(dictionary: (historicData.deaths?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let icuPerMonth = dictionaryToTuple(dictionary:(historicData.icu?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let hospitalPerMonth = dictionaryToTuple(dictionary:(historicData.hospital?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let testsPerMonth = dictionaryToTuple(dictionary:(historicData.tests?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let vaccinationsPerMonth = dictionaryToTuple(dictionary:(historicData.vaccinations?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 20){
                BarChartView(data: ChartData(values: casesPerMonth), title: "Cazuri in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: deathsPerMonth), title: "Decese in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: icuPerMonth), title: "Pacienti ATI in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: hospitalPerMonth), title: "Pacienti internati in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: testsPerMonth), title: "Teste realizate in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: vaccinationsPerMonth), title: "Vaccinari in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
            }
        }
    }
}

struct Historic2020Charts: View {
    @ObservedObject var historicData: OldHistoricalData
    
    var body: some View {
        
        let casesPerMonth = dictionaryToTuple(dictionary: (historicData.cases?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let deathsPerMonth = dictionaryToTuple(dictionary: (historicData.deaths?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let icuPerMonth = dictionaryToTuple(dictionary:(historicData.icu?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let hospitalPerMonth = dictionaryToTuple(dictionary:(historicData.hospital?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let testsPerMonth = dictionaryToTuple(dictionary:(historicData.tests?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        let vaccinationsPerMonth = dictionaryToTuple(dictionary:(historicData.vaccinations?.perMonth![selectedMonth!][romanianMonths[selectedMonth!]!])!)
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 20){
                BarChartView(data: ChartData(values: casesPerMonth), title: "Cazuri in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: deathsPerMonth), title: "Decese in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: icuPerMonth), title: "Pacienti ATI in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: hospitalPerMonth), title: "Pacienti internati in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: testsPerMonth), title: "Teste realizate in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: vaccinationsPerMonth), title: "Vaccinari in luna " + romanianMonths[selectedMonth!]!, style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
            }
        }
    }
}
