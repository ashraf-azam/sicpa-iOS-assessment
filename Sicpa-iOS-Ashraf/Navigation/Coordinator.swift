//
//  Coordinator.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 24/07/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
