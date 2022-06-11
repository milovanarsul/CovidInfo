//
//  ViewModelsData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 20.04.2022.
//

import Foundation
import UIKit

let trustedSourcesData = [
    TrustedSourceData(image: "datelazi", text: "Date la zi", url: "https://datelazi.ro"),
    TrustedSourceData(image: "ecdc", text: "ECDC", url: "https://www.ecdc.europa.eu/en"),
    TrustedSourceData(image: "ema", text: "EMA", url: "https://www.ema.europa.eu/en"),
    TrustedSourceData(image: "eu", text: "EU", url: "https://european-union.europa.eu/index_ro"),
    TrustedSourceData(image: "ms", text: "MS", url: "https://www.ms.ro"),
    TrustedSourceData(image: "stirioficiale", text: "Știri oficiale", url: "https://stirioficiale.ro/informatii"),
    TrustedSourceData(image: "who", text: "WHO", url: "https://www.who.int")
]

let onboardingDataArray = [
    OnboardingData(image: "onboarding1", labelText: "Află cum să te protejezi și ce simptome pot apărea, ultimele știri și de unde să te informezi", isSkipEnabled: false),
    OnboardingData(image: "onboarding2", labelText: "Planifică-ți călătoria ținând cont de măsurile impuse", isSkipEnabled: false),
    OnboardingData(image: "onboarding3", labelText: "Vizualizează ultimele statistici și află evoluția pandemiei", isSkipEnabled: false),
    OnboardingData(image: "onboarding4", labelText: "Află mai multe despre vaccinurile aprobate și cum poți spune stop pandemiei", isSkipEnabled: false),
    OnboardingData(image: "onboarding5", labelText: "Îți poți înrola certificatul pentru a-l avea la îndemână", isSkipEnabled: true),
    OnboardingData(image: "onboarding6", labelText: "Pentru a-ți oferi date relevante avem nevoie de locația ta.\nSelecteaza tipul de locație pe care dorești s-o utilizezi", isSkipEnabled: true, nextButtonText: "Locație automată", skipButtonText: "Locație manuală")
]

let preventieData = [
    SimptomeAndPreventieData(lottieAnimation: "preventie1", labelText: "Spală-te des pe mâini cu apă și săpun timp de cel puțin 20 de secunde, mai ales după ce ai fost într-un loc public sau după ce îți sufli nasul, tușeșți sau strănuți. Pentru a te șterge pe mâini folosește, de preferat, prosoape de hârtie."),
    SimptomeAndPreventieData(lottieAnimation: "preventie2", labelText: "Trebuie să porți o mască atunci când ești în preajma altor persoane. Masca de protecție/masca chirurgicală îi protejează pe cei din jurul tău, în cazul în care ai simptome de gripă sau răceală, întrucât previne răspândirea virusului pe cale respiratorie."),
    SimptomeAndPreventieData(lottieAnimation: "preventie3", labelText: "Dacă nu sunt disponibile apa și săpunul, utilizează un produs de dezinfectare a mâinilor. Acoperă cu lichidul toată suprafața mâinilor și freacă-ți mâinile până când se simt uscate."),
    SimptomeAndPreventieData(lottieAnimation: "preventie4", labelText: "Autoizolează-te pentru 14 zile dacă ai călătorit în regiuni afectate de COVID-19, ai intrat în contact direct cu persoanale cu simptome sau cu persoanele care au fost confirmate cu coronavirus."),
    SimptomeAndPreventieData(lottieAnimation: "preventie5", labelText: "Coronavirus se poate răspândi între persoane care sunt în contact strâns (strângerea mâinilor, îmbrățișările, sărutul obrajilor sau al mâinilor, atingerea fețelor cu mâinile).")
]

