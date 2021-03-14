//
//  EpochButton.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/7/21.
//

import Foundation
import UIKit


class EpochButtonCell: UICollectionViewCell {
    
    
    let lightFillColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
    
    var epochType: EpochType! {
        didSet {
            titleLabel.text = epochType.description
        }
    }
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test Filter"
        return label
    }()
    
    
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ?
                UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ?
                .white : .black
            backgroundColor = isSelected ?
                .black : lightFillColor
        }
    }
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = lightFillColor
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
