//
//  WebScraper.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.04.2022.
//
import Foundation
import SwiftSoup

func digi24(articleCount: Int) -> [Article]{
    var articleData: [Article] = []
    let url = URL(string: "https://www.digi24.ro/eticheta/coronavirus")!
    do {
        let html = try String(contentsOf: url)
        let document: Elements = try SwiftSoup.parse(html).select("article")
        let articlesArray = document.array()
        
        for index in 0...articleCount{
            let article: Element = articlesArray[index]
            let data = Article(viewMode: .card, backgroundImage: "", backgroundType: .light, date: "", link: "", title: "", description: "", author: "")
            let a = try article.select("a").first()!
            data.title = try a.attr("title")
            data.link = try a.attr("href")
            data.backgroundImage = try article.select("img").first()!.attr("src")
            
            let articleURL = URL(string: "https://www.digi24.ro" + data.link)!
            let articleHTML = try String(contentsOf: articleURL)
            let articleDocument: Elements = try SwiftSoup.parse(articleHTML).select("main")
            let div: Element = try articleDocument.select("div.entry").first()!
            let p = try div.select("p")
            
            var contents: String = ""
            for line: Element in p.array(){
                contents = contents + (try line.text()) + "\n"
            }
            data.description = contents
            articleData.append(data)
        }
    } catch Exception.Error(let type, let message) {
        print(message, type)
    } catch {
        print("error")
    }
    return articleData
}
