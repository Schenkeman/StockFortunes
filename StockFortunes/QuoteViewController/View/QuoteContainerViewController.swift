//
//  QuoteContainerViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/4/21.
//

import UIKit

class QuoteContainerViewController: UIViewController {
    
    var chartViewController: UIViewController!
    var summaryViewController: UIViewController!
    var newsViewController: UIViewController!
    
    var ticker: String!
    var companyName: String!
    
    var activeVC: UIViewController!
    
    private var selectedViewController: QuoteHeaderViewOptions = .chart {
        didSet {
            selectViewController(selectedViewController)
        }
    }
    
    func selectViewController(_ option: QuoteHeaderViewOptions) {
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
    
    private var activeViewController: UIViewController? {
            didSet {
                selectViewController(selectedViewController)
                removeInactiveViewController(inactiveViewController: oldValue)
                updateActiveViewController()
            }
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegate = self
        chartViewController = ChartViewController(ticker: ticker)
        activeVC = chartViewController
        configureHeaderView()
        updateActiveViewController()
        view.backgroundColor = .white
        navigationItem.title = ticker
        
       
        
    }
    
    
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        chartViewController = ChartViewController()
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 52)
    }
    
    let headerView: QuoteHeaderView = {
        let hv = QuoteHeaderView()
        return hv
    }()
    

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

extension QuoteContainerViewController: QuoteHeaderViewDelegate {
    func filterView(_ view: QuoteHeaderView, didSelect indexPath: IndexPath) {
        guard let filter = QuoteHeaderViewOptions(rawValue: indexPath.row) else { return }
        self.selectedViewController = filter
    }
}
