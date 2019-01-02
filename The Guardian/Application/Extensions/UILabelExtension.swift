//
//  UILabelExtension.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 31/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

extension UILabel {
    
    func attributedString(in text: String, changedString: String?, atributes: [NSAttributedString.Key : Any]) {
        let attributedText = NSMutableAttributedString(string: text)
        
        guard let changedString = changedString else {
            self.attributedText = attributedText
            return
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "(?<=\\b)\(changedString)(?=\\b)", options: .caseInsensitive)
            
            for match in regex.matches(in: text, options: NSRegularExpression.MatchingOptions.reportProgress , range: NSRange(location: 0, length: text.utf16.count)) as [NSTextCheckingResult] {
    
                attributedText.addAttributes(atributes, range: match.range)
            }
            self.attributedText = attributedText
        } catch let error {
            assertionFailure(error.localizedDescription)
        }
    }
}
