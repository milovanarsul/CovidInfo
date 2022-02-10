//
//  StaticCollectionViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.02.2022.
//

import UIKit
import Lottie

private let cellIdentifier = "SimptomeAndPreventieCollectionViewCell"

class StaticCollectionViewController: UICollectionViewController {
    var collectionDataSource = StaticCollectionDataSource()
    let flowLayout = CardLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let collectionView = collectionView else {fatalError()}
        collectionView.dataSource = collectionDataSource
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(SimptomeAndPreventieCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}

var currentCollectionIndex = 0

class StaticCollectionDataSource: NSObject, UICollectionViewDataSource {
    var currentAnimation: String = ""
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return delegates.staticDelegate.getCards().2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SimptomeAndPreventieCollectionViewCell
        
        let card = delegates.staticDelegate.getCards().0
        cell.textLabel.text = card[indexPath.row].labelText
        cell.borderColor = delegates.staticDelegate.getCards().1
        cell.lottieAnimation.animation = Animation.named(card[indexPath.row].lottieAnimation)
        cell.lottieAnimation.play()
        return cell
    }
}
