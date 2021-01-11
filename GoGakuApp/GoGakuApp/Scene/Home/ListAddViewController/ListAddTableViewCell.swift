//
//  ListAddTableViewCell.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import UIKit

class ListAddTableViewCell: UITableViewCell {

    @IBOutlet weak var wordCellView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meanLabel: UILabel!
    
    var cellSize: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelStyle()
        wordCellView.layer.cornerRadius = wordCellView.frame.height / 2
    }
    
    func labelStyle() {
        wordLabel.textColor = UIColor.labelNavy
        meanLabel.textColor = UIColor.labelPink
    }
}
