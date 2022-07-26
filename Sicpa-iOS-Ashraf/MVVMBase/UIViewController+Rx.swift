//
//  UIViewController+Rx.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = sentMessage(#selector(Base.viewDidLoad))
            .map { _ in }
        return ControlEvent(events: source)
    }
    
    var viewWillAppear: ControlEvent<Bool> {
        let source = sentMessage(#selector(Base.viewWillAppear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewDidAppear: ControlEvent<Bool> {
        let source = sentMessage(#selector(Base.viewDidAppear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillDisappear: ControlEvent<Bool> {
        let source = sentMessage(#selector(Base.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewDidDisappear: ControlEvent<Bool> {
        let source = sentMessage(#selector(Base.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillLayoutSubviews: ControlEvent<Void> {
        let source = sentMessage(#selector(Base.viewWillLayoutSubviews))
            .map { _ in }
        return ControlEvent(events: source)
    }
    
    var viewDidLayoutSubviews: ControlEvent<Void> {
        let source = sentMessage(#selector(Base.viewDidLayoutSubviews))
            .map { _ in }
        return ControlEvent(events: source)
    }
    
    var willMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = sentMessage(#selector(Base.willMove))
            .map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    
    var didMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = sentMessage(#selector(Base.didMove))
            .map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    
    var didReceiveMemoryWarning: ControlEvent<Void> {
        let source = sentMessage(#selector(Base.didReceiveMemoryWarning))
            .map { _ in }
        return ControlEvent(events: source)
    }
    
    /// Emmits once the proccess is done then completes
    func present(viewController: UIViewController, animated: Bool) -> ControlEvent<Void> {
        let source = Observable<Void>.create { observable -> Disposable in
            self.base.present(viewController, animated: animated, completion: {
                observable.onNext(())
                observable.onCompleted()
            })
            return Disposables.create {}
        }
        
        return ControlEvent(events: source)
    }
    
    /// Emmits once the proccess is done then completes
    func dismiss(animated: Bool) -> ControlEvent<Void> {
        let source = Observable<Void>.create { observable -> Disposable in
            self.base.dismiss(animated: animated, completion: {
                observable.onNext(())
                observable.onCompleted()
            })
            return Disposables.create {}
        }
        
        return ControlEvent(events: source)
    }
}
