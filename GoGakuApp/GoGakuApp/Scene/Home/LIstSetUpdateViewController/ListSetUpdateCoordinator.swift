//
//  ListSetUpdateCoordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import Foundation
import UIKit

protocol ListSetUpdateViewControllerFlow: class {
    func coordinateToTitleNextVC()
}

class ListSetUpdateCoordinator: Coordinator, ListSetUpdateViewControllerFlow {
    let navigationController : UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboardBundle = Bundle.main
        
        let storyBoard = UIStoryboard(name: "ListSetUpdateViewController", bundle: storyboardBundle)
        guard let ListSetUpdateVC = storyBoard.instantiateViewController(identifier: "ListSetUpdateViewController") as? ListSetUpdateViewController else { return }
        ListSetUpdateVC.coordinator = self
        navigationController.pushViewController(ListSetUpdateVC, animated: true)
    }
    
    func coordinateToTitleNextVC() {
        let listAddCoordinator = ListAddCoordinator(navigationController: navigationController)
        coordinate(to: listAddCoordinator)
    }
}
