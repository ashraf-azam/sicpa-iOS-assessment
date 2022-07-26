//
//  BaseViewModel.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 24/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: BaseViewModelType, ViewModelType, ReactiveCompatible {
    //MARK: Input
    public var startLoad: Driver<Void> = .never()
    public var startResume: Driver<Void> = .never()
    public var startReload: Driver<Void> = .never()
    public var startLoadMore: Driver<Void> = .never()
    public var startExit: Driver<Void> = .never()
    //MARK: Output
    public var showLoading: Driver<Bool> = .never()
    public var contentReady: Driver<Bool> = .never()
    
    public var disposeBag = DisposeBag()
    //MARK: transform
    func transform() {
        
    }
    func subscribe() {
        
    }
    func dispose() {
        //Log.debug("\(self)@")
        //Input
        startLoad = .never()
        startResume = .never()
        startReload = .never()
        startExit = .never()
        //Output
        showLoading = .never()
        contentReady = .never()
        //DisposeBag
        disposeBag = DisposeBag()
    }
    deinit {
    }
}

protocol BaseViewModelType: ViewModelType {
    //MARK: Input
    var startLoad: Driver<Void> { set get }
    var startResume: Driver<Void> { set get }
    var startReload: Driver<Void> { set get }
    var startLoadMore: Driver<Void> { set get }
    var startExit: Driver<Void> { set get }
    //MARK: Output
    var showLoading: Driver<Bool> { set get }
    var contentReady: Driver<Bool> { set get }
}

protocol ViewModelType: Disposable {
    func transform()
}
