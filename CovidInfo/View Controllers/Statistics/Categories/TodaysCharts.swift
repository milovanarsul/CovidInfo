//
//  StatisticsCharts.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 19.05.2022.
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

struct TodaysCharts: View {
    
    @ObservedObject var currentData: CurrentData
    @ObservedObject var historicData: HistoricData
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let sevenDaysCases = dictionaryToDoubleArray(dictionary: historicData.sevenDaysCases!)
        let sevenDaysDeaths = dictionaryToDoubleArray(dictionary: historicData.sevenDaysDeaths!)
        let sevenDaysCasesTuple = dictionaryToTuple(dictionary: historicData.sevenDaysCases!)
        let sevenDaysDeathsTuple = dictionaryToTuple(dictionary: historicData.sevenDaysDeaths!)
        
        let totalCases = String(format: "%.0f", locale: Locale.current, currentData.total_cases)
        let totalDeaths = String(format: "%.0f", locale: Locale.current, currentData.total_deaths)
        let totalCasesPerMillion = String(format: "%.0f", locale: Locale.current, currentData.total_cases_per_million)
        let totalDeathsPerMillion = String(format: "%.0f", locale: Locale.current, currentData.total_deaths_per_million)
        let totalTests = String(format: "%.0f", locale: Locale.current, currentData.total_tests)
        let totalTestsPerThousand = String(format: "%.0f", locale: Locale.current, currentData.total_tests_per_thousand)
        let totalVaccinations = String(format: "%.0f", locale: Locale.current, currentData.total_vaccinations)
        let totalBoosters = String(format: "%.0f", locale: Locale.current, currentData.total_boosters)
        let totalVaccinationsPerHundred = String(format: "%.0f", locale: Locale.current, currentData.total_vaccinations_per_hundred)
        let totalBoostersPerHundred = String(format: "%.0f", locale: Locale.current, currentData.total_boosters_per_hundred)
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
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
                
                Spacer()
                    .frame(width: screenWidth, height: 20, alignment: .center)
                
                BarChartView(data: ChartData(values: sevenDaysCasesTuple), title: "Cazuri in ultime 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                BarChartView(data: ChartData(values: sevenDaysDeathsTuple), title: "Decese in ultime 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                
                /*
                if let sevenDaysTests = historicData.sevenDaysTests {
                    let data = dictionaryToTuple(dictionary: sevenDaysTests)
                    BarChartView(data: ChartData(values: data), title: "Teste in ultime 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                }
                
                if let sevenDaysPositiveRate = historicData.sevenDaysPositiveRate {
                    let data = dictionaryToTuple(dictionary: sevenDaysPositiveRate)
                    BarChartView(data: ChartData(values: data), title: "Rata in ultime 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                }
                
                if let sevenDaysVaccinations = historicData.sevenDaysVaccinations {
                    let data = dictionaryToTuple(dictionary: sevenDaysVaccinations)
                    BarChartView(data: ChartData(values: data), title: "Vaccinari in ultime 7 zile", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), form: ChartForm.extraLarge, dropShadow: false, animatedToBack: true)
                }
                */
                
                VStack(alignment: .center, spacing: 15){
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Cazuri totale")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -40, bottom: 90, trailing: 5))
                            
                            Text(totalCases)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Decese totale")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -40, bottom: 90, trailing: 5))
                            
                            Text(totalDeaths)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                    }
                    
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Cazuri totale\nper milion")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -40, bottom: 70, trailing: 5))
                            
                            Text(totalCasesPerMillion)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Decese totale\nper milion")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -40, bottom: 70, trailing: 5))
                            
                            Text(totalDeathsPerMillion)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                    }
                    
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Teste totale")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -50, bottom: 90, trailing: 5))
                            
                            Text(totalTests)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Teste totale\nper mia de\nlocuitori")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -50, bottom: 50, trailing: 5))
                            
                            Text(totalTestsPerThousand)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                    }
                    
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Vaccinari totale")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -20, bottom: 90, trailing: 5))
                            
                            Text(totalVaccinations)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -30, bottom: 0, trailing: 5))
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Vaccinari totale\nper suta de\nlocuitori")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -25, bottom: 60, trailing: 5))
                            
                            Text(totalVaccinationsPerHundred)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                    }
                    
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Boostere totale")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -20, bottom: 90, trailing: 5))
                            
                            Text(totalBoosters)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.white)
                                .frame(width: screenWidth / 2 - 15, height: 150)
                            
                            Text("Boostere totale\nper suta de\nlocuitori")
                                .font(.title3)
                                .bold()
                                .padding(EdgeInsets(top: 5, leading: -25, bottom: 50, trailing: 5))
                            
                            Text(totalBoostersPerHundred)
                                .font(.title)
                                .bold()
                                .padding(EdgeInsets(top: 70, leading: -40, bottom: 0, trailing: 5))
                        }
                    }
                }
            }
        }
        .background(.clear)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        
    }
}

struct StatisticsCharts_Previews: PreviewProvider {
    static var previews: some View {
        TodaysCharts(currentData: CurrentData(), historicData: HistoricData())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
