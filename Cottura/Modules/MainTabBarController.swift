//
//  MainTabBarController.swift
//  Cottura
//
//  Created by Ignacio Paradisi on 8/24/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private let orderListViewController = OrderListViewController()
    private let menuSplitViewController = MenuSplitViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        orderListViewController.tabBarItem = UITabBarItem(title: "Pedidos", image: UIImage(systemName: "tray.full"), tag: 0)
        menuSplitViewController.tabBarItem = UITabBarItem(title: "Menú", image: UIImage(systemName: "doc.text"), tag: 1)
        menuSplitViewController.preferredDisplayMode = .allVisible
        viewControllers = [
            UINavigationController(rootViewController: orderListViewController),
            menuSplitViewController
        ]
    }
}

