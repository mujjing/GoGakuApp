//
//  ListDetailCoordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit

protocol ListDetailViewControllerFlow: class {
    func coordinateToNext()
}

class ListDetailCoordinator: Coordinator, ListDetailViewControllerFlow {
    func coordinateToNext() {
        
    }
    
    let navigationController : UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboardBundle = Bundle.main
        
        let storyBoard = UIStoryboard(name: "ListDetailViewController", bundle: storyboardBundle)
        guard let ListDetailVC = storyBoard.instantiateViewController(identifier: "ListDetailViewController") as? ListDetailViewController else { return }
        ListDetailVC.coordinator = self
        navigationController.pushViewController(ListDetailVC, animated: true)
    }
    
}
