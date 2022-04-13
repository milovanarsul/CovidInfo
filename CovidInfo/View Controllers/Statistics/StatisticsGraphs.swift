//
//  StatisticsGraphs.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.04.2022.
//

import SwiftUI
import SwiftUICharts

struct TopGraphs: View {
    @State var statisticsData: StatisticsData = parseStatisticsJSON()!
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                HStack{
                    LineChartView(data: statisticsData.casesForTheLastSevenDays, title: "Cazuri noi", legend: "Astazi: \(statisticsData.todaysNewCases)", style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: statisticsData.getPercentage(array: statisticsData.casesForTheLastSevenDays), dropShadow: false)
                    LineChartView(data: statisticsData.deathsForTheLastSevenDays, title: "Decese", legend: "Astazi: \(statisticsData.todaysNewDeaths)", style: ChartStyle(backgroundColor: .white, accentColor: .yellow, secondGradientColor: .green, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: statisticsData.getPercentage(array: statisticsData.deathsForTheLastSevenDays), dropShadow: false)
                }
                
                BarChartView(data: ChartData(values: statisticsData.sevenDaysConfirmedCasesWithDates), title: "Cazuri in ultimele 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: statisticsData.sevenDaysDeathsWithDates), title: "Decese in utlimele 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.green, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: 360, height: 140, alignment: .center)
                    
                    Text("Statistici de la inceputul pandemiei")
                        .font(Font(boldFont(size: 18) as CTFont))
                        .foregroundColor(.black)
                        .offset(x: -6, y: -45)
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text("Cazuri confirmate: \(statisticsData.totalNumberOfCases)")
                            .font(Font(boldFont(size: 16) as CTFont))
                            .foregroundColor(.black)
                        Text("Vindecati: \(statisticsData.totalNumberCured)")
                            .font(Font(boldFont(size: 16) as CTFont))
                            .foregroundColor(.black)
                        Text("Decedati: \(statisticsData.totalNumberDeceased)")
                            .font(Font(boldFont(size: 16) as CTFont))
                            .foregroundColor(.black)
                    }
                    .offset(x: -45, y: 15)
                }
                
                BarChartView(data: ChartData(values: statisticsData.casesForThePastMonth), title: "Cazuri in luna Aprilie", style: ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.blue, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: statisticsData.deathsForThePastMonth), title: "Decese in luna Aprilie", style: ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.purple, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
            }
            .offset(y: 10)
        }
        .background(Color.clear)
        .cornerRadius(24)
        .offset(y: 10)
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct MiddleGraphs: View {
    @State var statisticsData: StatisticsData = parseStatisticsJSON()!
    
    var body: some View {
        VStack{
            
        }
    }
}

struct StatisticsGraphs_Previews: PreviewProvider {
    static var previews: some View {
        TopGraphs()
        MiddleGraphs()
    }
}
