//
//  UIImageViewExtension.swift
//  Article
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with URL: URL) {
        self.kf.setImage(with: URL)
    }
}
