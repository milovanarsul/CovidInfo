//
//  SimptomeAndPreventieViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.02.2022.
//

import UIKit

class SimptomeAndPreventieViewController: UIViewController {
    @IBOutlet var moreInfoWebsite: UILabel!
    @IBOutlet var collectionView: UIView!
    @IBOutlet var topView: UIView!
    
    var staticType: StaticType
    
    init(staticType: StaticType){
        self.staticType = staticType
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedCollectionView()
        setup()
    }
    
    func embedCollectionView(){
        embed.simptomeAndPreventieViewController(parent: self, container: self.collectionView)
    }
    
    func setup(){
        let cards = getCards()
        self.moreInfoWebsite.textColor = cards.1
        self.topView.borderColor = cards.1
    }
}

extension SimptomeAndPreventieViewController: StaticDelegate {
    func getCards() -> ([SimptomeAndPreventieData], UIColor, Int) {
        switch self.staticType{
        case .preventie:
            return (preventie.cards, preventie.borderColor, preventie.cards.count)
        case .simptome:
            return (simptome.cards, simptome.borderColor, simptome.cards.count)
        }
    }
}

