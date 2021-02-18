//
//  ViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 2/16/21.
//

import UIKit

private let reuseIdentifier = "StockCell"

class MainViewController: UIViewController {

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
//        FinhubService.fetch()
        
    }
    
    
    //MARK:- SearchController Setup
    
    var filteredStocks: [CellModel] = []
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

extension MainViewController: UITableViewDelegate {
    
}


//MARK:- UITableViewControllerDelegates

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StockCell
//        cell.textLabel?.text = "Cell cell"
        cell.chooseColorTint(n: indexPath.row)
        return cell
    }
}

//MARK:- UISearchControllerDelegates

extension MainViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
}

