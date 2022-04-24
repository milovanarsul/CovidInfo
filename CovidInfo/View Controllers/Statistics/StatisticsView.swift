//
//  StatisticsGraphs.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.04.2022.
//

import SwiftUI
import SwiftUICharts
import CoreData

struct QuickGraphs: View {
    @Environment(\.managedObjectContext) var context
    
    var body: some View{
        
        let request = StatisticsData.fetchRequest() as NSFetchRequest<StatisticsData>
        let response = try! context.fetch(request)
        let statisticsData = response[0]
        
        HStack{
            LineChartView(data: statisticsData.casesForTheLastSevenDays!, title: "Cazuri noi", legend: "Astazi: \(statisticsData.todaysNewCases)", style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: getPercentage(array: statisticsData.casesForTheLastSevenDays!), dropShadow: false)
            LineChartView(data: statisticsData.deathsForTheLastSevenDays!, title: "Decese", legend: "Astazi: \(statisticsData.todaysNewDeaths)", style: ChartStyle(backgroundColor: .white, accentColor: .yellow, secondGradientColor: .green, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: getPercentage(array: statisticsData.deathsForTheLastSevenDays!), dropShadow: false)
        }
    }
}

struct Graphs: View {
    
    @Environment(\.managedObjectContext) var context
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .white
    }
    
    var body: some View {
        
        let request = StatisticsData.fetchRequest() as NSFetchRequest<StatisticsData>
        let response = try! context.fetch(request)
        let statisticsData = response[0]
        
        ScrollView(axes: .vertical, showsIndicators: false, offsetChanged: {delegates.main.scrollAnimation(size: -$0.y)}){
            VStack(spacing: 15){
                Text("Astazi")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: -130, y: 10)
                
                QuickGraphs()
                
                Text("Ultimele 7 zile")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: -85, y: 3)
                
                let sevenDaysConfirmedCasesWithDates = dictionaryToTuple(array: statisticsData.sevenDaysConfirmedCasesWithDates!)
                let sevenDaysDeathsWithDates = dictionaryToTuple(array: statisticsData.sevenDaysDeathsWithDates!)
                
                BarChartView(data: ChartData(values: sevenDaysConfirmedCasesWithDates), title: "Cazuri", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: sevenDaysDeathsWithDates), title: "Decese", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.green, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                Text("Luna Aprilie")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: -97, y: 3)
                
                let casesForThePastMonth = dictionaryToTuple(array: statisticsData.casesForThePastMonth!)
                let deathsForThePastMonth = dictionaryToTuple(array: statisticsData.deathsForThePastMonth!)
                                
                BarChartView(data: ChartData(values: casesForThePastMonth), title: "Cazuri", style: ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.blue, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: deathsForThePastMonth), title: "Decese", style: ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.purple, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                Text("Incidenta in ultimele 14 zile")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: 0, y: 3)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: 360, height: 520, alignment: .center)
                    List{
                        HStack(alignment: .center){
                            Text("Judet")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text("Incidenta")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                            
                        }
                        ForEach(statisticsData.incidence!.sorted(by: {$0.0 < $1.0}), id: \.key) { key, value in
                            HStack{
                                Text(key)
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                                
                                _HSpacer()
                                
                                Text("\(value, specifier: "%.2f")")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .background(.clear)
                    .frame(width: 360, alignment: .center)
                    .listRowInsets(EdgeInsets())
                    .menuIndicator(.hidden)
                }
            }
            .offset(y: 0)
            
            Text("De la inceputul pandemiei")
                .font(.title)
                .bold()
                .foregroundColor(.black)
                .offset(x: -3, y: 3)
            
            VStack(alignment: .leading){
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 180, height: 150, alignment: .center)
                        Text("Cazuri\n\(statisticsData.totalNumberOfCases)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 180, height: 150, alignment: .center)
                        Text("Decese\n\(statisticsData.totalNumberDeceased)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                    }
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: 180, height: 150, alignment: .center)
                    Text("Vindecati\n\(statisticsData.totalNumberCured)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                }
            }
        }
        .background(Color.clear)
        .cornerRadius(24)
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct StatisticsGraphs_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Graphs()
            QuickGraphs()
        }
    }
}
