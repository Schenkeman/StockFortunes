//
//  QuoteFilterCell.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/1/21.
//

import Foundation
import UIKit

class QuoteFilterCell: UICollectionViewCell {
    //MARK:- Properties

  
    var option: QuoteHeaderViewOptions! {
        didSet {
            titleLabel.text = option.description
        }
    }
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test Filter"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ?
                UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ?
                .black : .lightGray
        }
    }
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
