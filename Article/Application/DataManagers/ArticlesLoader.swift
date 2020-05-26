//
//  ArticlesLoader.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 01/01/2019.
//  Copyright © 2019 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

final class ArticlesLoader: APIClient {
    typealias ErrorAction = (Error) -> ()
    var showError: ErrorAction?
    private var currentPage = 1
    private var totalPages = 1
    
    func fetchArticles(completion:@escaping ([ObjectArticle]) -> ()) {
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
        return currentPage < totalPages
    }
}
