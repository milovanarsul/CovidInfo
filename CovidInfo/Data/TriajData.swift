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
    var mainLabel: String
    var hasBigTitle: Bool!
    var stack: [(String, String)]!
    var label: String!
    var hasButtons: Bool!
    var buttonLabels: [String]!
    var secondLabel: String!
    
    init(image: String, mainLabel: String, hasBigTitle: Bool, stack: [(String, String)]!){
        self.image = image
        self.mainLabel = mainLabel
        self.hasBigTitle = hasBigTitle
        self.stack = stack
    }
    
    init(image: String, mainLabel: String, hasBigTitle: Bool, label: String!){
        self.image = image
        self.mainLabel = mainLabel
        self.hasBigTitle = hasBigTitle
        self.label = label
    }
    
    init(image: String, mainLabel: String, hasButtons: Bool, buttonLabels: [String]!){
        self.image = image
        self.mainLabel = mainLabel
        self.hasButtons = hasButtons
        self.buttonLabels = buttonLabels
    }
    
    init(image: String, mainLabel: String, hasBigTitle: Bool, secondLabel: String!){
        self.image = image
        self.mainLabel = mainLabel
        self.hasBigTitle = hasBigTitle
        self.secondLabel = secondLabel
    }
}

var triajData = [
    TriajData(image: "triaj1", mainLabel: "Triaj epidemiologic", hasBigTitle: true, stack: [
        ("list.number", "Vei respunde la cateva intrebari despre simptomele tale si contactul cu alte persoane"),
        ("hand.raised", "Raspunsurile tale nu sunt partajate si analizate de catre nimeni.\nRezultatul acestui triaj este sters automat cand iesi din aplicatie"),
        ("heart", "Recomandarile oferite de acest intrument nu constituie sfaturi medicale si nu ar trebui utilizate pentru a diagnostica sau trata afectiunile medicale!")
    ]),
    TriajData(image: "triaj2", mainLabel: "Este o urgenta?", hasBigTitle: true, label: "Opriti-va si sunati la 112 daca suferiti de: \nDurere sau presiune toracica severa\nDificultati extreme de respiratie\nAmeteala severa, constanta\nDezorientare grava sau lipsa de raspuns\nFata sau buze in nuante de albastru"),
    TriajData(image: "triaj3", mainLabel: "Care este varsta ta?", hasButtons: true, buttonLabels: ["Intre 18 si 64 de ani", "Peste 65 de ani"]),
    TriajData(image: "triaj4", mainLabel: "In ultimele 10 zile ai fost testat pentru COVID-19?", hasButtons: true, buttonLabels: ["Am fost testat si rezultatul este pozitiv", "Am fost testat si rezultatul este negativ", "Nu am fost testat in ultimele 10 zile"]),
    TriajData(image: "triaj5", mainLabel: "Ai avut parte de urmatoarele simptome?", hasBigTitle: false, label: "Febra sau frisoane\nDificultati de respiratie\nTuse\nPierderea gustului sau a mirosului\nGat uscat\nVomitat sau diaree"),
    TriajData(image: "triaj6", mainLabel: "Se aplica vreuna dintre acestea asupra ta?", hasBigTitle: false, label: "Obezitate\nFumat sau vaping\nSarcina\nDiabet, tensiune arteriala mare\nAstm, bronsita\nBoli ale inimii\nSistem imunitar slabit"),
    TriajData(image: "triaj7", mainLabel: "Totul pare in regula!", hasBigTitle: true, secondLabel: "Nu uita sa te protejezi in continuare!"),
    TriajData(image: "triaj8", mainLabel: "Cere ajutor", hasBigTitle: true, secondLabel: "Daca ai simptome sau daca ai nevoie de informatii cu privire la transimiterea si raspandirea virusului, te rugam sa apelezi numarul 0800.800.358.\nDaca consideri ca situatia ta este una grava, apeleaza 112!")
]
