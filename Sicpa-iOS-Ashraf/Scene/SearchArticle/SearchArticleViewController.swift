//
//  SearchArticleViewController.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchArticleViewController: BaseViewController<SearchArticleViewModel>, Storyboarded, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var instructionLabel: UILabel!
    
    private let articleCellIdentifier: String = "ArticleTableViewCell"
        
    var intent: HomeCategory!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(self.tableViewCellNib(), forCellReuseIdentifier: articleCellIdentifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        searchBar.searchTextField.font = .boldSystemFont(ofSize: 14)
        title = intent.rawValue
    }
    
    func tableViewCellNib() -> UINib {
        return UINib(nibName: articleCellIdentifier, bundle: Bundle.main)
    }
    
    override func setupTransformInput() {
        let searchBarBinding = searchBar.searchTextField.rx.text.bind(to: viewModel.searchText)
        let instructionBinding = viewModel.isHideInstruction.bind(to: instructionLabel.rx.isHidden)
        disposeBag.insert(
            searchBarBinding,
            instructionBinding
        )
    }
    
    override func subscribe() {
        let cardBinding = viewModel._searchArticleList.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: articleCellIdentifier)) {
                index , item, cell in
                if let cardCell = cell as? ArticleTableViewCell {
                    let article = Article(heading: item.headline?.main ?? "N/A", date: item.publishedDate ?? "", categoryType: .search)
                    let articleVM = ArticlesDetailsViewModel(article: article)
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
