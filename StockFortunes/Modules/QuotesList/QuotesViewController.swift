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
        presenter?.chooseTypeOfListing(option: selectedOption)
        presenter?.viewDidLoad()
    }
    
    //MARK:- Actions
    @objc func refresh() {
        presenter?.refresh()
    }
    
    //MARK: - Properties
    
    var presenter: ViewToPresenterQuotesProtocol?
    private lazy var selectedOption: MainHeaderViewOptions = .quotes {
        didSet {
            presenter?.chooseTypeOfListing(option: selectedOption)
        }
    }
    
    private var searchController: UISearchController!
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    lazy var collectionView: UICollectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    func deselectItem(indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension QuotesViewController: PresenterToViewQuotesProtocol {
    func onFetchQuotesSuccess() {
        self.collectionView.reloadData()
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
    
    func refreshCellsState() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemAt(index: indexPath.row)
        presenter?.deselectItem(indexPath: indexPath)
    }
}

extension QuotesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
}

// MARK:- Setup UI
extension QuotesViewController {
    func setupUI() {


    }

}
