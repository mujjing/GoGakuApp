//
//  ListSetViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit

class ListSetViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var coordinator : ListSetViewControllerFlow?
    var viewModel : ListSetViewModel = ListSetViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

}

//init
extension ListSetViewController {
    func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewCellUI()
        self.title = "学習セットリスト"
        view.backgroundColor = UIColor.background

    }
    func collectionViewCellUI(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 110, right: 15)
        let size = (view.frame.width - 50) / 2
        layout.itemSize = CGSize(width: size, height: 147)
        collectionView.collectionViewLayout = layout
    }
}

extension ListSetViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dummy.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = indexPath.row < viewModel.dummy.count ? "categoryCell" : "addButtonCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        setupCell(cell: cell, indexPath: indexPath, type: cellID)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellID = indexPath.row < viewModel.dummy.count ? "categoryCell" : "addButtonCell"
        tappedCategoryCell(indexPath: indexPath, type: cellID)
    }
    
    func tappedCategoryCell(indexPath: IndexPath, type: String) {
        switch type {
        case "categoryCell":
            let storyBoard = UIStoryboard(name: "ListDetailViewController", bundle: Bundle.main)
            guard let ListDetailVC = storyBoard.instantiateViewController(identifier: "ListDetailViewController") as? ListDetailViewController else { return }
            ListDetailVC.paramTitle = viewModel.dummy[indexPath.row].name
            ListDetailVC.paramImageName = viewModel.dummy[indexPath.row].image
            navigationController?.pushViewController(ListDetailVC, animated: true)
        default:
            break
        }
    }
    
    func setupCell(cell: UICollectionViewCell, indexPath: IndexPath, type: String) {
            switch(type) {
            case "categoryCell":
                setupListCell(cell: cell as! ListSetCollectionViewCell, indexPath: indexPath)
            case "addButtonCell":
                setupSpecialCell(cell: cell as! ListSetAddButtonCollectionViewCell, indexPath: indexPath)
            default:
                break
            }
        }
    func setupListCell(cell: ListSetCollectionViewCell, indexPath: IndexPath) {
        cell.listImage.image = UIImage(named: viewModel.dummy[indexPath.row].image ?? "") 
        cell.listLabel.text = viewModel.dummy[indexPath.row].name
        cell.listImage.layer.cornerRadius = 10
        cell.belowView.layer.cornerRadius = 10
        cell.belowView.layer.borderColor = UIColor.lineViewLayer.cgColor
        cell.belowView.layer.borderWidth = 1
        cell.aboveView.layer.cornerRadius = 10
        cell.aboveView.layer.borderColor = UIColor.lineViewLayer.cgColor
        cell.aboveView.layer.borderWidth = 1
        cell.aboveView.layer.backgroundColor = UIColor.background.cgColor
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
       }

       func setupSpecialCell(cell: ListSetAddButtonCollectionViewCell, indexPath: IndexPath) {
        cell.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        cell.addButtonView.layer.cornerRadius = 10
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
       }
}

// action
extension ListSetViewController {
    @objc func addButtonTapped() {
        debugPrint("add")
        coordinator?.coordinateToListAddVC()
    }
}
