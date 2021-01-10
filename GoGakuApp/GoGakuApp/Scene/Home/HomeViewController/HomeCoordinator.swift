//
//  HomeCoordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit

protocol HomeViewControllerFlow: class {
    func coordinateToListSetVC()
}

class HomeCoordinator: Coordinator, HomeViewControllerFlow{
    let navigationController : UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboardBundle = Bundle.main
        
        let storyBoard = UIStoryboard(name: "HomeViewController", bundle: storyboardBundle)
        guard let homeVC = storyBoard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        homeVC.coordinator = self
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func coordinateToListSetVC() {
        let listSetCoordinator = ListSetCoordinator(navigationController: navigationController)
        coordinate(to: listSetCoordinator)
    }
}

