//
//  ListStudyViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/14.
//

import UIKit

class ListStudyViewController: UIViewController {

    @IBOutlet weak var dismissButtonView: GradientView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dismissButton: UIButton!
    var coordinator : ListStudyViewControllerFlow?
    var paramTitle: String?
    var viewModel: ListStudyViewModel = ListStudyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

extension ListStudyViewController {
    func initView() {
        buttonEvent()
        configUI()
        titleLabel.text = paramTitle
    }
    func configUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: collectionView.frame.size.height - 30)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemAlpha = 1.0
        flowLayout.sideItemScale = 0.8
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = flowLayout
        dismissButtonView.layer.cornerRadius = dismissButtonView.frame.height / 2
    }
    func buttonEvent() {
        dismissButton.addTarget(self, action: #selector(tappedDismissButton), for: .touchUpInside)
    }
    @objc func tappedDismissButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension ListStudyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ListStudyCollectionViewCell else { fatalError() }
        cell.wordLabel.text = viewModel.dummy[indexPath.row].image ?? ""
        cell.word = viewModel.dummy[indexPath.row].image ?? ""
        cell.mean = viewModel.dummy[indexPath.row].name
        cell.wordLabel.textColor = UIColor.labelNavy
        cell.cellStyle(cell: cell)
        cell.taplabel.textColor = UIColor.labelNavy
        return cell
    }
    
}
