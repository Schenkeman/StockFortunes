//
//  QuoteContainerViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/4/21.
//

import UIKit

class StockContainerViewController: UIViewController {
    
    private var ticker: String!
    private var companyName: String!
    
    private var chartViewController: UIViewController!
    private var summaryViewController: UIViewController!
    private var newsViewController: UIViewController!
    private var activeVC: UIViewController!
    
    private var selectedViewController: StockControllerOption = .chart {
        didSet {
            selectViewController(selectedViewController)
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
        headerView.delegate = self
        chartViewController = ChartViewController(ticker: ticker)
        activeVC = chartViewController
        configureUI()
        configureHeaderView()
        updateActiveViewController()
    }
    
    private func selectViewController(_ option: StockControllerOption) {
        switch option {
        case .chart:
            removeInactiveViewController(inactiveViewController: activeVC)
            activeVC = chartViewController
            updateActiveViewController()
        case .summary:
            removeInactiveViewController(inactiveViewController: activeVC)
            if summaryViewController == nil {
                summaryViewController = SummaryViewController(ticker: ticker, companyName: companyName)
            }
            activeVC = summaryViewController
            updateActiveViewController()
        case .news:
            removeInactiveViewController(inactiveViewController: activeVC)
            if newsViewController == nil {
                let layout = CustomFlowLayout()
                newsViewController = NewsViewController(ticker: ticker, collectionViewLayout: layout)
            }
            activeVC = newsViewController
            updateActiveViewController()
        }
    }
        
    private let headerView: StockHeaderView = {
        let hv = StockHeaderView()
        return hv
    }()
    
    private func configureUI() {
        
        view.backgroundColor = .white
        navigationItem.title = ticker
    }
    
    private func configureHeaderView() {
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 52)
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            inActiveVC.willMove(toParent: nil)
            inActiveVC.view.removeFromSuperview()
            inActiveVC.removeFromParent()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeVC {
            addChild(activeVC)
            view.addSubview(activeVC.view)
            activeVC.view.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 52)
        }
    }
}

extension StockContainerViewController: StockHeaderViewDelegate {
    func filterView(_ view: StockHeaderView, didSelect indexPath: IndexPath) {
        guard let filter = StockControllerOption(rawValue: indexPath.row) else { return }
        self.selectedViewController = filter
    }
}
