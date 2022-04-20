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
    let flowLayout = SimptomeAndPreventieLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = setup(dataSource: collectionDataSource, layout: flowLayout, cell: SimptomeAndPreventieCollectionViewCell.self, cellIdentifier: cellIdentifier)
    }
}

class StaticCollectionDataSource: NSObject, UICollectionViewDataSource {
    var currentAnimation: String = ""
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegates.staticInfo.getCards().2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SimptomeAndPreventieCollectionViewCell
        
        let card = delegates.staticInfo.getCards().0
        cell.textLabel.text = card[indexPath.row].labelText
        cell.borderColor = delegates.staticInfo.getCards().1
        cell.lottieAnimation.animation = Animation.named(card[indexPath.row].lottieAnimation)
        cell.lottieAnimation.play()
        return cell
    }
}
