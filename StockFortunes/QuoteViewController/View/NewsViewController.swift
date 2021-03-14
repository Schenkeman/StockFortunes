//
//  NewsViewController.swift
//  StockFortunes
//
//  Created by Vladislav Shinkevich on 3/4/21.
//

import UIKit
import SafariServices

private let reuseIdentifier = "NewsCell"

class NewsViewController: UICollectionViewController {
    
    var ticker: String!
    var newsModel: NewsModel?
    
    let dateFormatter = DateFormatter()
    let dateFormatter_2 = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        newsModel = fetchData(file: ticker)
        collectionView.backgroundColor = .clear
        setUpFormatterFromString()
        setUpFormatterToString()
        
    }
    
    init(ticker: String, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.ticker = ticker
//        setUpDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData(file: String) -> NewsModel {
        let dataNews = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(file)_News", ofType: "json")!), options: NSData.ReadingOptions.mappedIfSafe)
        let newsModel = try! JSONDecoder().decode(NewsModel.self, from: dataNews)
        return newsModel
    }
    
    func setUpFormatterFromString() {
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone.current
    }
    
    func setUpFormatterToString() {
        dateFormatter_2.dateFormat = "MMM d, h:mm a"
    }
}

extension NewsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let newsModel = newsModel else { return 0 }
        return newsModel.item.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        guard let newsModel = newsModel else { return cell }
        cell.newsItemModel = newsModel.item[indexPath.row]
        let date = dateFormatter.date(from: newsModel.item[indexPath.row].pubDate)
        cell.newsItemModel?.pubDate = dateFormatter_2.string(from: date!)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let link = newsModel?.item[indexPath.row].link else { return }
        let webVC = SFSafariViewController(url: URL(string: link)!)
        present(webVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemModel = newsModel?.item[indexPath.row]
        
        let aproximateWidth = view.frame.width - 32
        let size = CGSize(width: aproximateWidth, height: 50)
        let font = UIFont.systemFont(ofSize: 20)
        let attributes = [NSAttributedString.Key.font: font]
        let estimatedFrame = NSString(string: itemModel!.title).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 90)
    }
}
