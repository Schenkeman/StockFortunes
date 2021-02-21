//
//  ViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit

private let reuseIdentifier = "StockCell"

//protocol MainViewControllerProtocol: class {
//    func fetchInitialPeers(symbol: String)
//    var manager: NetworkManager? {get set}
//}

class MainViewController: UIViewController {
    
    var viewModel: MainScreenViewModelProtocol? {
        didSet {
            quoteCells = viewModel!.quoteCellModels
        }
    }
    var manager: NetworkManager?
    var quoteCells: [QuoteDataModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.register(StockCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "February"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Find company or ticker"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        let searchBar = searchController.searchBar
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            
//            let data = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "QuoteList_testing", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
//            let cellModels = try! JSONDecoder().decode([QuoteCellModel].self, from: data)
//            self.viewModel?.quoteCellModels = cellModels
//            
//        }
        
        //        viewModel?.fetchInitialPeers(listener: { (n) in
        //            self.viewModel = MainScreenViewModel(quoteCellModels: n)
        //        })
    }
    
    //MARK:- SearchController Setup
    
    var filteredStocks: [QuoteDataModel] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    //    func filterContentForSearchText(_ searchText: String,
    //                                    name: CellModel.ticker = nil) {
    //        filteredStocks = stocks.filter { (cell: CellModel) -> Bool in
    //        return candy.name.lowercased().contains(searchText.lowercased())
    //      }
    //
    //      tableView.reloadData()
    //    }
    
    private let tableView = UITableView()
    
    func configureUI() {
        view.backgroundColor = .white
        configureTableView()
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.rowHeight = 90
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
}


//MARK:- UITableViewControllerDelegates

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataCell = quoteCells[indexPath.row]
        let dvc = DetailViewController(quoteDataModel: dataCell)
        navigationController?.pushViewController(dvc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StockCell
        cell.chooseColorTint(n: indexPath.row)
        cell.quoteCellModel = quoteCells[indexPath.row]
        return cell
    }
}



//MARK:- UISearchControllerDelegates

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

