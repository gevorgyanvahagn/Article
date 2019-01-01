//
//  ObjectArticle.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

class ObjectArticle: Codable {
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
    
    required public init(from decoder: Decoder) throws {
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
    
    lazy var tags: [String] = {
        if let tags = webTitle?.words.shuffled() {
            return tags
        }
        return []
    }()
    
    lazy var frequentWords: [String] = {
        guard let articleText = fields?.bodyText else {
            return []
        }
        
        let words = articleText.words
        let wordsSet = Set(words.map({ $0.lowercased() }))
        var frequentWords = Set<String>()
        
        wordsSet.forEach() { (word) in
            
            let count = articleText.matchesCount(of: word)
            if count >= 10 {
                frequentWords.insert(word)
            }
        }
        return Array(frequentWords)
    }()
}
