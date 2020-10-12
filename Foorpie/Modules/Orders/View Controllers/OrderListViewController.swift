//
//  OrderListViewController.swift
//  Cottura
//
//  Created by Ignacio Paradisi on 8/24/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class OrderListViewController: BaseViewController {

    private let tableView: UITableView = UITableView()
    
    override func setupView() {
        super.setupView()
        setupTableView()
        addErrorMessage()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = LocalizedStrings.Title.orders
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItems = [addButtonItem, editButtonItem]
        
//        guard let navigationBar = navigationController?.navigationBar else { return }
//
//        
//        print(navigationBar.subviews.count)
//        
//        for subview in navigationBar.subviews where NSStringFromClass(subview.classForCoder).contains("NavigationBarContentView") {
//            let topLabel = UILabel()
//            topLabel.text = "Hola"
//            subview.addSubview(topLabel)
//            topLabel.anchor.leadingToSuperview().bottomToSuperview().trailingToSuperview().activate()
//        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor.edgesToSuperview().activate()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderTableViewCell.self)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

}

// MARK: - UITableViewDataSource
extension OrderListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as OrderTableViewCell
        cell.configure(orderNumber: indexPath.row, clientName: "Ignacio Paradisi", status: "Preparando")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
}

// MARK: - UITableViewDelegate
extension OrderListViewController: UITableViewDelegate {
}
