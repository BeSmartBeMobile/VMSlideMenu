//
//  SlideLayout.swift
//  Pods
//
//  Created by jmlucena on 24/5/17.
//
//

import UIKit

class SlideLayout: UICollectionViewFlowLayout {
    
    var pageHeight: CGFloat {
        return self.itemSize.height + self.minimumLineSpacing
    }
    
    var flickVelocity: CGFloat {
        return 0.3
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var contentOffset = proposedContentOffset
        
        let rawPageValue = self.collectionView?.contentOffset.y ?? 0 / self.pageHeight
        let currentPage = velocity.y > 0 ? floor(rawPageValue) : ceil(rawPageValue)
        let nextPage = velocity.y > 0 ? ceil(rawPageValue) : floor(rawPageValue)
        
        let pannedLessThanAPage = fabs(1 + currentPage - rawPageValue) > 0.5
        let flicked = fabs(velocity.y) > self.flickVelocity
        
        if pannedLessThanAPage && flicked {
            contentOffset.y = nextPage * self.pageHeight
        } else {
            contentOffset.y = round(rawPageValue) * self.pageHeight
        }
        
        return contentOffset
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return super.layoutAttributesForElements(in: rect).flatMap { attributes in
            
            return attributes.filter { $0.representedElementKind == nil }
                .flatMap { layoutAttributesForItem(at: $0.indexPath) }
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let originalAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
        
        let attributes = originalAttributes.copy() as! UICollectionViewLayoutAttributes

        if indexPath.row == 1 {
        
            attributes.size.height = self.collectionView?.contentOffset.y ?? 0

//            print(attributes)
        }
        
        
//        if indexPath.row == 2 {
//            
//            guard let prevFrame = collectionView?.cellForItem(at: IndexPath(row: 1, section: indexPath.section))?.frame else { return nil }
//            
//            attributes.frame.origin.y = prevFrame.origin.y + prevFrame.height
//        }
        
        return attributes
    }
    
    
//    fileprivate func indexPathsContainedInRect(_ rect:CGRect)->[IndexPath] {
//        let noI = collectionView?.numberOfItems(inSection: 0) ?? 0
//        if noI == 0 {
//            return []
//        }
//        
//        let cvW = collectionViewWidth()
//        
//        // Find min and max rows that can be determined for sure
//        var minRow = Int(max(rect.origin.x/cvW, 0))
//        var maxRow = 0
//        if cvW != 0 {
//            maxRow = Int(rect.maxX / cvW)
//        }
//        
//        // Additional check for rows that also can be included (our rows are moving depending on content size)
//        let candidateMinRow = max(minRow-1, 0)
//        
//        if maxXForRow(candidateMinRow) >= rect.origin.x {
//            minRow = candidateMinRow
//        }
//        
//        let candidateMaxRow = min(maxRow + 1, noI - 1)
//        if minXForRow(candidateMaxRow) <= rect.maxX {
//            maxRow = candidateMaxRow
//        }
//        
//        // Simply add index paths between min and max.
//        var resultingIdxPaths = [IndexPath]()
//        
//        // Fix for issue #8 - Thanks gstrobl17
//        if minRow < maxRow || noI == 1 {
//            for i in minRow...maxRow {
//                resultingIdxPaths.append(IndexPath(row: i, section: 0))
//            }
//        }
//        
//        return resultingIdxPaths
//    }
    
//    var mostRecentOffset : CGPoint = CGPoint()
//    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        
//        if velocity.y == 0 {
//            return mostRecentOffset
//        }
//        
//        if let cv = self.collectionView {
//            
//            let cvBounds = cv.bounds
//            let halfHeight = cvBounds.size.height * 0.5;
//            
//            
//            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
//                
//                var candidateAttributes : UICollectionViewLayoutAttributes?
//                for attributes in attributesForVisibleCells {
//                    
//                    // == Skip comparison with non-cell items (headers and footers) == //
//                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
//                        continue
//                    }
//                    
//                    if (attributes.center.y == 0) || (attributes.center.y > (cv.contentOffset.y + halfHeight) && velocity.y < 0) {
//                        continue
//                    }
//                    candidateAttributes = attributes
//                }
//                
//                // Beautification step , I don't know why it works!
//                if(proposedContentOffset.y == -(cv.contentInset.top)) {
//                    return proposedContentOffset
//                }
//                
//                guard let _ = candidateAttributes else {
//                    return mostRecentOffset
//                }
//                mostRecentOffset = CGPoint(x: proposedContentOffset.x, y: floor(candidateAttributes!.center.y - halfHeight))
//                return mostRecentOffset
//                
//            }
//        }
//        
//        // fallback
//        mostRecentOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
//        return mostRecentOffset
//    }
//    


//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
//        let horizontalOffset = proposedContentOffset.x
//        let targetRect = CGRect(origin: CGPoint(x: proposedContentOffset.x, y: 0), size: self.collectionView!.bounds.size)
//        
//        for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
//            let itemOffset = layoutAttributes.frame.origin.x
//            if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
//                offsetAdjustment = itemOffset - horizontalOffset
//            }
//        }
//        
//        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
//    }
    
}
