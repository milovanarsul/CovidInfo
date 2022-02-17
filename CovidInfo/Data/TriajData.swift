//
//  TriajData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.02.2022.
//

import Foundation
import UIKit

var riskPrecentage: Double = 0
let highRisk: Double = 2.5

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
    var actionSize: CGFloat!
    
    init(image: String, title: String, titleColor: UIColor? = nil, subViewType: TriajType, subView: Any? = nil, actionType: TriajAction, actionTitle: Any? = nil, actionForegorund: UIColor? = nil, actionColor: UIColor? = nil, actionSize: CGFloat){
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
        
        self.actionSize = actionSize
    }
}

var triajData = [
    TriajData(image: "triaj1", title: "Triaj epidemiologic", subViewType: .intro, subView: [("list.number", "Vei respunde la cateva intrebari despre simptomele tale si contactul cu alte persoane"),("hand.raised", "Raspunsurile tale nu sunt partajate si analizate de catre nimeni.\nRezultatul acestui triaj este sters automat cand iesi din aplicatie"),("heart", "Recomandarile oferite de acest intrument nu constituie sfaturi medicale si nu ar trebui utilizate pentru a diagnostica sau trata afectiunile medicale!")], actionType: .button, actionTitle: "Am inteles", actionForegorund: .white, actionColor: triajYellow, actionSize: actionNormal),
    TriajData(image: "triaj2", title: "Este o urgenta?", titleColor:triajRed, subViewType: .text, subView: "Opriti-va si sunati la 112 daca suferiti de: \n•Durere sau presiune toracica severa\n•Dificultati extreme de respiratie\n•Ameteala severa, constanta\n•Dezorientare grava sau lipsa de raspuns\n•Fata sau buze in nuante de albastru", actionType: .button, actionTitle: "Nu sufar de niciuna", actionForegorund: .white, actionColor: triajRed, actionSize: actionNormal),
    TriajData(image: "triaj3", title: "Care este varsta ta?", subViewType: .form, subView: [("Intre 18 si 65 de ani", 0.5),("Peste 65 de ani", 0.8)], actionType: .none, actionSize: actionSmall),
    TriajData(image: "triaj4", title: "In ultimele zile ai fost testat pentru COVID-19?", subViewType: .form, subView: [("Am fost testat si rezultatul este pozitiv", 1), ("Am fost testat si rezultatul este negativ", 0.1), ("Nu am fost testat in ultimele 10 zile", 0.5)], actionType: .none, actionSize: actionSmall),
    TriajData(image: "triaj5", title: "Ai avut parte de urmatoarele simptome?", subViewType: .text, subView: "•Febra sau frisoane\n•Dificultati de respiratie\n•Tuse\n•Pierderea gustului sau a mirosului\n•Gat uscat\n•Vomitat sau diaree", actionType: .buttonStack, actionSize: actionSmall),
    TriajData(image: "triaj6", title: "Se aplica vreuna dintre acestea asupra ta?", subViewType: .text, subView: "•Obezitate\n•Fumat sau vaping\n•Sarcina\n•Diabet, tensiune arteriala mare\n•Astm, bronsita\n•Boli ale inimii\n•Sistem imunitar slabit", actionType: .buttonStack, actionSize: actionSmall),
    TriajData(image: "triaj7", title: "Totul pare in regula!", subViewType: .finish, subView: PreventieAndSimptomeShortcut(), actionType: .button, actionTitle: "Reda testul", actionForegorund: .white, actionColor: signatureBlueDark, actionSize: actionNormal),
    TriajData(image: "triaj8", title: "Cere ajutor!", titleColor: triajRed, subViewType: .text, subView: "Daca ai simptome sau daca ai nevoie de\ninformatii cu privire la transimiterea si\nraspandirea virusului, te rugam sa apelezi\nnumarul 0800.800.358.\nDaca consideri ca situatia ta este una grava,\napeleaza 112!", actionType: .button, actionTitle: "Reda testul", actionForegorund: .white, actionColor: signatureBlueDark, actionSize: actionNormal)
]
