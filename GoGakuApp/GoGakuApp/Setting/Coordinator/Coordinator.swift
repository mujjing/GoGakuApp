//
//  Coordinator.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinate: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator){
        coordinator.start()
    }
}
