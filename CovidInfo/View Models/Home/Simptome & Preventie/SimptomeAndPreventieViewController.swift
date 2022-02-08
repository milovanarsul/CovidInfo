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
    }
    
    func embedCollectionView(){
        let embed = EmbedView()
        embed.simptomeAndPreventieViewController(parent: self, container: self.collectionView)
    }
    
    func changeMoreInfoWebsite(staticType: StaticType){
        switch staticType {
        case .simptome:
            self.moreInfoWebsite.textColor = .red
        case .preventie:
            self.moreInfoWebsite.textColor = .green
        }
    }
}

extension SimptomeAndPreventieViewController: StaticDelegate{

    func getStaticType() -> StaticType {
        return self.staticType
    }
    
    func getCards() -> Any {
        switch self.staticType {
        case .preventie:
            return preventie
        case .simptome:
            return simptome
        }
    }
}

