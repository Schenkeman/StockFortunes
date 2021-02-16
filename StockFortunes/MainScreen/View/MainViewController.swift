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
    }
    
    private let tableView = UITableView()
    
    
    
    func configureUI() {
        view.backgroundColor = .white
        configureTableView()
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StockCell
//        cell.textLabel?.text = "Cell cell"
        return cell
    }
    
    
}
