//
//  WebScraper.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.04.2022.
//
import Foundation
import SwiftSoup
import PDFKit

func digi24(articleCount: Int) async -> [Article]?{
    var articleData: [Article] = []
    let url = URL(string: "https://www.digi24.ro/eticheta/coronavirus")!
    do {
        let html = try String(contentsOf: url)
        let document: Elements = try SwiftSoup.parse(html).select("article")
        let articlesArray = document.array()
        
        for index in 0...articleCount{
            let article: Element = articlesArray[index]
            let data = Article(viewMode: .card, backgroundImage: "", backgroundType: .light, date: "", link: "", title: "", description: "", author: "", isTrusted: false)
            let a = try article.select("a").first()!
            data.title = try a.attr("title")
            data.link = try a.attr("href")
            data.backgroundImage = try article.select("img").first()!.attr("src")
            
            let articleURL = URL(string: "https://www.digi24.ro" + data.link)!
            let articleHTML = try String(contentsOf: articleURL)
            let articleDocument: Elements = try SwiftSoup.parse(articleHTML).select("main")
            let div: Element = try articleDocument.select("div.entry").first()!
            let p = try div.select("p")
            
            var contents: [String] = []
            for line: Element in p.array(){
                contents.append(try line.text())
            }
            
            for index in 0...contents.count - 2{
                data.description += contents[index] + "\n"
            }
            
            data.author = contents[contents.count - 1]
            
            let timeDiv: Element = try articleDocument.select("div.author-meta").first()!
            let span = try timeDiv.select("span").first()!
            let date = try span.text()
            data.date = date
            articleData.append(data)
        }
        
        return articleData
    } catch Exception.Error(let type, let message) {
        print(message, type)
        return nil
    } catch {
        print("error")
        return nil
    }
}

func stiriOficiale() async -> [Article]?{
    var articleData: [Article] = []
    let url = URL(string: "https://stirioficiale.ro/informatii")!
    do {
        let html = try String(contentsOf: url)
        let document: Elements = try SwiftSoup.parse(html).select("article")
        let articlesArray = document.array()
        
        for article in articlesArray {
            let data = Article(viewMode: .card, backgroundImage: "", backgroundType: .light, date: "", link: "", title: "", description: "", author: "", isTrusted: true)
            
            data.date = try article.select("time").first()!.text()
            
            let h1 = try article.select("a").first()!
            let articleLink = try h1.attr("href")
            
            data.title = try h1.text()
            data.link = articleLink
            
            let articleURL = URL(string: data.link)!
            let articleHTML = try String(contentsOf: articleURL)
            let articleDocument: Elements = try SwiftSoup.parse(articleHTML).select("main")
            let div: Element = try articleDocument.select("div.my-8").first()!
            let p = try div.select("p")
            
            for text: Element in p.array() {
                data.description += try text.text() + "\n"
            }
            
            articleData.append(data)
        }
        return articleData
    } catch Exception.Error(_, _) {
        return nil
    } catch {
        return nil
    }
}

func parseMSPDF() -> [String.SubSequence]?{
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

func getMSPressBulletin() -> BuletinPresaMS{
    let pdfContent = parseMSPDF()!
    return BuletinPresaMS(pacientiReinfectati: String(pdfContent[8]), numarPersoaneInternate: String(pdfContent[97]), ati: String(pdfContent[99]), rtpcr: String(pdfContent[286]), antigen: String(pdfContent[289]), totalTestePCR: String(pdfContent[290]), totalTesteAntigen: String(pdfContent[291]))
}

