//
//  HomeViewModel.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    public var didTapBookButton: Driver<Void> = .never()
    var playerPublishRelay = BehaviorRelay<[SelectedHomeCategory]>(value: [])
    
    override func transform() {
        super.transform()
        
        let arr1 = SelectedHomeCategory(category: .search, subCategory: [.search])
        let arr2 = SelectedHomeCategory(category: .popular, subCategory: [.mostViewed, .mostShared, .mostEmailed])
        self.playerPublishRelay.accept([arr1, arr2])
        
        let didTapBook = didTapBookButton
            .do(onNext: {
//                self.view?.openWebview()
            })
        
        disposeBag.insert(
            didTapBook.drive()
        )
    }
    override func dispose() {
        super.dispose()
    }
}
