//
//  UICollectionViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.02.2022.
//

import Foundation
import UIKit

extension UICollectionViewController{
    func setup(dataSource: UICollectionViewDataSource, layout: UICollectionViewFlowLayout, cell: UICollectionViewCell.Type, cellIdentifier: String) -> UICollectionView{
        guard let collectionView = collectionView else {fatalError()}
        
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = layout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(cell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }
}

