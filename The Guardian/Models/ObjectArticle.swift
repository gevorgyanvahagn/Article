//
//  ObjectArticle.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

struct ObjectArticle: Codable {
    let id: String?
    let sectionID: String?
    let sectionName: String?
    let webTitle: String?
    let fields: ArticleFields?
    let pillarName: String?
    let createdDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case sectionID = "sectionId"
        case sectionName
        case webTitle
        case fields
        case pillarName
        case createdDate = "webPublicationDate"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        sectionID = try container.decodeIfPresent(String.self, forKey: .sectionID)
        sectionName = try container.decodeIfPresent(String.self, forKey: .sectionName)
        webTitle = try container.decodeIfPresent(String.self, forKey: .webTitle)
        fields = try container.decodeIfPresent(ArticleFields.self, forKey: .fields)
        pillarName = try container.decodeIfPresent(String.self, forKey: .pillarName)
        
        if let createdDateString = try container.decodeIfPresent(String.self, forKey: .createdDate) {
            createdDate = DateFormatter.standardFormatter.date(from: createdDateString)
        } else {
            createdDate = nil
        }
    }
}
