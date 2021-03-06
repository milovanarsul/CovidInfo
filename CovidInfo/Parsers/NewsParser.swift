//
//  WebScraper.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.04.2022.
//
import Foundation
import SwiftSoup
import PDFKit

func digi24(articleCount: Int){
    let url = URL(string: "https://www.digi24.ro/eticheta/coronavirus")!
    do {
        let html = try String(contentsOf: url)
        let document: Elements = try SwiftSoup.parse(html).select("article")
        let articlesArray = document.array()
        
        for index in 0...articleCount{
            let article: Element = articlesArray[index]
            let data = Article(context: AppDelegate.context)
            
            data.viewMode = .card
            data.backgroundType = .light
            data.isTrusted = false
            data.isVariant = false
            
            let a = try article.select("a").first()!
            data.title = try a.attr("title")
            data.link = try a.attr("href")
            data.backgroundImage = try article.select("img").first()!.attr("src")
            
            let articleURL = URL(string: "https://www.digi24.ro" + data.link!)!
            let articleHTML = try String(contentsOf: articleURL)
            let articleDocument: Elements = try SwiftSoup.parse(articleHTML).select("main")
            let div: Element = try articleDocument.select("div.entry").first()!
            let p = try div.select("p")
            
            var contents: [String] = []
            for line: Element in p.array(){
                contents.append(try line.text())
            }
            var description = ""
            for index in 0...contents.count - 2{
                description += contents[index] + "\n"
            }
            data.articleDescription = description
            
            data.author = contents[contents.count - 1]
            
            let timeDiv: Element = try articleDocument.select("div.author-meta").first()!
            let span = try timeDiv.select("span").first()!
            let date = try span.text()
            data.date = stringToDate(string: date)
            
            try AppDelegate.context.save()
        }
    } catch Exception.Error(let type, let message) {
        print(message, type)
    } catch {
        print("error")
    }
}

func stiriOficiale(){
    let url = URL(string: "https://stirioficiale.ro/informatii")!
    do {
        let html = try String(contentsOf: url)
        let document: Elements = try SwiftSoup.parse(html).select("article")
        let articlesArray = document.array()
        
        for article in articlesArray {
            let data = Article(context: AppDelegate.context)
            
            data.viewMode = .card
            data.backgroundType = .light
            data.isTrusted = true
            data.isVariant = false
            
            data.date = stringToDate(string: "01.01.2020 00:00")
            
            let h1 = try article.select("a").first()!
            let articleLink = try h1.attr("href")
            
            data.title = try h1.text()
            data.link = articleLink
            
            let articleURL = URL(string: data.link!)!
            let articleHTML = try String(contentsOf: articleURL)
            let articleDocument: Elements = try SwiftSoup.parse(articleHTML).select("main")
            let div: Element = try articleDocument.select("div.my-8").first()!
            let p = try div.select("p")
            
            var description = ""
            for text: Element in p.array() {
                description += try text.text() + "\n"
            }
            data.articleDescription = description
            
            try AppDelegate.context.save()
        }
    } catch Exception.Error(let type, let message) {
        print(message, type)
    } catch {
        print("error")
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

