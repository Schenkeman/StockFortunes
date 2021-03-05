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
    private var selectedFilter: MainHeaderViewOptions = .stocks {
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
    
    let now = Date()
    let dateFormatter = DateFormatter()
    
    
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
        setupLongGestureRecognizerOnCollection()
        view.backgroundColor = .white
        //        setupDoubleTapGestureRecognizerOnCollection()
        
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
        
        dateFormatter.dateFormat = "MMMM"
        let nameOfMonth = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: now)
        navigationItem.title = "\(nameOfMonth.uppercased()) \(day)"
    }
    
    fileprivate func handleFavourite(cellItem: Int) {
        
        switch quoteCells[cellItem].favourite {
        case false:
            quoteCells[cellItem].favourite = true
            quoteCells[cellItem].timeAddedToFavourite = Date()
        //            favouriteQuoteCells.append(quoteCells[cellItem])
        default:
            quoteCells[cellItem].favourite = false
            
        }
        favouriteQuoteCells = []
        for q in quoteCells {
            if q.favourite == true {
                favouriteQuoteCells.append(q)
            }
        }
        favouriteQuoteCells.sort { (a, b) -> Bool in
            guard let time1 = a.timeAddedToFavourite, let time2 = b.timeAddedToFavourite else { return false}
            return time1 < time2
        }
        
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

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = currentQuoteCells[indexPath.row]
//        navigationController?.pushViewController(QuoteNavigationController(rootViewController: ChartViewController()), animated: true)
        navigationController?.pushViewController(QuoteContainerViewController(), animated: true)
        
        
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
    func filterView(_ view: UIView, didSelect indexPath: IndexPath) {
        guard let filter = MainHeaderViewOptions(rawValue: indexPath.row) else { return }
        self.selectedFilter = filter
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.35
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        var p = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView?.indexPathForItem(at: p) {
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        if (gestureRecognizer.state == .began) {
                print("Long press at item: \(indexPath.row)")
                handleFavourite(cellItem: indexPath.row)
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
