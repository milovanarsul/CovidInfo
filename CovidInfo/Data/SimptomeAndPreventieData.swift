//
//  SimptomeAndPreventieData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.02.2022.
//

import Foundation
import UIKit

class SimptomeAndPreventieData{
    var lottieAnimation: String
    var labelText: String
    
    init(lottieAnimation: String, labelText: String){
        self.lottieAnimation = lottieAnimation
        self.labelText = labelText
    }
}

class Simptome{
    var cards: [SimptomeAndPreventieData]
    var staticType: StaticType
    var borderColor: UIColor
    var cardsCount: Int!
    
    init(cards: [SimptomeAndPreventieData], staticType: StaticType, borderColor: UIColor){
        self.cards = cards
        self.staticType = staticType
        self.borderColor = borderColor
        self.cardsCount = cards.count
    }
}

class Preventie{
    var cards: [SimptomeAndPreventieData]
    var staticType: StaticType
    var borderColor: UIColor
    var cardsCount: Int!
    
    init(cards: [SimptomeAndPreventieData], staticType: StaticType, borderColor: UIColor){
        self.cards = cards
        self.staticType = staticType
        self.borderColor = borderColor
        self.cardsCount = cards.count
    }
}

let simptome = Simptome(cards: simptomeData, staticType: .simptome, borderColor: .red)
let preventie = Preventie(cards: preventieData, staticType: .preventie, borderColor: .green)

let preventieData = [
    SimptomeAndPreventieData(lottieAnimation: "preventie1", labelText: "Spală-te des pe mâini cu apă și săpun timp de cel puțin 20 de secunde, mai ales după ce ai fost într-un loc public sau după ce îți sufli nasul, tușești sau strănuți. Pentru a te șterge pe mâini folosește, de preferat, prosoape de hârtie."),
    SimptomeAndPreventieData(lottieAnimation: "preventie2", labelText: "Trebuie să porți o mască atunci când ești în preajma altor persoane. Masca de protecție/masca chirurgicală îi protejează pe cei din jurul tău, în cazul în care ai simptome de gripă sau răceală, întrucât previne răspândirea virusului pe cale respiratorie. Masca de protecție trebuie să acopere complet nasul și gura persoanei care o poartă."),
    SimptomeAndPreventieData(lottieAnimation: "preventie3", labelText: "Dacă nu sunt disponibile apa și săpunul, utilizează un produs de dezinfectare a mâinilor. Acoperă cu lichidul toată suprafața mâinilor și freacă-ți mâinile până când se simt uscate."),
    SimptomeAndPreventieData(lottieAnimation: "preventie4", labelText: "Autoizolează-te pentru 14 zile dacă ai călătorit în regiuni afectate de COVID-19, ai intrat în contact direct cu persoanale cu simptome sau cu persoanele care au fost confirmate cu coronavirus."),
    SimptomeAndPreventieData(lottieAnimation: "preventie5", labelText: "Coronavirus se poate răspândi între persoane care sunt în contact strâns (strângerea mâinilor, îmbrățișările, sărutul obrajilor sau al mâinilor, atingerea fețelor cu mâinile).")
]

let simptomeData = [
    SimptomeAndPreventieData(lottieAnimation: "simptome1", labelText: "Febră peste 38 de grade (în 90% din cazuri)"),
    SimptomeAndPreventieData(lottieAnimation: "simptome2", labelText: "Tuse uscată (în 60% din cazuri)"),
    SimptomeAndPreventieData(lottieAnimation: "simptome3", labelText: "Alte simptome care sunt mai puțîn frecvente și care pot să apară la unele persoane sunt: durerile, congestia nazală, conjunctivită, cefaleea, durerile de gât, diareea, pierderea simțului gustului și a mirosului, erupțiile cutanate și inrosirea degetelor de la mâini și picioare (apar că și cum ar fi degerate).")
]
