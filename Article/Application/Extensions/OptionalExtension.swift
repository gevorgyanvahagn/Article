//
//  OptionalExtension.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import Foundation

extension Optional {
    var isNone: Bool {
        return self == nil
    }
    
    var isSome: Bool {
        return self != nil
    }
}
