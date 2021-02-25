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
        }
    }
    var manager: NetworkManager?
    var quoteCells: [QuoteDataModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let containerView: UIView = {
        let cv = UIView()
        return cv
    }()
    
    let headerFilterView: HeaderFilterView = {
        let hfv = HeaderFilterView()
        return hfv
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return quoteCells.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StockCell
        cell.quoteCellModel = quoteCells[indexPath.row]
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





