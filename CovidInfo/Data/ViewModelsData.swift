//
//  ViewModelsData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 20.04.2022.
//

import Foundation
import UIKit

let headersData = [
    HeadersData(image: UIImage(named: "header1")!),
    HeadersData(image: UIImage(named: "header2")!),
    HeadersData(image: UIImage(named: "header3")!)
]

let trustedSourcesData = [
    TrustedSourceData(image: "datelazi", text: "Date la zi", url: "https://datelazi.ro"),
    TrustedSourceData(image: "ecdc", text: "ECDC", url: "https://www.ecdc.europa.eu/en"),
    TrustedSourceData(image: "ema", text: "EMA", url: "https://www.ema.europa.eu/en"),
    TrustedSourceData(image: "eu", text: "EU", url: "https://european-union.europa.eu/index_ro"),
    TrustedSourceData(image: "ms", text: "MS", url: "https://www.ms.ro"),
    TrustedSourceData(image: "stirioficiale", text: "Stiri oficiale", url: "https://stirioficiale.ro/informatii"),
    TrustedSourceData(image: "who", text: "WHO", url: "https://www.who.int")
]

let onboardingDataArray = [
    OnboardingData(lottieAnimation: "onboarding1", labelText: "Afla cum sa te protejezi si ce simptome pot aparea, ultimele stiri si de unde sa te informezi", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding2", labelText: "Vizualizeaza ultimele statistici si afla evolutia Pandemiei in Romania", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding3", labelText: "Afla mai multe despre vaccinurile aprobate si cum poti spune stop pandemiei", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding4", labelText: "Iti poti inrola certificatul pentru a-l avea la indemana", isModalNext: true),
    OnboardingData(lottieAnimation: "", labelText: "Certificatul tau a fost inrolat cu succes!", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding5", labelText: "Poti crea un cont pentru a-ti salva datele intr-un loc sigur", isModalNext: true)
]

let preventieData = [
    SimptomeAndPreventieData(lottieAnimation: "preventie1", labelText: "Spală-te des pe mâini cu apă și săpun timp de cel puțin 20 de secunde, mai ales după ce ai fost într-un loc public sau după ce îți sufli nasul, tușești sau strănuți. Pentru a te șterge pe mâini folosește, de preferat, prosoape de hârtie."),
    SimptomeAndPreventieData(lottieAnimation: "preventie2", labelText: "Trebuie să porți o mască atunci când ești în preajma altor persoane. Masca de protecție/masca chirurgicală îi protejează pe cei din jurul tău, în cazul în care ai simptome de gripă sau răceală, întrucât previne răspândirea virusului pe cale respiratorie."),
    SimptomeAndPreventieData(lottieAnimation: "preventie3", labelText: "Dacă nu sunt disponibile apa și săpunul, utilizează un produs de dezinfectare a mâinilor. Acoperă cu lichidul toată suprafața mâinilor și freacă-ți mâinile până când se simt uscate."),
    SimptomeAndPreventieData(lottieAnimation: "preventie4", labelText: "Autoizolează-te pentru 14 zile dacă ai călătorit în regiuni afectate de COVID-19, ai intrat în contact direct cu persoanale cu simptome sau cu persoanele care au fost confirmate cu coronavirus."),
    SimptomeAndPreventieData(lottieAnimation: "preventie5", labelText: "Coronavirus se poate răspândi între persoane care sunt în contact strâns (strângerea mâinilor, îmbrățișările, sărutul obrajilor sau al mâinilor, atingerea fețelor cu mâinile).")
]

let simptomeData = [
    SimptomeAndPreventieData(lottieAnimation: "simptome1", labelText: "Febră peste 38 de grade (în 90% din cazuri)"),
    SimptomeAndPreventieData(lottieAnimation: "simptome2", labelText: "Tuse uscată (în 60% din cazuri)"),
    SimptomeAndPreventieData(lottieAnimation: "simptome3", labelText: "Alte simptome care sunt mai puțîn frecvente și care pot să apară la unele persoane sunt: durerile, congestia nazală, conjunctivită, cefaleea, durerile de gât, diareea, pierderea simțului gustului și a mirosului, erupțiile cutanate și inrosirea degetelor de la mâini și picioare (apar că și cum ar fi degerate).")
]

var triajData = [
    TriajData(image: "triaj1", title: "Triaj epidemiologic", subViewType: .intro, subView: [("list.number", "Vei respunde la cateva intrebari despre simptomele tale si contactul cu alte persoane"),("hand.raised", "Raspunsurile tale nu sunt partajate si analizate de catre nimeni.\nRezultatul acestui triaj este sters automat cand iesi din aplicatie"),("heart", "Recomandarile oferite de acest intrument nu constituie sfaturi medicale si nu ar trebui utilizate pentru a diagnostica sau trata afectiunile medicale!")], actionType: .button, actionTitle: "Am inteles", actionForegorund: .white, actionColor: triajYellow, actionSize: actionNormal),
    TriajData(image: "triaj2", title: "Este o urgenta?", titleColor:triajRed, subViewType: .text, subView: "Opriti-va si sunati la 112 daca suferiti de: \n•Durere sau presiune toracica severa\n•Dificultati extreme de respiratie\n•Ameteala severa, constanta\n•Dezorientare grava sau lipsa de raspuns\n•Fata sau buze in nuante de albastru", actionType: .button, actionTitle: "Nu sufar de niciuna", actionForegorund: .white, actionColor: triajRed, actionSize: actionNormal),
    TriajData(image: "triaj3", title: "Care este varsta ta?", subViewType: .form, subView: [("Intre 18 si 65 de ani", 0.5),("Peste 65 de ani", 0.8)], actionType: .none, actionSize: actionSmall),
    TriajData(image: "triaj4", title: "In ultimele zile ai fost testat pentru COVID-19?", subViewType: .form, subView: [("Am fost testat si rezultatul este pozitiv", 1), ("Am fost testat si rezultatul este negativ", 0.1), ("Nu am fost testat in ultimele 10 zile", 0.5)], actionType: .none, actionSize: actionSmall),
    TriajData(image: "triaj5", title: "Ai avut parte de urmatoarele simptome?", subViewType: .text, subView: "•Febra sau frisoane\n•Dificultati de respiratie\n•Tuse\n•Pierderea gustului sau a mirosului\n•Gat uscat\n•Vomitat sau diaree", actionType: .buttonStack, actionSize: actionSmall),
    TriajData(image: "triaj6", title: "Se aplica vreuna dintre acestea asupra ta?", subViewType: .text, subView: "•Obezitate\n•Fumat sau vaping\n•Sarcina\n•Diabet, tensiune arteriala mare\n•Astm, bronsita\n•Boli ale inimii\n•Sistem imunitar slabit", actionType: .buttonStack, actionSize: actionSmall),
    TriajData(image: "triaj7", title: "Totul pare in regula!", subViewType: .finish, subView: PreventieAndSimptomeShortcut(), actionType: .button, actionTitle: "Reda testul", actionForegorund: .white, actionColor: signatureDarkBlue, actionSize: actionNormal),
    TriajData(image: "triaj8", title: "Cere ajutor!", titleColor: triajRed, subViewType: .text, subView: "Daca ai simptome sau daca ai nevoie de\ninformatii cu privire la transimiterea si\nraspandirea virusului, te rugam sa apelezi\nnumarul 0800.800.358.\nDaca consideri ca situatia ta este una grava,\napeleaza 112!", actionType: .button, actionTitle: "Reda testul", actionForegorund: .white, actionColor: signatureDarkBlue, actionSize: actionNormal)
]

