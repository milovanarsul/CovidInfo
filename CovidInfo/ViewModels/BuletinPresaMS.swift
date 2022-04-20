//
//  MSScraper.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.04.2022.
//

import Foundation
import PDFKit

class BuletinPresaMS{
    var pacientiReinfectati: String
    var numarPersoaneInternate: String
    var ati: String
    var rtpcr: String
    var antigen: String
    var totalTestePCR: String
    var totalTesteAntigen: String
    
    init(pacientiReinfectati: String, numarPersoaneInternate: String, ati: String, rtpcr: String, antigen: String, totalTestePCR: String, totalTesteAntigen: String){
        self.pacientiReinfectati = pacientiReinfectati
        self.numarPersoaneInternate = numarPersoaneInternate
        self.ati = ati
        self.rtpcr = rtpcr
        self.antigen = antigen
        self.totalTestePCR = totalTestePCR
        self.totalTesteAntigen = totalTesteAntigen
    }
    
    func print(){
        Swift.print("Pacienti reinfectati: \(pacientiReinfectati), Numar persoane internate: \(numarPersoaneInternate), ati: \(ati), pcr: \(rtpcr), antigen: \(antigen), total teste pcr: \(totalTestePCR), total teste antigen: \(totalTesteAntigen)")
    }
}
