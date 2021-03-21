//
//  ViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit
import Foundation

private let reuseIdentifier = "StockCell"
private let headerIdentidier = "Header"

class StocksListViewController: UICollectionViewController {
    
    //MARK:- Properties
    
    private var selectedFilter: MainHeaderViewOptions = .stocks {
        didSet {
            collectionView.reloadData()
        }
    }
    private var currentStockCells: [StockModel] {
        switch selectedFilter {
        case .stocks: return mainStockCells
        case .favourites: return favouriteStockCells
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
    
    var mainStockCells: [StockModel]! {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.collectionView.reloadData()
            }
        }
    }
    private var favouriteStockCells: [StockModel]!
    private var filteredStockCells: [StockModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchController = UISearchController(searchResultsController: nil)
        headerFilterView.delegate = self
        setUpNavDate()
        configureUI()
        setupLongGestureRecognizerOnCollection()
        configureSearchController()
        favouriteStockCells = configureFavouriteCells()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.navigationBar.barTintColor = .white
        navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    let headerFilterView: HeaderFilterView = {
        let hfv = HeaderFilterView()
        return hfv
    }()
    
    func configureUI() {
        view.addSubview(headerFilterView)
        view.backgroundColor = .white
        collectionView.register(StockCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        
        headerFilterView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 52)
        
        definesPresentationContext = true
        
        collectionView.anchor(top: headerFilterView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func setUpNavDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let navTime = dateFormatter.string(from: Date())
        navigationItem.title = "\(navTime.uppercased())"
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Find company or ticker"
        definesPresentationContext = true
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.delegate = self
    }
    
    fileprivate func handleFavouriteTap(cellItem: Int) {
        
        var stockDataCells: [StockModel]
        // If you're filtering
        if isFiltering {
            stockDataCells = filteredStockCells
            switch stockDataCells[cellItem].favourite {
            // Stock is not favourite
            case false:
                // Stock is not in main list
                if !mainStockCells.contains(where: { (mainCell) in
                    return mainCell.ticker == stockDataCells[cellItem].ticker
                }) {
                    stockDataCells[cellItem].favourite = true
                    stockDataCells[cellItem].timeAddedToFavourite = Date()
                    mainStockCells.append(stockDataCells[cellItem])
                // Stock is in main list
                } else {
                    let index = mainStockCells.firstIndex { (mainCell) in
                        return mainCell.ticker == stockDataCells[cellItem].ticker
                    }
                    stockDataCells[cellItem].favourite = true
                    mainStockCells[index!].favourite = true
                }
                filteredStockCells = stockDataCells
            // Stock is favourite
            case true:
                let index = mainStockCells.firstIndex { (mainCell) in
                    return mainCell.ticker == stockDataCells[cellItem].ticker
                }
                stockDataCells[cellItem].favourite = false
                mainStockCells[index!].favourite = false
                filteredStockCells = stockDataCells
            }
        // You're not filtering
        } else {
            switch selectedFilter {
            case .stocks:
                switch mainStockCells[cellItem].favourite {
                case false:
                    mainStockCells[cellItem].favourite = true
                    mainStockCells[cellItem].timeAddedToFavourite = Date()
                case true:
                    mainStockCells[cellItem].favourite = false
                }
            case .favourites:
                let index = mainStockCells.firstIndex { (mainCell) in
                    return mainCell.ticker == favouriteStockCells[cellItem].ticker
                }
                mainStockCells[index!].favourite = false
            }
        }
        favouriteStockCells = configureFavouriteCells()
    }
    
    func configureFavouriteCells() -> [StockModel] {
        var favourites: [StockModel]
        favourites = mainStockCells.filter { stockCell in
            return stockCell.favourite == true
        }
        favourites.sort { (a, b) -> Bool in
            guard let time1 = a.timeAddedToFavourite, let time2 = b.timeAddedToFavourite else { return false}
            return time1 < time2
        }
        return favourites
    }
}

//MARK:- Collection Extensions

extension StocksListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredStockCells.count
        }
        return currentStockCells.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StockCell
        var stockModel: StockModel
        if isFiltering {
            stockModel = filteredStockCells[indexPath.row]
        } else {
            stockModel = currentStockCells[indexPath.row]
        }
        cell.stockViewModel = StockViewModel(stockModel: stockModel)
        cell.chooseColorTint(n: indexPath.row)
        return cell
    }
}

extension StocksListViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let currentCell = currentStockCells[indexPath.row]
        var quoteData: StockModel
        if isFiltering {
            quoteData = filteredStockCells[indexPath.row]
        } else {
            quoteData = currentStockCells[indexPath.row]
        }
        let stockDetailContainerVC = StockContainerViewController(ticker: quoteData.ticker, companyName: quoteData.title)
        navigationController?.pushViewController(stockDetailContainerVC, animated: true)
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension StocksListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
}

//MARK:- UISearchBarDelegate

extension StocksListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let fetchedQuoteData = MockServer.searchStocks(file: searchBar.text!.lowercased())
        filteredStockCells = fetchedQuoteData
        collectionView.reloadData()
    }
}
//MARK:- UISearchResultsUpdating

extension StocksListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text! )
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredStockCells = currentStockCells.filter({ (stock: StockModel) -> Bool in
            return (stock.ticker.lowercased().contains(searchText.lowercased()))
        })
        collectionView.reloadData()
    }
}

//MARK:- HeaderFilterViewDelegate

extension StocksListViewController: HeaderFilterViewDelegate {
    func filterView(_ view: UIView, didSelect indexPath: IndexPath) {
        guard let filter = MainHeaderViewOptions(rawValue: indexPath.row) else { return }
        self.selectedFilter = filter
    }
    
}

//MARK:- UIGestureRecognizerDelegate

extension StocksListViewController: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.35
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let p = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView?.indexPathForItem(at: p) {
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
            if (gestureRecognizer.state == .began) {
                print("Long press at item: \(indexPath.row)")
                handleFavouriteTap(cellItem: indexPath.row)
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .beginFromCurrentState, animations: {
                    cell.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
                }, completion: nil)
            } else if (gestureRecognizer.state == .ended) {
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: .beginFromCurrentState, animations: {
                    cell.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }
}



