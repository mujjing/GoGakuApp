//
//  ListStudyCoordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/14.
//

import Foundation
import UIKit

protocol ListStudyViewControllerFlow: class {
    func coordinateToListNextVC()
}

class ListStudyCoordinator: Coordinator, ListStudyViewControllerFlow, ListAddViewControllerFlow {
    let navigationController : UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboardBundle = Bundle.main
        
        let storyBoard = UIStoryboard(name: "ListStudyViewController", bundle: storyboardBundle)
        guard let ListStudyVC = storyBoard.instantiateViewController(identifier: "ListStudyViewController") as? ListAddViewController else { return }
        ListStudyVC.coordinator = self
        navigationController.pushViewController(ListStudyVC, animated: true)
    }
    
    func coordinateToListNextVC() {
        
    }
}

