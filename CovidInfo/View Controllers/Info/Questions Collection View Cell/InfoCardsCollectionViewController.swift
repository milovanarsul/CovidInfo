//
//  InfoCardsCollectionViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 05.05.2022.
//

import Foundation
import Firebase
import UIKit

class InfoCardsCollectionViewController: UICollectionViewController{
    
    var infoCardsType: InfoCardsType?
    var infoCardsDataArray = [InfoCardsData]()
    var currentIndex: Int!
    
    init(infoCardsType: InfoCardsType){
        self.infoCardsType = infoCardsType
        super.init(collectionViewLayout: InfoCardsCollectionViewLayout.init())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.infoCardsCollectionView = self
        
        switch infoCardsType! {
        case .intrebariFrecvente:
            infoCardsDataArray = FirebaseManager.faqData
        case .vaccinare:
            infoCardsDataArray = FirebaseManager.vaccinationData
        }
        
        initialize()
    }

    func initialize(){
        collectionView.backgroundColor = UIColor("#f2f2f7")
        collectionView.collectionViewLayout = InfoCardsCollectionViewLayout()
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(InfoCardCellCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCard")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoCardsDataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCard", for: indexPath as IndexPath) as! InfoCardCellCollectionViewCell
        cell.frontLabel.initialize(text: infoCardsDataArray[indexPath.item].title, color: .black, font: boldFont(size: 22), alignment: .left, lines: 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: size, height: size)
    }
    
    func findIndexes(from collectionView: UICollectionView) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            indexPaths.append(indexPath)
        }
        
        return indexPaths
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.item
        let data = infoCardsDataArray[currentIndex]
        let bottomSheet = InfoBottomSheetView(title: data.title, contents: data.content)
        bottomSheet.modalPresentationStyle = .custom
        bottomSheet.transitioningDelegate = self
        present(bottomSheet, animated: true, completion: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 50 {
            delegates.main.tabBarScrollAnimation(visibility: .hide)
        } else {
            delegates.main.tabBarScrollAnimation(visibility: .show)
        }
    }
}

extension InfoCardsCollectionViewController: UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension InfoCardsCollectionViewController: InfoCardsCollectionViewDelegate{
    func getInfoData(index: Int) -> InfoCardsData{
        return infoCardsDataArray[index]
    }
    
    func getCurrentIndexTextHeight() -> CGFloat{
        let data = infoCardsDataArray[currentIndex]
        let titleHeight = data.title.height(withConstrainedWidth: view.frame.width, font: UIFont(name: "IBMPlexSans-Bold", size: 20)!)
        let contentHeight = data.content.height(withConstrainedWidth: view.frame.width, font: UIFont(name: "IBMPlexSans-Regular", size: 14)!)
        return titleHeight + contentHeight - 100
    }
    
    func scrollToTop(){
        collectionView.setContentOffset(.zero, animated: true)
    }
}
