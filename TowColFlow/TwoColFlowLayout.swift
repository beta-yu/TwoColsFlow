//
//  TwoColFlowLayout.swift
//  TowColFlow
//
//  Created by Yu Qi on 2021/11/10.
//

import UIKit

protocol TwoColFlowLayoutDelegate: NSObjectProtocol {
    func towColFlowLayout(_ towColFlowLayout: TwoColFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat
}

class TwoColFlowLayout: UICollectionViewFlowLayout {
    
    let cols = 2
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    lazy var colsHeight = Array(repeating: sectionInset.top, count: cols)
    var delegate: TwoColFlowLayoutDelegate?
    var maxHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let itemWidth = (collectionView.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat((cols - 1))) / CGFloat(cols)
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let itemHeight = delegate?.towColFlowLayout(self, itemHeight: indexPath)
            
            let minH = colsHeight.min()
            let minHeightIndex = colsHeight.firstIndex(of: minH!)!
            var itemY = minH!
            if i >= cols {
                itemY += minimumLineSpacing
            }
            
            let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            attr.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight!)
            layoutAttributes.append(attr)
            colsHeight[minHeightIndex] = attr.frame.maxY
        }
        maxHeight = colsHeight.max()! + sectionInset.bottom
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.width, height: maxHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter {
            $0.frame.intersects(rect)
        }
    }
    
}
