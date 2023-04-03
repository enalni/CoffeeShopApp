import UIKit

final class SegmentControlFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var rows = [RowCollectionViewLayoutAttributes]()
        var currentRowY: CGFloat = -1
        
        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(RowCollectionViewLayoutAttributes(spacing: 10))
            }
            rows.last?.add(attribute: attribute)
        }
        
        guard let collectionView = collectionView else { return nil }
        let collectionViewWidth = collectionView.frame.width
        rows.forEach {
            $0.tagLayout(collectionViewWidth: collectionViewWidth)
        }
        return rows.flatMap { $0.attributes }
    }
}
