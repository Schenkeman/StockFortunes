//
//  StockHeaderView.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/1/21.
//

import Foundation
import UIKit

private let reuseIdentifier = "QuoteHeaderViewCell"

protocol StockHeaderViewDelegate: class {
    func filterView(_ view: StockHeaderView, didSelect indexPath: IndexPath)
}

class StockHeaderView: UIView {
    
    weak var presenter: ViewToPresenterQuoteDetailProtocol?
    
    //MARK:- Properties
//    weak var delegate: StockHeaderViewDelegate?
    
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
    
    private let bcgUnderlineView: UIView = {
        let buv = UIView()
        buv.backgroundColor = .systemGray
        return buv
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(StockHeaderCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }
    
    override func layoutSubviews() {
        addSubview(bcgUnderlineView)
        bcgUnderlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width, height: 0.5)
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 3, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StockHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DetailViewControllerOption.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StockHeaderCell
        let option = DetailViewControllerOption(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
}
extension StockHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let xPosition = cell?.frame.origin.x ?? 0
        UIView.animate(withDuration: 0.2 ) {
            self.underlineView.frame.origin.x = xPosition
        }
        presenter?.selectViewController(index: indexPath.row)
    }
}

extension StockHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(DetailViewControllerOption.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
