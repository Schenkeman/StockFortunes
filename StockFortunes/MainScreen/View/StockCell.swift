//
//  StockCell.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit
import Nuke


class StockCell: UICollectionViewCell {
    
    var quoteCellModel: QuoteDataModel! {
        didSet {
            configureUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        backgroundTintView.backgroundColor = n % 2 == 0 ? backgroundTintColor : .white
    }
    var backgroundTintView: UIView = {
        let bgtv = UIView()
        return bgtv
    }()
    
    //MARK:- Other properties
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        logo.backgroundColor = .white
        return logo
    }()
    
    private let tickerLabel: UILabel = {
        let ticker = UILabel()
        ticker.backgroundColor = .clear
        ticker.font = UIFont.systemFont(ofSize: 16)
        ticker.textColor = .black
        ticker.text = "AAPL"
        ticker.textAlignment = .left
        return ticker
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .clear
        title.font = UIFont.systemFont(ofSize: 16)
        title.textColor = .black
        title.text = "Apple Inc."
        title.textAlignment = .left
        return title
    }()
    
    private let currentPriceLabel: UILabel = {
        let currentPrice = UILabel()
        currentPrice.backgroundColor = .clear
        currentPrice.font = UIFont.systemFont(ofSize: 16)
        currentPrice.textColor = .black
        currentPrice.text = "$145.34"
        currentPrice.textAlignment = .right
        return currentPrice
    }()
    
    private let diffPriceLabel: UILabel = {
        let diffPrice = UILabel()
        diffPrice.backgroundColor = .clear
        diffPrice.font = UIFont.systemFont(ofSize: 16)
        diffPrice.textColor = .black
        diffPrice.text = "+$0.24 (1.23%)"
        diffPrice.textAlignment = .right
        return diffPrice
    }()
    
    
    func configureUI() {
        
        tickerLabel.text = quoteCellModel.ticker ?? "KOKO"
        titleLabel.text = quoteCellModel.title!
        currentPriceLabel.text = String(format: "%.2f", quoteCellModel.currentPrice!)
        diffPriceLabel.text = String(format: "%.2f", quoteCellModel.diffPrice!)
        let logoURL = URL(string: "https://finnhub.io/api/logo?symbol=\(String(describing: quoteCellModel.ticker!))")!
//        Nuke.loadImage(with: logoURL, into: logoImage)
        
    }
}
