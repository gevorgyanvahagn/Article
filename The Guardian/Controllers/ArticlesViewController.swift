//
//  ArticlesViewController.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class ArticlesViewController: UIViewController, APIClient {
    
    private var tableViewHandler: TableViewHandler<ObjectArticle, ArticleCellBuilder>?
    private let cellBuilder = ArticleCellBuilder()
    @IBOutlet weak var tableView: UITableView!
    private var articles: [ObjectArticle] = [] {
        didSet {
            tableViewHandler?.dataSource = articles
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHandler = TableViewHandler(cellIdentifier: ArticleTableViewCell.className, tableView: tableView, cellBuilder: cellBuilder)
        fetchArticles()
    }
    
    private func fetchArticles() {
        if let endPoint = ArticlesEndpoint.search(page: 1).request {
            request(with: endPoint) { [weak self] (either: Either<ArticlesResponse>) in
                switch either {
                case .success(let articlesResponse):
                    if let articles = articlesResponse.articles {
                        self?.articles = articles
                    }
                case .error(let error):
                    self?.alert(title: error.localizedDescription)
                }
            }
        }
    }
    
    deinit {
        print("ArticlesViewController deinit")
    }
}
