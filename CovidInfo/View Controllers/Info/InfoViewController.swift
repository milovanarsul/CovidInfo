//
//  InfoViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 25.04.2022.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {
    
    var infoCardsDataArray: [InfoCardsData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        let embed = EmbedView()
        embed.infoCardsCollectionViewController(parent: self, container: view)
    }
}

class InfoCardsCollectionViewController: UICollectionViewController{
    
    var infoCardsDataArray = [InfoCardsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.infoCardsCollectionView = self
        pullInfoCardsData()
        initialize()
    }
    
    func pullInfoCardsData(){
        databaseReference.child("InfoCards").observe(.value) { (snaphshot) in
            for card in snaphshot.children.allObjects as! [DataSnapshot]{
                let object = card.value as? [String: AnyObject]
                let cardID = object?["cardID"] as! Int
                let frontTitle = object?["frontTitle"] as! String
                let contents = object?["contents"] as! String
                self.infoCardsDataArray.append(InfoCardsData(cardID: cardID, frontTitle: frontTitle, contents: contents))
            }
            self.collectionView.reloadData()
        }
    }

    func initialize(){
        collectionView.collectionViewLayout = InfoCardsCollectionViewLayout()
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(InfoCardCellCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCard")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoCardsDataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCard", for: indexPath as IndexPath) as! InfoCardCellCollectionViewCell
        cell.frontLabel.initialize(text: infoCardsDataArray[indexPath.item].frontTitle, color: .black, font: boldFont(size: 24), alignment: .left, lines: 0)
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
        let data = infoCardsDataArray[indexPath.item]
        let bottomSheet = InfoBottomSheetView(title: data.frontTitle, contents: data.contents)
        bottomSheet.modalPresentationStyle = .custom
        bottomSheet.transitioningDelegate = self
        present(bottomSheet, animated: true, completion: nil)
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
}
