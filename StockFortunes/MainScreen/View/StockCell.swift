//
//  StockCell.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit

class StockCell: UITableViewCell {
    
    var stockData: CellModel? {
        didSet {
            configureUI()
        }
    }
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(logo)
        logo.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4)
        logo.setDimensions(height: 32, width: 32)
        logo.layer.cornerRadius = 32 / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFill
        logo.clipsToBounds = true
        logo.backgroundColor = .lightGray
        return logo
    }()
    
    private let title: UITextView = {
        let title = UITextView()
        title.backgroundColor = .clear
        title.font = UIFont.systemFont(ofSize: 16)
        title.isScrollEnabled = false
        title.isEditable = false
        title.textColor = .black
        return title
    }()
    
    func configureUI() {
        
    }
}
