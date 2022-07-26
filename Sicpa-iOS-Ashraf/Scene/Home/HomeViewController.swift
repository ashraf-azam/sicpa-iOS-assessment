//
//  HomeViewController.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewController: UITableViewController, Storyboarded {
    
    private let homeCellIdentifier: String = "HomeTableViewCell"
    var playerPublishRelay = BehaviorRelay<[SelectedHomeCategory]>(value: [])
    let disposeBag = DisposeBag()
    
    weak var coordinator: MainCoordinator?
    
    let service: ServiceProtocol = APIService()
    var articleList : Articles = []
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(self.tableViewCellNib(), forCellReuseIdentifier: homeCellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        
        let arr1 = SelectedHomeCategory(category: .search, subCategory: [.search])
        let arr2 = SelectedHomeCategory(category: .popular, subCategory: [.mostViewed, .mostShared, .mostEmailed])
        self.playerPublishRelay.accept([arr1, arr2])
        self.title = "NYT Articles"
    }
    
    func tableViewCellNib() -> UINib {
        return UINib(nibName: homeCellIdentifier, bundle: Bundle.main)
    }
    
}

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width:tableView.frame.width, height: 50))
        titleLabel.text = self.playerPublishRelay.value[section].category.rawValue
        titleLabel.font = .boldSystemFont(ofSize: 16)
        headerView.addSubview(titleLabel)
        headerView.tintColor = .lightGray
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playerPublishRelay.value[section].subCategory.count
    }
         
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        as! HomeTableViewCell
        cell.categoryLabel.text = self.playerPublishRelay.value[indexPath.section].subCategory[indexPath.row].rawValue
        return cell
    }
         
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.playerPublishRelay.value.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = self.playerPublishRelay.value[indexPath.section].subCategory[indexPath.row]
        if type == .search {
            coordinator?.navigateToSearchArticle()
        } else {
            coordinator?.navigateToArticleList(type: type)
        }
    }
}
