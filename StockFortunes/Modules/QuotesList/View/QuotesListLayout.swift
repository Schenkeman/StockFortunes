//
//  QuotesListLayout.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 6/28/21.
//

import Foundation
import UIKit

//protocol QuotesListLayoutDelegate: AnyObject {
//  func collectionView(
//    _ collectionView: UICollectionView,
//    heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat
//}
//
//class QuotesListLayout {
//    weak var delegate: QuotesListLayoutDelegate?
//
//    // 2
//    private let numberOfColumns = 2
//    private let cellPadding: CGFloat = 6
//
//    // 3
//    private var cache: [UICollectionViewLayoutAttributes] = []
//
//    // 4
//    private var contentHeight: CGFloat = 0
//
//    private var contentWidth: CGFloat {
//      guard let collectionView = collectionView else {
//        return 0
//      }
//      let insets = collectionView.contentInset
//      return collectionView.bounds.width - (insets.left + insets.right)
//    }
//
//    // 5
//    override var collectionViewContentSize: CGSize {
//      return CGSize(width: contentWidth, height: contentHeight)
//    }
//}
