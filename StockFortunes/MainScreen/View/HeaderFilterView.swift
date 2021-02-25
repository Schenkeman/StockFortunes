//
//  HeaderFilterView.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/23/21.
//

import Foundation
import UIKit

private let reuseIdentifier = "ProfileFilterCell"

protocol HeaderFilterViewDelegate: class {
    func filterView(_ view: HeaderFilterView, didSelect indexPath: IndexPath)
}

class HeaderFilterView: UIView {
    
    //MARK:- Properties
    weak var delegate: HeaderFilterViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let underlineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .darkGray
        return uv
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(HeaderFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }
    
    override func layoutSubviews() {
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 2, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HeaderFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HeaderFilterCell
        let option = HeaderFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
}
extension HeaderFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let xPosition = cell?.frame.origin.x ?? 0
        UIView.animate(withDuration: 0.2 ) {
            self.underlineView.frame.origin.x = xPosition
        }
        delegate?.filterView(self, didSelect: indexPath)
    }
}

extension HeaderFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(HeaderFilterOptions.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
