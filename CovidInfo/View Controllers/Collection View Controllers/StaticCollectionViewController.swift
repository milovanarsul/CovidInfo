//
//  StaticCollectionViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.02.2022.
//

import UIKit

private let cellIdentifier = "SimptomeAndPreventieCollectionViewCell"

class StaticCollectionViewController: UICollectionViewController {
    
    var staticDelegate: StaticDelegate!
    var collectionDataSource = StaticCollectionDataSource()
    let flowLayout = CardLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let collectionView = collectionView else {fatalError()}
        collectionDataSource.staticDelegate = self.staticDelegate
        collectionView.dataSource = collectionDataSource
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}

class StaticCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var staticDelegate: StaticDelegate!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cardsCount: Int!
        
        switch staticDelegate.getStaticType(){
        case .preventie:
            cardsCount = preventie.cardsCount
        case .simptome:
            cardsCount = simptome.cardsCount
        }
        
        return cardsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SimptomeAndPreventieCollectionViewCell
        
        var cardData: [SimptomeAndPreventieData]!
        var borderColor: UIColor!
        
        switch staticDelegate.getStaticType(){
            case .preventie:
            cardData = preventie.cards
            borderColor = preventie.borderColor
        case .simptome:
            cardData = simptome.cards
            borderColor = simptome.borderColor
        }
        
        let card: SimptomeAndPreventieData = cardData[indexPath.row]
        print(card.labelText)
        //cell.lottieAnimation = .init(name: card.lottieAnimation)
        //cell.label.text = card.labelText
        //cell.collectionViewCell.borderColor = borderColor
        
        cell.labelTestFuckingWorkYouBitch.text = "Milovan"
        
        return cell
    }
}
