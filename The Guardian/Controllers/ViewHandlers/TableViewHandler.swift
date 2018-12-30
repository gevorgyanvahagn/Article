//
//  TableViewHandler.swift
//  The Guardian
//
//  Created by Vahagn Gevorgyan on 30/12/2018.
//  Copyright © 2018 Vahagn Gevorgyan. All rights reserved.
//

import UIKit

class TableViewHandler<Data, Builder: CellBuilder>: NSObject, UITableViewDataSource, UITableViewDelegate where Builder.Data == Data {
    
    weak var tableView: UITableView?
    var cellIdentifier: String
    var dataSource: [Data] =  [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var cellBuilder: Builder?
    
    init(cellIdentifier: String, tableView: UITableView, cellBuilder: Builder) {
        self.cellIdentifier = cellIdentifier
        self.tableView = tableView
        self.cellBuilder = cellBuilder
        super.init()
        configure()
    }
    
    deinit {
        print("TableViewHandler deinit")
    }
    
    func configure() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cellBuilder?.configureCell(&cell, data: dataSource[indexPath.row])
        return cell
    }
}
