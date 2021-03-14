//
//  EpochCollectionView.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/8/21.
//

import Foundation
import UIKit

private let reuseIdentifier = "ButtonCell"

protocol EpochCollectionViewDelegate: class {
    func filterView(_ view: EpochCollectionView, didSelect indexPath: IndexPath)
}

class EpochCollectionView: UIView {
    weak var delegate: EpochCollectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EpochButtonCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension EpochCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EpochType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpochButtonCell
        let epochType = EpochType.init(rawValue: indexPath.row)
        cell.epochType = epochType
        return cell
    }
}

extension EpochCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}

extension EpochCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EpochButtonCell
        delegate?.filterView(self, didSelect: indexPath)
//        print(cell.epochType.description)
    }
}