let simptomeData = [
    SimptomeAndPreventieData(lottieAnimation: "simptome1", labelText: "Febră peste 38 de grade (în 90% din cazuri)"),
    SimptomeAndPreventieData(lottieAnimation: "simptome2", labelText: "Tuse uscată (în 60% din cazuri)"),
    SimptomeAndPreventieData(lottieAnimation: "simptome3", labelText: "Alte simptome care sunt mai puțin frecvente și care pot să apară la unele persoane sunt: durerile, congestia nazală, conjunctivită, cefaleea, durerile de gât, diareea, pierderea simțului gustului și a mirosului, erupțiile cutanate și înroșirea degetelor de la mâini și picioare (apar că și cum ar fi degerate).")
]

var triajData = [
    TriajData(image: "triaj1", title: "Triaj epidemiologic", subViewType: .intro, subView: [("list.number", "Vei respunde la câteva întrebări despre simptomele tale și contactul cu alte persoane"),("hand.raised", "Răspunsurile tale nu sunt partajate și analizate de către nimeni.\nRezultatul acestui triaj este șters automat când ieși din aplicație"),("heart", "Recomandările oferite de acest intrument nu constituie sfaturi medicale și nu ar trebui utilizate pentru a diagnostica sau trata afecțiunile medicale!")], actionType: .button, actionTitle: "Am înțeles", actionForegorund: .white, actionColor: triajYellow, actionSize: actionNormal),
    TriajData(image: "triaj2", title: "Este o urgență?", titleColor:triajRed, subViewType: .text, subView: "Opriți-vă și sunați la 112 dacă suferiți de: \n•Durere sau presiune toracică severă\n•Dificultăți extreme de respirație\n•Amețeală severă, constantă\n•Dezorientare gravă sau lipsa de răspuns\n•Față sau buze în nuanțe de albastru", actionType: .button, actionTitle: "Nu sufăr de niciuna", actionForegorund: .white, actionColor: triajRed, actionSize: actionNormal),
    TriajData(image: "triaj3", title: "Care este vârstă ta?", subViewType: .form, subView: [("Între 18 și 65 de ani", 0.5),("Peste 65 de ani", 0.8)], actionType: .none, actionSize: actionSmall),
    TriajData(image: "triaj4", title: "În ultimele zile ai fost testat pentru COVID-19?", subViewType: .form, subView: [("Am fost testat și rezultatul este pozitiv", 1), ("Am fost testat și rezultatul este negativ", 0.1), ("Nu am fost testat în ultimele 10 zile", 0.5)], actionType: .none, actionSize: actionSmall),
    TriajData(image: "triaj5", title: "Ai avut parte de următoarele simptome?", subViewType: .text, subView: "•Febră sau frisoane\n•Dificultăți de respirație\n•Tuse\n•Pierderea gustului sau a mirosului\n•Gât uscat\n•Vomitat sau diaree", actionType: .buttonStack, actionSize: actionSmall),
    TriajData(image: "triaj6", title: "Se aplică vreuna dintre acestea asupra ta?", subViewType: .text, subView: "•Obezitate\n•Fumat sau vaping\n•Sarcină\n•Diabet, tensiune arterială mare\n•Astm, bronșită\n•Boli ale inimii\n•Sistem imunitar slăbit", actionType: .buttonStack, actionSize: actionSmall),
    TriajData(image: "triaj7", title: "Totul pare în regulă!", subViewType: .finish, subView: PreventieAndSimptomeShortcut(), actionType: .button, actionTitle: "Redă testul", actionForegorund: .white, actionColor: signatureDarkBlue, actionSize: actionNormal),
    TriajData(image: "triaj8", title: "Cere ajutor!", titleColor: triajRed, subViewType: .text, subView: "Dacă ai simptome sau dacă ai nevoie de\ninformatii cu privire la transimiterea și\nraspandirea virusului, te rugam să apelezi\nnumarul 0800.800.358.\nDaca consideri că situația ta este una gravă,\napeleaza 112!", actionType: .button, actionTitle: "Redă testul", actionForegorund: .white, actionColor: signatureDarkBlue, actionSize: actionNormal)
]

