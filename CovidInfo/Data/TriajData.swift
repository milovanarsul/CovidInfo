//
//  TriajData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.02.2022.
//

import Foundation
import UIKit

class TriajData{
    var image: String
    var title: String
    var titleColor: UIColor? = .black
    var subViewType: TriajType
    var subView: Any!
    var actionType: TriajAction
    var actionTitle: Any!
    var actionForeground: UIColor!
    var actionColour: UIColor!
    
    init(image: String, title: String, titleColor: UIColor? = nil, subViewType: TriajType, subView: Any? = nil, actionType: TriajAction, actionTitle: Any? = nil, actionForegorund: UIColor? = nil, actionColor: UIColor? = nil){
        self.image = image
        self.title = title
        
        if let titleColor = titleColor {
            self.titleColor = titleColor
        }
        
        self.subViewType = subViewType
        
        if let subView = subView {
            self.subView = subView
        }
    
        self.actionType = actionType
        
        if let actionTitle = actionTitle {
            self.actionTitle = actionTitle
        }
        
        if let actionForegorund = actionForegorund {
            self.actionForeground = actionForegorund
        }
        
        if let actionColor = actionColor {
            self.actionColour = actionColor
        }
    }
}

var triajData = [
    TriajData(image: "triaj1", title: "Triaj epidemiologic", subViewType: .intro, subView: [("list.number", "Vei respunde la cateva intrebari despre simptomele tale si contactul cu alte persoane"),("hand.raised", "Raspunsurile tale nu sunt partajate si analizate de catre nimeni.\nRezultatul acestui triaj este sters automat cand iesi din aplicatie"),("heart", "Recomandarile oferite de acest intrument nu constituie sfaturi medicale si nu ar trebui utilizate pentru a diagnostica sau trata afectiunile medicale!")], actionType: .button, actionTitle: "Am inteles", actionForegorund: .white, actionColor: UIColor("FFD167")),
    TriajData(image: "triaj2", title: "Este o urgenta?", titleColor: UIColor("D04545"), subViewType: .text, subView: "Opriti-va si sunati la 112 daca suferiti de: \nDurere sau presiune toracica severa\nDificultati extreme de respiratie\nAmeteala severa, constanta\nDezorientare grava sau lipsa de raspuns\nFata sau buze in nuante de albastru", actionType: .button, actionTitle: "Nu sufar de niciuna", actionForegorund: .white, actionColor: UIColor("D04545")),
    TriajData(image: "triaj3", title: "Care este varsta ta?", subViewType: .form, subView: ["Intre 18 si 65 de ani","Peste 65 de ani"], actionType: .buttonForm),
    TriajData(image: "triaj4", title: "In ultimele zile ai fost testat pentru COVID-19?", subViewType: .form, subView: ["Am fost testat si rezultatul este pozitiv", "Am fost testat si rezultatul este negativ", "Nu am fost testat in ultimele 10 zile"], actionType: .none),
    TriajData(image: "triaj5", title: "Ai avut parte de urmatoarele simptome?", subViewType: .text, subView: "Febra sau frisoane\nDificultati de respiratie\nTuse\nPierderea gustului sau a mirosului\nGat uscat\nVomitat sau diaree", actionType: .buttonStack),
    TriajData(image: "triaj6", title: "Se aplica vreuna dintre acestea asupra ta?", subViewType: .text, subView: "Obezitate\nFumat sau vaping\nSarcina\nDiabet, tensiune arteriala mare\nAstm, bronsita\nBoli ale inimii\nSistem imunitar slabit", actionType: .buttonStack),
    TriajData(image: "triaj7", title: "Totul pare in regula!", subViewType: .finish, actionType: .button, actionTitle: "Reda testul", actionColor: UIColor("28429E")),
    TriajData(image: "triaj8", title: "Cere ajutor!", titleColor: UIColor("D04545"), subViewType: .text, subView: "Daca ai simptome sau daca ai nevoie de informatii cu privire la transimiterea si raspandirea virusului, te rugam sa apelezi numarul 0800.800.358.\nDaca consideri ca situatia ta este una grava, apeleaza 112!", actionType: .button, actionTitle: "Reda testul", actionColor: UIColor("28429E"))
]
