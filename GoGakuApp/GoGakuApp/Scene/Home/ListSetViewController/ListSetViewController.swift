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
    override func viewWillAppear(_ animated: Bool) {
        listSetData()
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
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(backButtonTapped))

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

//MARK: model
extension ListSetViewController {
    func listSetData() {
        let request = ListSetRequest()
        let _ = try? GoGakuHttpClient.default.send(request).onSuccess { [weak self] response in
            if let list = response.body.data {
                self?.viewModel.list = list
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }.onError { error in
            debugPrint("list set error: \(error)")
        }
    }
    func listSetDelete() {
        viewModel.listDelete()
                .subscribe(
                    onSuccess: { _ in
                        debugPrint("listSetDelete")
                        self.collectionView.reloadData()
                        self.viewWillAppear(false)
                    },
                    onError: { error in
                        debugPrint(error)
                    }
                )
                .disposed(by: disposeBag)
    }
}

extension ListSetViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.list.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = indexPath.row < viewModel.list.count ? "categoryCell" : "addButtonCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        setupCell(cell: cell, indexPath: indexPath, type: cellID)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellID = indexPath.row < viewModel.list.count ? "categoryCell" : "addButtonCell"
        tappedCategoryCell(indexPath: indexPath, type: cellID)
    }
    
    func tappedCategoryCell(indexPath: IndexPath, type: String) {
        switch type {
        case "categoryCell":
            let alertC = UIAlertController(title: "", message: GOGAKUConst.goGakuSetSelectMessage, preferredStyle: .actionSheet)
            let alertDetail = UIAlertAction(title: "セット詳細", style: .default) { (_) in
                let storyBoard = UIStoryboard(name: "ListDetailViewController", bundle: Bundle.main)
                guard let ListDetailVC = storyBoard.instantiateViewController(identifier: "ListDetailViewController") as? ListDetailViewController else { return }
                ListDetailVC.paramTitle = self.viewModel.list[indexPath.row].title
                ListDetailVC.paramImageName = self.viewModel.list[indexPath.row].image
                ListDetailVC.paramListId = self.viewModel.list[indexPath.row].id
                let idDelivery = IDDelivery.shared
                idDelivery.listID = self.viewModel.list[indexPath.row].id
                self.navigationController?.pushViewController(ListDetailVC, animated: true)
            }
            let alertUpdate = UIAlertAction(title: "セット編集", style: .default) { (_) in
                let storyBoard = UIStoryboard(name: "ListSetUpdateViewController", bundle: Bundle.main)
                guard let ListUpdateVC = storyBoard.instantiateViewController(identifier: "ListSetUpdateViewController") as? ListSetUpdateViewController else { return }
                ListUpdateVC.paramTitle = self.viewModel.list[indexPath.row].title
                ListUpdateVC.paramImage = self.viewModel.list[indexPath.row].image
                ListUpdateVC.paramId = self.viewModel.list[indexPath.row].id
                let idDelivery = IDDelivery.shared
                idDelivery.listID = self.viewModel.list[indexPath.row].id
                self.navigationController?.pushViewController(ListUpdateVC, animated: true)
            }
            let alertDelete = UIAlertAction(title: "セット削除", style: .destructive) { (_) in
                let alertController = UIAlertController(title: "", message: GOGAKUConst.goGakuSetDeleteMessage, preferredStyle: .alert)
                let alertRemove = UIAlertAction(title: "削除", style: .destructive) { (_) in
                    let idDelivery = IDDelivery.shared
                    idDelivery.listID = self.viewModel.list[indexPath.row].id
                    self.listSetDelete()
                }
                let alertCancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
                alertController.addAction(alertRemove)
                alertController.addAction(alertCancel)
                self.present(alertController, animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            alertC.addAction(alertDetail)
            alertC.addAction(alertUpdate)
            alertC.addAction(alertDelete)
            alertC.addAction(cancel)
            
            present(alertC, animated: true, completion: nil)
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
        cell.listImage.image = UIImage(named: viewModel.list[indexPath.row].image )
        cell.listLabel.text = viewModel.list[indexPath.row].title
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
        coordinator?.coordinateToListTitleVC()
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
