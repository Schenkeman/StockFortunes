//
//  SummaryViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/3/21.
//

import UIKit
import SDWebImage

class SummaryViewController: UIViewController {
    
    var ticker: String!
    var companyName: String!
    
    var summaryModel: SummaryModel?
    var summaryViewModel: SummaryViewModel!
    
    var textViewWidth: CGFloat?
    
    private lazy var contentSize = CGSize(width: view.frame.width, height: view.frame.height) {
        didSet {
            scrollView.contentSize = contentSize
        }
    }
    
    init(ticker: String, companyName: String) {
        super.init(nibName: nil, bundle: nil)
        self.ticker = ticker
        self.companyName = companyName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLogo()
        configure()
        configureUI()
        configureTextView()
    }
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.backgroundColor = .white
        scroll.contentSize = contentSize
        scroll.frame = view.bounds
        return scroll
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        logo.backgroundColor = .blue
        return logo
    }()
    
    private lazy var tickerLabel: UILabel = labelGenerator()
    private lazy var companyNameLabel: UILabel = labelGenerator(fontSize: 24)
    private lazy var industryLabel: UILabel = labelGenerator(color: .gray)
    private lazy var sectorLabel: UILabel = labelGenerator()
    private lazy var countryLabel: UILabel = labelGenerator()

    private let websiteLabel: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.textColor = .black
        label.isScrollEnabled = false
        label.textAlignment = .left
        return label
    }()
    
    private let summaryTextView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .clear
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = .black
        text.textAlignment = .left
        text.isScrollEnabled = false
        text.isEditable = false
        text.textContainerInset = UIEdgeInsets.zero
        text.textContainer.lineFragmentPadding = 0
        return text
    }()
    
    private func labelGenerator(text: String = "", fontSize: CGFloat = 16, color: UIColor = .black, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = color
        label.textAlignment = alignment
        return label
    }
    
    private lazy var textViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        button.setTitle("See more", for: .normal)
        button.addTarget(self, action: #selector(handleTextViewButton), for: .touchUpInside)
        return button
    }()
    
    private func configure() {
        summaryModel = MockServer.fetchSummary(file: ticker)
        guard let sm = summaryModel else { return }
        summaryViewModel = SummaryViewModel(model: sm)
    }
    
    private func configureLinkWebsite() -> NSAttributedString {
        let astring = NSAttributedString.makeHyperLink(for: summaryViewModel.website, in: "Website: \(summaryViewModel.website)", as: summaryViewModel.website)
        return astring
    }
    
    private func configureTextView() {
        let targetWidth: CGFloat = 1659
        let width = summaryTextView.intrinsicContentSize.width
        if width > targetWidth {
            containerView.addSubview(textViewButton)
            textViewButton.anchor(top: summaryTextView.bottomAnchor, right: summaryTextView.rightAnchor, paddingTop: -15, paddingRight: 32)
        }
    }
    
    @objc func handleTextViewButton() {
        textViewButton.removeFromSuperview()
        
        let heightConstraint = summaryTextView.constraints.filter {
            $0.firstAttribute == .height
        }
        summaryTextView.removeConstraints(heightConstraint)
        summaryTextView.setHeight(height: summaryTextView.intrinsicContentSize.height)
        contentSize = CGSize(width: view.frame.width, height: view.frame.height + summaryTextView.intrinsicContentSize.height / 2)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        let stackLabels = UIStackView(arrangedSubviews: [sectorLabel, countryLabel])
        stackLabels.axis = .vertical
        stackLabels.spacing = 3
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(logoImage)
        containerView.addSubview(companyNameLabel)
        containerView.addSubview(industryLabel)
        containerView.addSubview(stackLabels)
        containerView.addSubview(summaryTextView)
        containerView.addSubview(websiteLabel)
        
        if let name = companyName { companyNameLabel.text = name }
        industryLabel.text = summaryViewModel.industry
        sectorLabel.text = "Sector: \(summaryViewModel.sector)"
        countryLabel.text = "Country: \(summaryViewModel.country)"
        websiteLabel.attributedText = configureLinkWebsite()
        summaryTextView.text = summaryViewModel.longBusinessSummary
        
        logoImage.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, paddingTop: 32, paddingLeft: 16)
        logoImage.setDimensions(height: 60, width: 60)
        logoImage.layer.cornerRadius = 60 / 4
        
        companyNameLabel.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, left: logoImage.rightAnchor, right: containerView.rightAnchor, paddingTop: 38, paddingLeft: 16, paddingRight: 32)
        
        industryLabel.anchor(left: logoImage.rightAnchor, bottom: logoImage.bottomAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 32)
        
        stackLabels.anchor(top: logoImage.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        summaryTextView.anchor(top: stackLabels.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 150)
        
        websiteLabel.anchor(top: summaryTextView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingLeft: 13, paddingRight: 16)
    
        websiteLabel.font = UIFont.systemFont(ofSize: 16)
            
    }
    
    private func configureLogo() {
            self.logoImage.sd_setImage(with: URL(string: "https://finnhub.io/api/logo?symbol=\(String(describing: self.ticker!))"), placeholderImage: nil)
    }
}
