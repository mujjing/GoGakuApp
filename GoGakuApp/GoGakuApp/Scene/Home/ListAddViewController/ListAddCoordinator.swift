//
//  ListAddCoordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import Foundation
import UIKit

protocol ListAddViewControllerFlow: class {
    func coordinateToListNextVC()
}

class ListAddCoordinator: Coordinator, ListAddViewControllerFlow {
    let navigationController : UINavigationController
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboardBundle = Bundle.main
        
        let storyBoard = UIStoryboard(name: "ListAddViewController", bundle: storyboardBundle)
        guard let ListAddVC = storyBoard.instantiateViewController(identifier: "ListAddViewController") as? ListAddViewController else { return }
        ListAddVC.coordinator = self
        navigationController.pushViewController(ListAddVC, animated: true)
    }
    
    func coordinateToListNextVC() {
        
    }
}
