//
//  StockCell.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit
import Nuke

struct QuoteSnippetState {
    struct QuoteData: Equatable {
        var ticker: String
        var title: String

        var currentPrice: Double
        var diffPrice: Double
        var changePercent: Double

        var favourite: Bool = false
        var timeAddedToFavourite: Date?

        static func ==(lhs: QuoteData, rhs: QuoteData) -> Bool {
            return lhs.favourite == rhs.favourite
        }
    }
}


class QuoteSnippet: UICollectionViewCell {
    
    //MARK:- Properties
    //
    //    var stockViewModel: StockViewModel! {
    //        didSet {
    //            configure()
    //            configureFavouriteIcon()
    //            configureColorOfLabel()
    //        }
    //    }

    var quoteData: QuoteSnippetState.QuoteData! {
        didSet {
            configure(quoteData: quoteData)
            configureUI()
        }
    }
    
    //MARK:- Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    convenience init(frame: CGRect, quoteData: QuoteSnippetState.QuoteData) {
        self.init(frame: frame)
        configure(quoteData: quoteData)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UI Properties
    
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
        ticker.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        currentPrice.font = UIFont.systemFont(ofSize: 18, weight: .medium)
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
    
    let favouriteIcon: UIView = {
        let image = UIImage(named: "starFilled.png")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image!)
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    private var backgroundTintColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
    
    private var backgroundTintView: UIView = {
        let bgtv = UIView()
        return bgtv
    }()
    
    //MARK:- Functions
    
    func configure(quoteData: QuoteSnippetState.QuoteData) {
                tickerLabel.text = quoteData.ticker
                titleLabel.text = quoteData.title
                let stringFormat = "%.2f"
                currentPriceLabel.text = "$\(String(format: stringFormat, quoteData.currentPrice))"
                let diffValue = String(format: stringFormat, quoteData.diffPrice)
                let diffPercent = String(format: stringFormat, quoteData.changePercent)
                diffPriceLabel.text = "\(diffValue)$ (\(diffPercent)%)"
        //        let logoURL = URL(string: "https://finnhub.io/api/logo?symbol=\(String(describing: stockViewModel.ticker))")!
        //                Nuke.loadImage(with: logoURL, into: logoImage)
    }
    
    //    func chooseColorTint(n: Int) {
    //        let n = Int(n)
    //        backgroundTintView.backgroundColor = n % 2 == 0 ? backgroundTintColor : .white
    //    }
    
    //    func configureFavouriteIcon() {
    //        if stockViewModel.favourite == true {
    //            self.favouriteIcon.tintColor = .orange
    //        } else {
    //            self.favouriteIcon.tintColor = .lightGray
    //        }
    //    }
    //
    //    func configureColorOfLabel() {
    //        if stockViewModel.diffPrice < 0 {
    //            diffPriceLabel.textColor = .red
    //        } else if stockViewModel.diffPrice == 0.0 {
    //            diffPriceLabel.textColor = .black
    //        } else {
    //            diffPriceLabel.textColor = .systemGreen
    //        }
    //    }
    //
    private func configureUI() {
        addSubview(backgroundTintView)
        addSubview(logoImage)
        addSubview(favouriteIcon)
        
        backgroundTintView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 16, paddingBottom: 5, paddingRight: 16)
        backgroundTintView.layer.cornerRadius = 60 / 4
        
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
        
        leftStack.anchor(top: backgroundTintView.topAnchor, left: logoImage.rightAnchor, bottom: backgroundTintView.bottomAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, width: 100)
        
        rightStack.anchor(top: backgroundTintView.topAnchor, left: leftStack.leftAnchor, bottom: backgroundTintView.bottomAnchor, right: backgroundTintView.rightAnchor, paddingTop: 15, paddingBottom: 15, paddingRight: 15)
        
        favouriteIcon.anchor(top: topAnchor, left: leftStack.rightAnchor, paddingTop: 25, paddingLeft: 0, width: 15, height: 15)
    }
}
