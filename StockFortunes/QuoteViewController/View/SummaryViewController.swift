//
//  SummaryViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/3/21.
//

import UIKit

class SummaryViewController: UIViewController {
    
    var ticker: String!
    var companyName: String!
    
    var summaryModel: SummaryModel?
    var summaryViewModel: SummaryViewModel!
    
    var textViewWidth: CGFloat?
    
    
    
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
        view.backgroundColor = .white
        summaryModel = fetchData(file: ticker)
        guard let sm = summaryModel else { return }
        summaryViewModel = SummaryViewModel(model: sm)
        configureUI()
        configureTextView()
        
        
    }
    
    //    let sector: String
    //    let country: String
    //    let website: String
    //    let longBusinessSummary: String
    //    let fullTimeEmployees: Int
    
    private lazy var contentSize = CGSize(width: view.frame.width, height: view.frame.height) {
        didSet {
            scrollView.contentSize = contentSize
        }
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
        logo.clipsToBounds = true
        logo.backgroundColor = .green
        return logo
    }()
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "AAPL"
        label.textAlignment = .left
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.text = "AAPL"
        label.textAlignment = .left
        return label
    }()
    
    private let industryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "AAPL"
        label.textAlignment = .left
        return label
    }()
    private let sectorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "AAPL"
        label.textAlignment = .left
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "AAPL"
        label.textAlignment = .left
        return label
    }()
    
    private let websiteLabel: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.textColor = .black
        label.text = "AAPL"
        label.isScrollEnabled = false
        label.textAlignment = .left
        return label
    }()
    
    private let summaryTextView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .clear
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = .black
        text.text = "AAPL"
        text.textAlignment = .left
        text.isScrollEnabled = false
        text.isEditable = false
        text.textContainerInset = UIEdgeInsets.zero
        text.textContainer.lineFragmentPadding = 0
        
        return text
    }()
    
    func fetchData(file: String) -> SummaryModel {
        let dataCoordinate = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(file)_Summary", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let summaryModel = try! JSONDecoder().decode(SummaryModel.self, from: dataCoordinate)
        return summaryModel
    }
    
    func configureLinkWebsite() -> NSAttributedString {
        
        let astring = NSAttributedString.makeHyperLink(for: summaryViewModel.website, in: "Website: \(summaryViewModel.website)", as: summaryViewModel.website)
        return astring
    }
    
    func configureUI() {
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
    lazy var textViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
        button.setTitle("See more", for: .normal)
        button.addTarget(self, action: #selector(handleTextViewButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleTextViewButton() {
        textViewButton.removeFromSuperview()
        
        let heightConstraint = summaryTextView.constraints.filter {
            $0.firstAttribute == .height
        }
        summaryTextView.removeConstraints(heightConstraint)
        summaryTextView.setHeight(height: summaryTextView.intrinsicContentSize.height)
        contentSize = CGSize(width: view.frame.width, height: view.frame.height + summaryTextView.intrinsicContentSize.height / 2)
    }
    
    func configureTextView() {
        let targetWidth: CGFloat = 1659
        let width = summaryTextView.intrinsicContentSize.width
        if width > targetWidth {
            containerView.addSubview(textViewButton)
            textViewButton.anchor(top: summaryTextView.bottomAnchor, right: summaryTextView.rightAnchor, paddingTop: -15, paddingRight: 32)
        }
    }
}
