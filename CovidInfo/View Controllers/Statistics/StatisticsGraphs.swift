//
//  StatisticsGraphs.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.04.2022.
//

import SwiftUI
import SwiftUICharts
import Collections
import OrderedCollections

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct ScrollView<Content: View>: View {
    let axes: Axis.Set
    let showsIndicators: Bool
    let offsetChanged: (CGPoint) -> Void
    let content: Content

    init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        SwiftUI.ScrollView(axes, showsIndicators: showsIndicators) {
            GeometryReader { geometry in
                Color.clear.preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: geometry.frame(in: .named("scrollView")).origin
                )
            }.frame(width: 0, height: 0)
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}

struct QuickGraphs: View {
    @State var statisticsData: StatisticsData = parseStatisticsJSON()!
    
    var body: some View{
        HStack{
            LineChartView(data: statisticsData.casesForTheLastSevenDays, title: "Cazuri noi", legend: "Astazi: \(statisticsData.todaysNewCases)", style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: statisticsData.getPercentage(array: statisticsData.casesForTheLastSevenDays), dropShadow: false)
            LineChartView(data: statisticsData.deathsForTheLastSevenDays, title: "Decese", legend: "Astazi\(statisticsData.todaysNewDeaths)", style: ChartStyle(backgroundColor: .white, accentColor: .yellow, secondGradientColor: .green, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: statisticsData.getPercentage(array: statisticsData.deathsForTheLastSevenDays), dropShadow: false)
        }
    }
}

struct Graphs: View {
    @State var statisticsData: StatisticsData = parseStatisticsJSON()!
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .white
    }
    
    var body: some View {
        ScrollView(axes: .vertical, showsIndicators: false, offsetChanged: {delegates.main.scrollAnimation(size: -$0.y)}){
            VStack(spacing: 15){
                Text("Astazi")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: -130, y: 10)
                
                HStack{
                    LineChartView(data: statisticsData.casesForTheLastSevenDays, title: "Cazuri noi", legend: "\(statisticsData.todaysNewCases)", style: ChartStyle(backgroundColor: .white, accentColor: .white, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: statisticsData.getPercentage(array: statisticsData.casesForTheLastSevenDays), dropShadow: false)
                    LineChartView(data: statisticsData.deathsForTheLastSevenDays, title: "Decese", legend: "\(statisticsData.todaysNewDeaths)", style: ChartStyle(backgroundColor: .white, accentColor: .yellow, secondGradientColor: .green, textColor: .black, legendTextColor: .black, dropShadowColor: .white), rateValue: statisticsData.getPercentage(array: statisticsData.deathsForTheLastSevenDays), dropShadow: false)
                }
                
                Text("Ultimele 7 zile")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: -85, y: 3)
                
                BarChartView(data: ChartData(values: statisticsData.sevenDaysConfirmedCasesWithDates), title: "Cazuri", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: statisticsData.sevenDaysDeathsWithDates), title: "Decese", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.green, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                Text("Luna Aprilie")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: -97, y: 3)
                                
                BarChartView(data: ChartData(values: statisticsData.casesForThePastMonth), title: "Cazuri", style: ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.blue, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: statisticsData.deathsForThePastMonth), title: "Decese", style: ChartStyle(backgroundColor: .white, accentColor: .green, gradientColor: GradientColors.purple, textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
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
                        ForEach(statisticsData.incidence.sorted(by: {$0.0 < $1.0}), id: \.key) { key, value in
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
