//
//  ListTitleCoordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/19.
//

import Foundation
import UIKit

protocol ListTitleViewControllerFlow: class {
    func coordinateToTitleNextVC()
}

class ListTitleCoordinator: Coordinator, ListTitleViewControllerFlow {
    let navigationController : UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboardBundle = Bundle.main
        
        let storyBoard = UIStoryboard(name: "ListTitleViewController", bundle: storyboardBundle)
        guard let ListTitleVC = storyBoard.instantiateViewController(identifier: "ListTitleViewController") as? ListTitleViewController else { return }
        ListTitleVC.coordinator = self
        navigationController.pushViewController(ListTitleVC, animated: true)
    }
    
    func coordinateToTitleNextVC() {
        let listAddCoordinator = ListAddCoordinator(navigationController: navigationController)
        coordinate(to: listAddCoordinator)
    }
}
