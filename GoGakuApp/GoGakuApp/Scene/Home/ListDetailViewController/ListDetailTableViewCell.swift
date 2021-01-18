//
//  ListDetailTableViewCell.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/14.
//

import UIKit

class ListDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var wordView: GradientView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
