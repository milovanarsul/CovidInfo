//
//  AllHistoricData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.06.2022.
//

import SwiftUI
import SwiftUICharts

struct AllHistoricData: View {
    
    @ObservedObject var countryCompare: CountryCompare
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 20){
                if countryCompare.cases.shouldShow{
                    LineView(data: countryCompare.cases.data, xAxisData: countryCompare.cases.axisData, title: "Cazuri", legend: "Total: \(countryCompare.cases.total!)", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), shouldAnimate: false)
                        .frame(width: 360, height: 450)
                }
            
                if countryCompare.deaths.shouldShow{
                    LineView(data: countryCompare.deaths.data, xAxisData: countryCompare.deaths.axisData, title: "Decese", legend: "Total: \(countryCompare.deaths.total!)", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), shouldAnimate: false)
                        .frame(width: 360, height: 450)
                }
                
                if countryCompare.vaccinations.shouldShow{
                    LineView(data: countryCompare.vaccinations.data, xAxisData: countryCompare.vaccinations.axisData, title: "Vaccinari", legend: "Total: \(countryCompare.vaccinations.total!)", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), shouldAnimate: false)
                        .frame(width: 360, height: 450)
                }
                
                if countryCompare.tests.shouldShow{
                    LineView(data: countryCompare.tests.data, xAxisData: countryCompare.tests.axisData, title: "Teste", legend: "Total: \(countryCompare.tests.total!)", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), shouldAnimate: false)
                        .frame(width: 360, height: 450)
                }
                
                if countryCompare.hospital.shouldShow{
                    LineView(data: countryCompare.hospital.data, xAxisData: countryCompare.hospital.axisData, title: "Hospitalizari", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), shouldAnimate: false)
                        .frame(width: 360, height: 450)
                }
                
                if countryCompare.icu.shouldShow{
                    LineView(data: countryCompare.icu.data, xAxisData: countryCompare.icu.axisData, title: "Terapie intensiva", style: ChartStyle(backgroundColor: .white, accentColor: .red, gradientColor: GradientColors.orange, textColor: .black, legendTextColor: .black, dropShadowColor: .clear), shouldAnimate: false)
                        .frame(width: 360, height: 450)
                }
            }
            .offset(x: -20, y: 0)
        }
    }
}
