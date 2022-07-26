//
//  MainCoordinator.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 24/07/2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var coordinator: MainCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToArticleList(type: HomeCategory) {
        let vc = ArticleListViewController.instantiate()
        vc.intent = type
        vc.coordinator = self
        vc.viewModel = ArticleListViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToSearchArticle() {
        let vc = SearchArticleViewController.instantiate()
        vc.intent = .search
        vc.coordinator = self
        vc.viewModel = SearchArticleViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
}
