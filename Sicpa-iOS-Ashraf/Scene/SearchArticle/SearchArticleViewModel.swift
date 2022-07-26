//
//  SearchArticleViewModel.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class SearchArticleViewModel: BaseViewModel {
    
    var searchText = BehaviorRelay<String?>(value: nil)
    var _searchArticleList = BehaviorRelay<[SearchArticle]>(value: [])
    var isLoading = BehaviorRelay<Bool>(value: false)
    var isHideInstruction = BehaviorRelay<Bool>(value: false)
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = APIService()) {
        self.service = service
    }
    
    override func transform() {
        super.transform()
        
        let textSearch = searchText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .filter({ $0?.count ?? 0 > 2})
            .subscribe(onNext: { keyword in
                self.loadData(finished: {}, keyword: keyword)
            })
        
        disposeBag.insert(
            textSearch
        )
        
    }
    
    
    func loadData(finished: @escaping () -> Void, keyword: String?) {
        self.isLoading.accept(true)
        service.fetchSearchArticle(keyword: keyword ?? "", completion: {  articles in
            guard let articles = articles else { return }
            self.isHideInstruction.accept(true)
            self._searchArticleList.accept(articles)
            self.isLoading.accept(false)
            finished()
        })
    }
}
