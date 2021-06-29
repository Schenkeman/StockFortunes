//
//  QuotesViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 5/24/21.
//

import Foundation
import UIKit
import PKHUD

private let reuseIdentifier = "QuoteCell"
private let headerIdentidier = "HeaderQuotesList"

class QuotesViewController: UIViewController {

    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
        view.addSubview(collectionView)
        collectionView.register(QuoteSnippet.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        presenter?.viewDidLoad()
    }
    
    //MARK:- Actions
    @objc func refresh() {
        presenter?.refresh()
    }
    
    //MARK: - Properties
    var presenter: ViewToPresenterQuotesProtocol?


    private lazy var selectedFilter: MainHeaderViewOptions = .stocks
//    private lazy var currentQuoteList: [Quote]
//    private lazy var searchController: UISearchController!

    lazy var collectionView: UICollectionView = QuotesList(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.rowHeight = 90
//        tableView.dataSource = self
//        tableView.delegate = self
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    func deselectRowAt(row: Int) {
        self.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
}

extension QuotesViewController: PresenterToViewQuotesProtocol {

    func onFetchQuotesSuccess() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchQuotesFailure(error: String) {
        self.refreshControl.endRefreshing()
    }

    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }

    func hideHUD() {
        HUD.hide()
    }
}

extension QuotesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuoteSnippet
        cell.chooseColorTint(n: indexPath.row)
        cell.quoteData = presenter?.configureQuoteSnippet(indexPath: indexPath)
        return cell
    }
}

extension QuotesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
}

// MARK: - UITableView Delegate & Data Source
//extension QuotesViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter?.numberOfRowsInSection() ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
////        cell.textLabel?.text = presenter?.textLabelText(indexPath: indexPath)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter?.didSelectRowAt(index: indexPath.row)
//        presenter?.deselectRowAt(index: indexPath.row)
//    }
//}

// MARK:- Setup UI
extension QuotesViewController {
    func setupUI() {


    }

}
