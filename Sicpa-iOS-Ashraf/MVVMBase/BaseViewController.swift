//
//  BaseViewController.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 24/07/2022.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController<VM> : UIViewController where VM : BaseViewModelType {
    //MARK: State
    var disposeBag = DisposeBag()
    var viewModel: VM! {
        didSet {
            if let vm = viewModel {
                vm.disposed(by: disposeBag)
            }
        }
    }
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTransformInput()
        transform()
        subscribe()
    }

    func dispose() {
        self.dispose()
    }
    
    deinit {
    }
    //MARK: setupView
    func setupView() {
    }
    //MARK: transform
    func setupTransformInput() {
        
    }
    
    func transform() {
        viewModel.transform()
    }
    //MARK: subscribe
    func subscribe() {
        disposeBag.insert(
        )
    }
    
    var isNavigationBarHidden: Bool {
        return false
    }
}
