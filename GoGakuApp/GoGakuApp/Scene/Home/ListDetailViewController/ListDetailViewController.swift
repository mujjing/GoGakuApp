//
//  ListDetailViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit
import EMTNeumorphicView

class ListDetailViewController: UIViewController {

    var coordinator : ListDetailViewControllerFlow?
    @IBOutlet weak var detailButtongradientView: GradientView!
    @IBOutlet weak var imageUIView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var detailButtonView: ButtonGradientView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var paramTitle: String?
    var paramImageName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

}

extension ListDetailViewController {
    func initView() {
        configUI()
        buttonStyle()
    }
    
    func configUI() {
        view.backgroundColor = UIColor.background
        self.title = "セット詳細"
        titleLabel.text = "\(paramTitle ?? "") - 2個の単語"
        titleLabel.textColor = UIColor.labelNavy
        image.image = UIImage(named: paramImageName ?? "")
        imageUIView.layer.cornerRadius = 20
        imageUIView.layer.masksToBounds = false
        imageUIView.layer.borderWidth = 0.0
        imageUIView.layer.shadowColor = UIColor.black.cgColor
        imageUIView.layer.shadowRadius = 2
        imageUIView.layer.shadowOpacity = 0.2
        imageUIView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    func buttonStyle() {
        detailButtonView.layer.cornerRadius = detailButtonView.frame.height / 2
        detailButton.layer.cornerRadius = detailButton.frame.height / 2
        detailButtongradientView.layer.cornerRadius = detailButtongradientView.frame.height / 2
        detailButtonView.layer.masksToBounds = false
        detailButtonView.layer.borderWidth = 0.0
        detailButtonView.layer.shadowColor = UIColor.black.cgColor
        detailButtonView.layer.shadowRadius = 2
        detailButtonView.layer.shadowOpacity = 0.2
        detailButtonView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}

extension ListDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListDetailTableViewCell else { fatalError() }
        
        return cell
    }
    
    
}
