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
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listSetData()
    }
}

extension ListDetailViewController {
    func initView() {
        configUI()
        buttonStyle()
        buttonAction()
        tableView.delegate = self
        tableView.dataSource = self
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
    }
}
//MARK: Model
extension ListDetailViewController {
    func listSetData() {
        let request = ListSetRequest()
        let _ = try? GoGakuHttpClient.default.send(request).onSuccess { [weak self] response in
            if let list = response.body.data {
                self?.viewModel.list = list
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.titleLabel.text = "\(self?.paramTitle ?? "") - \(self?.viewModel.list.count ?? 0)個の単語"
                }
            }
        }.onError { error in
            debugPrint("list set error: \(error)")
        }
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
            debugPrint("quiz")
        }
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertC.addAction(alertCard)
        alertC.addAction(alertQuiz)
        alertC.addAction(cancel)
        present(alertC, animated: true, completion: nil)
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
    }
    
}
