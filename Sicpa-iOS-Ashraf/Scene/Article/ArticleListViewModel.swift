//
//  ArticleListViewModel.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleListViewModel: BaseViewModel {
    
    var articleList = BehaviorRelay<[Article]>(value: [])
    var isLoading = BehaviorRelay<Bool>(value: false)
    var intent: HomeCategory!
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = APIService()) {
        self.service = service
    }
    
    override func transform() {
        super.transform()
        
        let didLoad = contentReady
            .asObservable()
            .subscribe(onNext: { keyword in
                self.loadData(finished: {})
            })
        
        disposeBag.insert(
            didLoad
        )
        
    }
    
    func loadData(finished: @escaping () -> Void) {
        self.isLoading.accept(true)
        service.fetchArticleList(type: intent, completion: {  articles in
            guard let articles = articles else { return }
            self.articleList.accept(articles)
            self.isLoading.accept(false)
            finished()
        })
    }
}

class ArticleListViewModel1: NSObject {
    
     var articleList : Articles
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = APIService()) {
        self.articleList = []
        self.service = service
    }
    
    func loadData(finished: @escaping () -> Void) {
        service.fetchArticleList(type: .mostEmailed, completion: {  articles in
            guard let articles = articles else { return }
            self.articleList = articles
            finished()
        })
    }
}
