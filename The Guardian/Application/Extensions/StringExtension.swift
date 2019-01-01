//
//  StringExtension.swift
//  The Guardian
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
}
