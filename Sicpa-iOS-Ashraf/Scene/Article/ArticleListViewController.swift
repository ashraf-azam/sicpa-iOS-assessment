//
//  ArticleListViewController.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ArticleListViewController: BaseViewController<ArticleListViewModel>, UITableViewDelegate, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let articleCellIdentifier: String = "ArticleTableViewCell"
    
    var intent: HomeCategory!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(self.tableViewCellNib(), forCellReuseIdentifier: articleCellIdentifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.intent = self.intent
        title = intent.rawValue
    }
    
    func tableViewCellNib() -> UINib {
        return UINib(nibName: articleCellIdentifier, bundle: Bundle.main)
    }
    
    override func setupTransformInput() {
        viewModel.contentReady = rx.viewDidAppear.asDriver()
    }
    
    override func subscribe() {
        let cardBinding = viewModel.articleList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: articleCellIdentifier)) {
                index , item, cell in
                if let cardCell = cell as? ArticleTableViewCell {
                    let articleVM = ArticlesDetailsViewModel(article: item)
                    cardCell.viewModel = articleVM
                }
            }
        
        let isLoadingEvent = viewModel.isLoading.asObservable()
            .bind(to: self.activityIndicator.rx.isAnimating)
        
        disposeBag.insert(
            cardBinding,
            isLoadingEvent
        )
    }
}
