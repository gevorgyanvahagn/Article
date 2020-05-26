//
//  StringExtension.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 01/01/2019.
//  Copyright © 2019 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

extension String {
    var nonEmptyString: String? {
        if self.isNonEmptyString {
            return self
        } else {
            return nil
        }
    }
    
    var isNonEmptyString: Bool {
        return self != ""
    }
    
    var readingDuration: Int {
        return Int(count / 500)
    }
    
    var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespaces)
            .filter{!$0.isEmpty}
    }
    
    func matchesCount(of string: String) -> Int {
        
        do {
            let regex = try NSRegularExpression(pattern: "(?<=\\b)\(string)(?=\\b)", options: .caseInsensitive)
            
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress , range: NSRange(location: 0, length: self.utf16.count)) as [NSTextCheckingResult]
            return matches.count
        } catch {
            return 0
        }
    }
}
