//
//  ArticleDetailsViewController.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var article: ObjectArticle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarTransparent = true
        loadArticle()
    }
    
    private func loadArticle() {
        guard let atticle = article else {
            assertionFailure("Article is missing")
            return
        }
        
        if let imageURL = article?.fields?.thumbnail {
            thumbnailImageView.setImage(with: imageURL)
        }
    }
}

@IBDesignable class TriangleView: UIView {
    
    private var path: UIBezierPath!
    
    override func draw(_ rect: CGRect) {
        createTriangle()
    }
    
    private func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.close()
        
        UIColor.white.setFill()
        path.fill()
    }
}
