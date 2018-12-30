//
//  ArticlesResponse.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

struct ArticlesResponse: Decodable {
    let currentPage: Int?
    let pages: Int?
    let orderBy: String?
    let articles: [ObjectArticle]?
    
    enum ContainerKeys: String, CodingKey {
        case response
    }
    
    enum CodingKeys: String, CodingKey {
        case currentPage
        case pages
        case orderBy
        case articles = "results"
        case response
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        currentPage = try response.decodeIfPresent(Int.self, forKey: .currentPage)
        pages = try response.decodeIfPresent(Int.self, forKey: .pages)
        orderBy = try response.decodeIfPresent(String.self, forKey: .orderBy)
        articles = try response.decodeIfPresent([ObjectArticle].self, forKey: .articles)
    }
}
