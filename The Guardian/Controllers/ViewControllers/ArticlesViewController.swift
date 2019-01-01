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
    var articlesLoader = ArticlesLoader()
    private var articles: [ObjectArticle] = [] {
        didSet {
            tableViewHandler?.dataSource = articles
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        articlesLoader.showError = { [weak self] (error) in
            self?.alert(title: error.localizedDescription)
        }
        articlesLoader.fetchArticles { [weak self] (articles) in
            self?.articles.append(contentsOf: articles)
        }
    }
    
    private func configureTableView() {
        cellBuilder.didSelectCellAction = { [weak self] (indexPath, article) in
            if let viewController = self?.storyboard?.instantiateViewController(withIdentifier: ArticleDetailsViewController.className) as? ArticleDetailsViewController {
                viewController.article = article
                self?.show(viewController, sender: nil)
            }
        }
        tableViewHandler = TableViewHandler(cellIdentifier: ArticleTableViewCell.className, tableView: tableView, cellBuilder: cellBuilder)
        tableViewHandler?.willShowCell = { [weak self] (indexPath) in
            guard let articles = self?.articles, let articlesLoader = self?.articlesLoader else {
                return
            }
            let endIndex = articles.index(before: articles.endIndex)
            if indexPath.row == endIndex - 10, articlesLoader.canLoadMore()  {
                articlesLoader.fetchArticles(completion: { (articles) in
                    self?.articles.append(contentsOf: articles)
                })
            }
        }
    }
    
    deinit {
        print("ArticlesViewController deinit")
    }
}

final class ArticlesLoader: APIClient {
    typealias ErrorAction = (Error) -> ()
    var showError: ErrorAction?
    private var currentPage = 1
    private var totalPages = 1
    
    func fetchArticles(completion:@escaping ([ObjectArticle]) -> ()) {
        print("fetchArticles")
        if let endPoint = ArticlesEndpoint.search(page: currentPage).request {
            request(with: endPoint) { [weak self] (either: Either<ArticlesResponse>) in
                switch either {
                case .success(let articlesResponse):
                    self?.totalPages = articlesResponse.pages ?? 1
                    self?.currentPage = articlesResponse.currentPage ?? 1
                    if let articles = articlesResponse.articles {
                        completion(articles)
                    }
                case .error(let error):
                    completion([])
                    self?.showError?(error)
                }
            }
        }
    }
    
    func canLoadMore() -> Bool {
        print("<#T##items: Any...##Any#>")
        return currentPage < totalPages
    }
}
