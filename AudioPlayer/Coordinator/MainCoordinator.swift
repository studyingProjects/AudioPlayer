//
//  MainCoordinator.swift
//  AudioPlayer
//
//  Created by Andrei Shpartou on 03/04/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }

    func start()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // let viewController = PlaylistViewController()
        let viewController = PlayerViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}
