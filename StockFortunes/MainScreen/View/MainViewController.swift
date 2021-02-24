//
//  ViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit

private let reuseIdentifier = "StockCell"
private let headerIdentidier = "Header"

class MainViewController: UICollectionViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    
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
    
    let searchBar = UISearchBar()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .yellow
        return cv
    }()
    
    let headerFilterView: HeaderFilterView = {
        let hfv = HeaderFilterView()
        return hfv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        collectionView.frame = CGRect(x: 0, y: 184, width: view.bounds.width, height: view.bounds.height - 184)
        collectionView.anchor(top: containerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.barStyle = .default
//        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.barStyle = .black
    }
 
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "February"
        self.navigationItem.largeTitleDisplayMode = .always
//        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(StockCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        collectionView.register(MainViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:  headerIdentidier)
        collectionView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 52)
//        searchBar.sizeToFit()
//        navigationItem.titleView = searchBar
        let searchController = UISearchController(searchResultsController: nil)
          searchController.searchResultsUpdater = self
          searchController.obscuresBackgroundDuringPresentation = false
          navigationItem.searchController = searchController
          definesPresentationContext = true
        containerView.addSubview(headerFilterView)
        headerFilterView.addConstraintsToFillView(containerView)
        
        
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

extension MainViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 150)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
}

//MARK:- UICollectionViewDelegate

extension MainViewController {
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentidier, for: indexPath) as! MainViewHeader
//        return header
//    }
    
    
    
   
}

extension MainViewController {
    
}

//MARK:- ProfileHeaderDelegate





