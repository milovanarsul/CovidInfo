//
//  InfoCardsCollectionViewLayout.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.05.2022.
//

import UIKit

class InfoCardsCollectionViewLayout: UICollectionViewFlowLayout {
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {return 0}
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    private var contentHeight: CGFloat = 0
    
    var infoCardsXOffset: [CGFloat] = []
    var infoCardsYOffset: [CGFloat] = []
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    private var columnWidth: CGFloat?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        layout()
    }
    
    func layout(){
        cache.removeAll()
        infoCardsXOffset.removeAll()
        infoCardsYOffset.removeAll()
        
        guard
            cache.isEmpty == true,
            let collectionView = collectionView
            else { return }

        columnWidth = contentWidth / CGFloat(numberOfColumns)
        for column in 0..<numberOfColumns {
            infoCardsXOffset.append(CGFloat(column) * columnWidth!)
        }
        
        var column = 0
        infoCardsYOffset = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            
            let textHeight = delegates.infoCardsCollectionView.getInfoData(index: item).frontTitle.height(withConstrainedWidth: columnWidth!, font: boldFont(size: 24))
            let height = cellPadding * 2 + textHeight
            let frame = CGRect(x: infoCardsXOffset[column], y: infoCardsYOffset[column], width: columnWidth!, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            infoCardsYOffset[column] = infoCardsYOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
