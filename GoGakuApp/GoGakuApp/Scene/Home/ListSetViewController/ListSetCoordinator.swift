//
//  ListSetCoordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit

protocol ListSetViewControllerFlow: class {
    func coordinateToListDetailVC()
    func coordinateToListAddVC()
}

class ListSetCoordinator: Coordinator, ListSetViewControllerFlow {
    let navigationController : UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboardBundle = Bundle.main
        
        let storyBoard = UIStoryboard(name: "ListSetViewController", bundle: storyboardBundle)
        guard let ListSetVC = storyBoard.instantiateViewController(identifier: "ListSetViewController") as? ListSetViewController else { return }
        ListSetVC.coordinator = self
        navigationController.pushViewController(ListSetVC, animated: true)
    }
    
    func coordinateToListDetailVC() {
        let listSetCoordinator = ListDetailCoordinator(navigationController: navigationController)
        coordinate(to: listSetCoordinator)
    }
    
    func coordinateToListAddVC() {
        let listSetCoordinator = ListAddCoordinator(navigationController: navigationController)
        coordinate(to: listSetCoordinator)
    }
}
