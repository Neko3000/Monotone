//
//  ElevatorFlowLayout.swift
//  Monotone
//
//  Created by Xueliang Chen on 12/30/20.
//

import UIKit

class ElevatorFlowLayout: UICollectionViewFlowLayout {
    
    public var columnCount: Int = 2
    
    public var itemHeight: CGFloat = 296.0
    public var itemOffset: CGFloat = 37.0
    
    private var xOffsets: [CGFloat] = [CGFloat]()
    private var yOffsets: [CGFloat] = [CGFloat]()
        
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat{
        guard let collectionView = self.collectionView else { return 0 }
        
        let contentInset = collectionView.contentInset
        return collectionView.bounds.width - (contentInset.left + contentInset.right)
    }
    
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    public func resetLayout(){
        self.contentHeight = 0
        self.cachedAttributes.removeAll()
    }
        
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
        
        let currentItemsCount = collectionView.numberOfItems(inSection: 0)
        guard  currentItemsCount >= cachedAttributes.count
        else {
            
            let index = currentItemsCount == 0 ? 0 : currentItemsCount - 1
            self.contentHeight = self.cachedAttributes[index].frame.maxY
            
            return
        }
        
        let itemWidth = self.contentWidth / CGFloat(columnCount)

        if(self.cachedAttributes.isEmpty){
            
            self.xOffsets.removeAll()
            self.yOffsets.removeAll()
            
            for col in 0..<columnCount{
                self.xOffsets.append(CGFloat(col) * itemWidth)
                self.yOffsets.append(CGFloat(col) * itemOffset)
            }
        }
        
        for index in cachedAttributes.count..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: index, section: 0)
            let col = index % columnCount
            
            let frame = CGRect(x: self.xOffsets[col],
                               y: self.yOffsets[col],
                               width: itemWidth,
                               height: self.itemHeight)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = frame
            cachedAttributes.append(attribute)
            
            // Update.
            self.contentHeight = max(frame.maxY, self.contentHeight)
            yOffsets[col] += self.itemHeight
        }
    }
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width:self.contentWidth, height:self.contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in self.cachedAttributes{
            if(rect.intersects(attribute.frame)){
                visibleAttributes.append(attribute)
            }
        }
        
        return visibleAttributes
    }
}
