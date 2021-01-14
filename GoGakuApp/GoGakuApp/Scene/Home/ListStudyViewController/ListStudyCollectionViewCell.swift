//
//  ListStudyCollectionViewCell.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/14.
//

import UIKit

class ListStudyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var taplabel: UILabel!
    @IBOutlet weak var cardView: GradientView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var flipButton: UIButton!
    var isopen = false
    var viewDelegate : UIViewController?
    var word : String?
    var mean : String?
    
    @IBAction func tappedFlipButton(_ sender: Any) {
        if isopen {
            isopen = false
            wordLabel.text = word
            taplabel.text = GOGAKUConst.goGakuStudyCardFrontLabel
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }else{
            isopen = true
            wordLabel.text = mean
            taplabel.text = GOGAKUConst.goGakuStudyCardBehindLabel
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    func cellStyle(cell: UICollectionViewCell) {
        cell.layer.cornerRadius = 15
        cardView.layer.cornerRadius = 15
    }
}
