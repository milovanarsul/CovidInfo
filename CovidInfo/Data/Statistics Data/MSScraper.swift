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

func parsePDF() -> [String.SubSequence]?{
    if let pdf = PDFDocument(url: URL(string: "https://www.ms.ro/wp-content/uploads/2022/04/Buletin-de-presa-13.04.2022.pdf")!) {
        let pageCount = pdf.pageCount
        let documentContent = NSMutableAttributedString()
        
        for index in 0..<pageCount {
            guard let page = pdf.page(at: index) else {continue}
            guard let pageContent = page.attributedString else {continue}
            documentContent.append(pageContent)
        }
        
        let content = documentContent.string
        let eliminateText = content.filter("0123456789 ".contains)
        let eliminateWhiteSpace = eliminateText.split(whereSeparator: \.isWhitespace)
        
        return eliminateWhiteSpace
    }
    
    return nil
}

func getBuletinPresa() -> BuletinPresaMS{
    let pdfContent = parsePDF()!
    return BuletinPresaMS(pacientiReinfectati: String(pdfContent[8]), numarPersoaneInternate: String(pdfContent[97]), ati: String(pdfContent[99]), rtpcr: String(pdfContent[286]), antigen: String(pdfContent[289]), totalTestePCR: String(pdfContent[290]), totalTesteAntigen: String(pdfContent[291]))
}

