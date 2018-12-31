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

    
    lazy var frequentWords: [String] = {
        guard let articleText = fields?.bodyText else {
            return []
        }
        
        let words = articleText.components(separatedBy: .whitespacesAndNewlines)
        let wordsSet = Set(words)
        var frequentWords = Set<String>()
        
        wordsSet.forEach() { (word) in
            
            let count = self.matchesCount(in: articleText, searchString: word)
            if count >= 10 {
                frequentWords.insert(word)
            }
        }
        return Array(frequentWords)
    }()
    
    func matchesCount(in text: String, searchString: String) -> Int {
        
        do {
            let regex = try NSRegularExpression(pattern: "(?<=\\b)\(searchString)(?=\\b)", options: .caseInsensitive)
            
            let matches = regex.matches(in: text, options: NSRegularExpression.MatchingOptions.reportProgress , range: NSRange(location: 0, length: text.utf16.count)) as [NSTextCheckingResult]
            return matches.count
        } catch let error {
            
            return 0
        }
    }
}

struct HashableWord: Hashable, Equatable {
    var text: String
    var count: Int
}
