//
//  UIViewControllerExtension.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String? = nil, action: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            action?()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
