//
//  ListDetailViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit
import EMTNeumorphicView

class ListDetailViewController: UIViewController {

    @IBOutlet weak var wordAddButton: UIButton!
    var coordinator : ListDetailViewControllerFlow?
    var viewModel: ListDetailViewModel = ListDetailViewModel()
    @IBOutlet weak var detailButtongradientView: GradientView!
    @IBOutlet weak var imageUIView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var detailButtonView: ButtonGradientView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var paramTitle: String?
    var paramImageName: String?
    var paramListId: Int?
    var idDelivery = IDDelivery.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listGetWord()
    }
}

extension ListDetailViewController {
    func initView() {
        configUI()
        buttonStyle()
        buttonAction()
        tableView.delegate = self
        tableView.dataSource = self
        wordAddButton.addTarget(self, action: #selector(tappedWordAddButton), for: .touchUpInside)
    }
    
    func configUI() {
        view.backgroundColor = UIColor.background
        self.title = "セット詳細"
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
        
        wordAddButton.layer.cornerRadius = wordAddButton.frame.height / 2
        wordAddButton.layer.masksToBounds = false
        wordAddButton.layer.borderWidth = 0.0
        wordAddButton.layer.shadowColor = UIColor.black.cgColor
        wordAddButton.layer.shadowRadius = 2
        wordAddButton.layer.shadowOpacity = 0.2
        wordAddButton.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
//MARK: Model
extension ListDetailViewController {

    func listGetWord() {
        let request = ListWordGetRequest()
        let _ = try? GoGakuHttpClient.default.send(request).onSuccess { [weak self] response in
            debugPrint("list get word success: \(response.status_code)")
            self?.viewModel.list = response.body.data ?? []
            DispatchQueue.main.async {
                self?.titleLabel.text = "\(self?.paramTitle ?? "") - \(self?.viewModel.list.count ?? 0)個の単語"
                self?.tableView.reloadData()
            }
        }.onError { error in
            debugPrint("list get word error: \(error)")
        }
    }
    
    func listWordDelete() {
        viewModel.listWordDelete()
                .subscribe(
                    onSuccess: { _ in
                        debugPrint("listWordDelete")
                        self.tableView.reloadData()
                        self.viewWillAppear(false)
                    },
                    onError: { error in
                        debugPrint(error)
                    }
                )
                .disposed(by: disposeBag)
    }
    
    func listWordUpdate(word: String, mean: String) {
        viewModel.listWordUpdate(word: word, mean: mean)
                .subscribe(
                    onSuccess: { _ in
                        debugPrint("listWordUpdate")
                        self.tableView.reloadData()
                        self.viewWillAppear(false)
                    },
                    onError: { error in
                        debugPrint(error)
                    }
                )
                .disposed(by: disposeBag)
    }
    func listWordAdd(word: String, mean: String) {
        viewModel.listWordAdd(word: word, mean: mean)
                .subscribe(
                    onSuccess: { _ in
                        debugPrint("listWordUpdate")
                        self.tableView.reloadData()
                        self.viewWillAppear(false)
                    },
                    onError: { error in
                        debugPrint(error)
                    }
                )
                .disposed(by: disposeBag)
    }
}

//MARK: Action
extension ListDetailViewController {
    func buttonAction() {
        detailButton.addTarget(self, action: #selector(tappedDetailButton), for: .touchUpInside)
    }
    @objc func tappedDetailButton() {
        let alertC = UIAlertController(title: "", message: "学習方法を選択してください", preferredStyle: .actionSheet)
        let alertCard = UIAlertAction(title: "カード学習", style: .default) { (_) in
            let storyBoard = UIStoryboard(name: "ListStudyViewController", bundle: Bundle.main)
            guard let ListStudyVC = storyBoard.instantiateViewController(identifier: "ListStudyViewController") as? ListStudyViewController else { return }
            ListStudyVC.modalPresentationStyle = .fullScreen
            ListStudyVC.paramTitle = self.paramTitle
            self.present(ListStudyVC, animated: true, completion: nil)
        }
        let alertQuiz = UIAlertAction(title: "クイズ学習", style: .default) { (_) in
            let storyBoard = UIStoryboard(name: "ListQuizViewController", bundle: Bundle.main)
            guard let ListQuizVC = storyBoard.instantiateViewController(identifier: "ListQuizViewController") as? ListQuizViewController else { return }
            ListQuizVC.modalPresentationStyle = .fullScreen
            ListQuizVC.paramTitle = self.paramTitle
            self.present(ListQuizVC, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertC.addAction(alertCard)
        alertC.addAction(alertQuiz)
        alertC.addAction(cancel)
        present(alertC, animated: true, completion: nil)
    }
    
    @objc func tappedWordAddButton() {
            let alertC = UIAlertController(title: "単語追加", message: "", preferredStyle: .alert)
            var wordUpdateTextField = UITextField()
            var meanUpdateTextField = UITextField()
            alertC.addTextField { (wordTF) in
                wordTF.placeholder = "単語を入力してください"
                wordUpdateTextField = wordTF
            }
            alertC.addTextField { (meanTF) in
                meanTF.placeholder = "意味を入力してください"
                meanUpdateTextField = meanTF
            }
            let alertA = UIAlertAction(title: "追加", style: .default) { (_) in
                if (wordUpdateTextField.text == "" && meanUpdateTextField.text == "") || wordUpdateTextField.text == "" || meanUpdateTextField.text == "" {
                    let errorAlertC = UIAlertController(title: "", message: GOGAKUConst.goGakuSetWordErrorAlertMessage, preferredStyle: .alert)
                    let errorAlertA = UIAlertAction(title: "確認", style: .default, handler: nil)
                    errorAlertC.addAction(errorAlertA)
                    self.present(errorAlertC, animated: true, completion: nil)
                } else {
                    self.idDelivery.listID = self.paramListId ?? 0
                    self.listWordAdd(word: wordUpdateTextField.text ?? "", mean: meanUpdateTextField.text ?? "")
                }
            }
            let alertCancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            alertC.addAction(alertA)
            alertC.addAction(alertCancel)
            self.present(alertC, animated: true, completion: nil)
    }
}

extension ListDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListDetailTableViewCell else { fatalError() }
        let data = viewModel.list[indexPath.row]
        cell.wordLabel.text = data.word
        cell.meanLabel.text = data.mean
        cell.wordView.layer.cornerRadius = cell.wordView.frame.height / 2
        cell.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let alert = UIAlertController(title: "", message: GOGAKUConst.goGakuDetailListMessage, preferredStyle: .alert)
        let alertUpdate = UIAlertAction(title: "単語変更", style: .default) { (_) in
            let alertC = UIAlertController(title: "単語変更", message: "", preferredStyle: .alert)
            var wordUpdateTextField = UITextField()
            var meanUpdateTextField = UITextField()
            let wordData = self.viewModel.list[indexPath.row]
            let listWord = wordData.word
            let listMean = wordData.mean
            alertC.addTextField { (wordTF) in
                wordTF.placeholder = "単語を入力してください"
                wordUpdateTextField = wordTF
                wordUpdateTextField.text = listWord
            }
            alertC.addTextField { (meanTF) in
                meanTF.placeholder = "意味を入力してください"
                meanUpdateTextField = meanTF
                meanUpdateTextField.text = listMean
            }
            let alertA = UIAlertAction(title: "変更", style: .default) { (_) in
                let wordData = self.viewModel.list[indexPath.row]
                let data = wordData.id
                let listWord = wordData.word
                let listMean = wordData.mean
                let idDelivery = IDDelivery.shared
                if let data = data {
                    idDelivery.wordID = data
                }
                if (wordUpdateTextField.text == "" && meanUpdateTextField.text == "") {
                    self.listWordUpdate(word: listWord ?? "", mean: listMean ?? "")
                } else if wordUpdateTextField.text == "" {
                    self.listWordUpdate(word: listWord ?? "", mean: meanUpdateTextField.text ?? "")
                } else if meanUpdateTextField.text == "" {
                    self.listWordUpdate(word: wordUpdateTextField.text ?? "", mean: listMean ?? "")
                } else {
                    self.listWordUpdate(word: wordUpdateTextField.text ?? "", mean: meanUpdateTextField.text ?? "")
                }
            }
            let alertCancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            alertC.addAction(alertA)
            alertC.addAction(alertCancel)
            self.present(alertC, animated: true, completion: nil)
        }
        let alertRemove = UIAlertAction(title: "削除", style: .destructive) { (_) in
            let wordData = self.viewModel.list[indexPath.row]
            let data = wordData.id
            let idDelivery = IDDelivery.shared
            if let data = data {
                idDelivery.wordID = data
            }
            self.listWordDelete()
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(alertUpdate)
        alert.addAction(alertRemove)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}
