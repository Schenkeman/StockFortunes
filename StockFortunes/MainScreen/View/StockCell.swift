//
//  StockCell.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit

class StockCell: UITableViewCell {
    
    var stockData: QuoteCellModel? {
        didSet {
            configureUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(backgroundTintView)
        backgroundTintView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 16, paddingBottom: 5, paddingRight: 16)
        backgroundTintView.layer.cornerRadius = 60 / 4
        
        
        addSubview(logoImage)
        logoImage.centerY(inView: self)
        logoImage.anchor(left: backgroundTintView.leftAnchor, paddingLeft: 15)
        logoImage.setDimensions(height: 60, width: 60)
        logoImage.layer.cornerRadius = 60 / 4
        
        let leftStack = UIStackView(arrangedSubviews: [tickerLabel, titleLabel])
        let rightStack = UIStackView(arrangedSubviews: [currentPriceLabel, diffPriceLabel])
        
        leftStack.axis = .vertical
        leftStack.spacing = 2
        addSubview(leftStack)
        addSubview(rightStack)
        rightStack.axis = .vertical
        rightStack.spacing = 2
        leftStack.axis = .vertical
        rightStack.spacing = 2
        
        leftStack.anchor(top: backgroundTintView.topAnchor, left: logoImage.rightAnchor, bottom: backgroundTintView.bottomAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, width: 150)
        
        rightStack.anchor(top: backgroundTintView.topAnchor, left: rightStack.leftAnchor, bottom: backgroundTintView.bottomAnchor, right: backgroundTintView.rightAnchor, paddingTop: 15, paddingBottom: 15, paddingRight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- BGCell color
    
    var backgroundTintColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
    func chooseColorTint(n: Int) {
        let n = Int(n)
        if n % 2 == 0 {
            backgroundTintView.backgroundColor = backgroundTintColor 
        } else {
            backgroundTintView.backgroundColor = .white
        }
    }
    var backgroundTintView: UIView = {
        let bgtv = UIView()
        return bgtv
    }()
    
    //MARK:- Other properties
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFill
        logo.clipsToBounds = true
        logo.backgroundColor = .lightGray
        return logo
    }()
    
    private let tickerLabel: UILabel = {
        let ticker = UILabel()
        ticker.backgroundColor = .clear
        ticker.font = UIFont.systemFont(ofSize: 16)
        ticker.textColor = .black
        ticker.text = "AAPL"
        return ticker
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = .black
        title.text = "Apple Inc."
        return title
    }()
    
    private let currentPriceLabel: UILabel = {
        let ticker = UILabel()
        ticker.backgroundColor = .clear
        ticker.font = UIFont.systemFont(ofSize: 16)
        ticker.textColor = .black
        ticker.text = "$145.34"
        return ticker
    }()
    
    private let diffPriceLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = .black
        title.text = "+$0.24 (1.23%)"
        return title
    }()
    
    
    func configureUI() {
        
    }
}
