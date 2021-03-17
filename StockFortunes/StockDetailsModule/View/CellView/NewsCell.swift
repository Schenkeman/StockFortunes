//
//  NewsCell.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/13/21.
//

import Foundation
import UIKit



class NewsCell: UICollectionViewCell {
    
    var newsViewModel: NewsViewModel! {
        didSet {
            configure()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    private let pubDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func configure() {
        titleLabel.text = newsViewModel.title
        descriptionLabel.text = newsViewModel.itemDescription
        pubDateLabel.text = newsViewModel.pubDate
    }
    
    func configureUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, pubDateLabel])
        stackView.axis = .vertical
        stackView.spacing = 6
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16)
    }
}
