//
//  ArticlesEndpoint.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

enum ArticlesEndpoint: Endpoint {
    
    case search(page: Int)
    case sections
    
    var baseUrl: String {
        return Constants.EndPints.entryPoint
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        case .sections:
            return "/sections"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .get
        case .sections:
            return .get
        }
    }
    
    var urlParameters: [URLQueryItem] {
        switch self {
        case .search(let page):
            return [
                URLQueryItem(name: "show-fields", value: "bodyText,thumbnail"),
                URLQueryItem(name: "page-size", value: "40"),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "api-key", value: Constants.Keys.APIKey)
            ]
        case .sections:
            return [
                URLQueryItem(name: "api-key", value: Constants.Keys.APIKey)
            ]
        }
    }
}
