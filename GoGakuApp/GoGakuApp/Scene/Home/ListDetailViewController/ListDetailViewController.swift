//
//  ListDetailViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit

class ListDetailViewController: UIViewController {

    var coordinator : ListDetailViewControllerFlow?
    @IBOutlet weak var imageUIView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var detailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        self.title = "セット詳細"
    }

}
