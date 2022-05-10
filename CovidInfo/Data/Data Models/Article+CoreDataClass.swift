//
//  Article+CoreDataClass.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 06.05.2022.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {

}

func customArticle(title: String, contents: String, image: String){
    let article = Article(context: context)
    article.viewMode = .card
    article.backgroundType = .light
    article.isTrusted = false
    article.title = title
    article.link = nil
    article.backgroundImage = image
    article.articleDescription = contents
    article.author = nil
    article.date = nil
    article.isVariant = true
    
    try! context.save()
}
