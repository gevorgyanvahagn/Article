//
//  ArticleDetailsViewController.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

final class ArticleDetailsViewController: UIViewController {
    
    private var tagsCollectionViewHandler: CollectionViewHandler<String, TagCellBuilder>?
    private var wordsCollectionViewHandler: CollectionViewHandler<String, TagCellBuilder>?
    
    @IBOutlet weak var tagsCollectionView: TagsCollectionView!
    @IBOutlet weak var wordsCollectionView: TagsCollectionView!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var words = ["Please", "read", "this", "library", "link", "giving", "below", "it", "has", "awesome", "and", "custom", "tag", "design", "all", "the", "things", "you", "required", "for", "your", "design."]
    
    var article: ObjectArticle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarTransparent = true
        navigationController?.hidesBarsOnSwipe = true
        loadArticle()
        configureSearchCollection()
    }
    
    private func addConfiguredLayout() ->UICollectionViewLeftAlignedLayout {
        let layout = UICollectionViewLeftAlignedLayout()
        layout.estimatedItemSize = CGSize(width: 30, height: 25)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 2
        return layout
    }
    
    private func configureSearchCollection() {
        guard var article = article else {
            assertionFailure()
            return
        }
        
        tagsCollectionView.collectionViewLayout = addConfiguredLayout()
        tagsCollectionView.allowsSelection = false
        
        wordsCollectionView.collectionViewLayout = addConfiguredLayout()
        wordsCollectionView.allowsSelection = true
        
        tagsCollectionViewHandler = CollectionViewHandler(collectionView: tagsCollectionView, cellBuilder: TagCellBuilder())
        tagsCollectionViewHandler?.dataSource = words
        
        let wordsCellBuilder = TagCellBuilder()
        wordsCellBuilder.didSelectCellAction = { [weak self] (index, word) in
            guard let word = word else {
                assertionFailure()
                return
            }
            self?.highlight(word: word)
        }
        wordsCollectionViewHandler = CollectionViewHandler(collectionView: wordsCollectionView, cellBuilder: wordsCellBuilder)
        print("1", Date())

        DispatchQueue.global(qos: .background).async {
            let words = article.frequentWords
            DispatchQueue.main.async {
                self.wordsCollectionViewHandler?.dataSource = words
            }
        }
        
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
    
    private func highlight(word: String) {
        guard let articleText = article?.fields?.bodyText else {
            assertionFailure()
            return
        }
        articleTextLabel.attributedString(in: articleText, changedString: word, atributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .heavy)])
        
    }
}
