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
    
    var isNavigationBarTransparent: Bool {
        get {
            guard let navigationBar = navigationController?.navigationBar else { return false }
            return navigationBar.shadowImage != UINavigationBar.appearance().shadowImage
        }
        
        set(isTranslucent) {
            guard let navigationBar = navigationController?.navigationBar else { return }
            if isTranslucent {
                navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationBar.shadowImage = UIImage()
            } else {
                let backgroundImage = UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default)
                navigationBar.setBackgroundImage(backgroundImage, for:.default)
                navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
            }
        }
    }
}
