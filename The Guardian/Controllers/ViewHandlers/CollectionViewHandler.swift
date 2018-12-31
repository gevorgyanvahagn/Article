//
//  CollectionViewHandler.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 31/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

class CollectionViewHandler<Data, Builder: CellBuilder>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate where Builder.Data == Data {
    
    weak var collectionView: UICollectionView?
    var cellIdentifier: String
    var dataSource: [Data] =  [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var cellBuilder: Builder?
    
    init(collectionView: UICollectionView, cellBuilder: Builder) {
        self.cellIdentifier = cellBuilder.identifier
        self.collectionView = collectionView
        self.cellBuilder = cellBuilder
        super.init()
        configure()
    }
    
    deinit {
        print("TableViewHandler deinit")
    }
    
    func configure() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        if dataSource.indices.contains(indexPath.row) {
            cellBuilder?.configureCell(&cell, data: dataSource[indexPath.row])
        } else {
            assertionFailure("out of range")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellBuilder?.didSelectCell(at: indexPath, data: dataSource[indexPath.row])
    }
}
