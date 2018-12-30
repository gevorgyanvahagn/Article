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
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var words = ["Please", "read", "this", "library", "link", "giving", "below", "it", "has", "awesome", "and", "custom", "tag", "design", "all", "the", "things", "you", "required", "for", "your", "design."]
    
    @IBOutlet weak var collectionView: TagsCollectionView!
    
    var article: ObjectArticle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarTransparent = true
        navigationController?.hidesBarsOnSwipe = true
        loadArticle()
        configureSearchCollection()
        configureTagsCollectionView()
    }
    
    private func configureSearchCollection() {
        let layout = UICollectionViewLeftAlignedLayout()
        layout.estimatedItemSize = CGSize(width: 30, height: 25)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 2
        collectionView?.collectionViewLayout = layout
    }
    
    private func configureTagsCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func loadArticle() {
        guard let article = article else {
            assertionFailure("Article is missing")
            return
        }
        
        if let imageURL = article.fields?.thumbnail {
            thumbnailImageView.setImage(with: imageURL)
        }
        
        if let articleText = article.fields?.bodyText {
            articleTextLabel.text = articleText
        }
    }
}

extension ArticleDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? TagCollectionViewCell {
            cell.titleLabel.text = words[indexPath.item]
        }
        return cell
    }
    
    
}
