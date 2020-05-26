//
//  NSObjectExtension.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self.self)
    }
}
