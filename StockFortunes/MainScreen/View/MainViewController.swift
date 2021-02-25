//
//  ViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit

private let reuseIdentifier = "StockCell"
private let headerIdentidier = "Header"

class MainViewController: UICollectionViewController {
    
    var viewModel: MainScreenViewModelProtocol? {
        didSet {
            quoteCells = viewModel!.quoteCellModels
            collectionView.reloadData()
        }
    }
    var manager: NetworkManager?
    //    private var quoteCells: [QuoteDataModel] = [] {
    //        didSet {
    //            collectionView.reloadData()
    //        }
    //    }
    private var selectedFilter: HeaderFilterOptions = .stocks {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var quoteCells: [QuoteDataModel] = []
    private var favouriteQuoteCells: [QuoteDataModel] = []
    
    private var currentQuoteCells: [QuoteDataModel] {
        switch selectedFilter {
        case .stocks: return quoteCells
        case .favourites: return favouriteQuoteCells
        }
    }
    
    let containerView: MainViewHeader = {
        let mvh = MainViewHeader()
        return mvh
    }()
    
    let headerFilterView: HeaderFilterView = {
        let hfv = HeaderFilterView()
        return hfv
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerFilterView.delegate = self
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "February"
        collectionView.register(StockCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 52)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        containerView.addSubview(headerFilterView)
        headerFilterView.addConstraintsToFillView(containerView)
        collectionView.anchor(top: containerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
    }
}



//MARK:- UITableViewControllerDelegates

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentQuoteCells.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StockCell
        cell.quoteCellModel = currentQuoteCells[indexPath.row]
        cell.chooseColorTint(n: indexPath.row)
        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
}

//MARK:- UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
}

extension MainViewController: HeaderFilterViewDelegate {
    func filterView(_ view: HeaderFilterView, didSelect indexPath: IndexPath) {
        guard let filter = HeaderFilterOptions(rawValue: indexPath.row) else { return }
        self.selectedFilter = filter
    }
}




