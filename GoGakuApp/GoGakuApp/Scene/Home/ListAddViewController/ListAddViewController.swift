//
//  ListAddViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import UIKit
import EMTNeumorphicView

class ListAddViewController: UIViewController {
    
    @IBOutlet weak var doneButton: EMTNeumorphicButton!
    @IBOutlet weak var wordSaveButton: EMTNeumorphicButton!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var meanFieldView: UIView!
    @IBOutlet weak var wordFieldView: UIView!
    @IBOutlet weak var meanTextField: UITextField!
    @IBOutlet weak var wordTextField: UITextField!
    var coordinator : ListAddViewControllerFlow?
    var viewModel : ListAddViewModel = ListAddViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ListAddViewController {
    func initView() {
        configUI()
        buttonStyle()
        tableView.delegate = self
        tableView.dataSource = self
        wordSaveButton.addTarget(self, action: #selector(tappedWordSaveButton), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(tappedDoneButton), for: .touchUpInside)
        self.title = "セット追加"
    }
    
    func configUI() {
        tableView.layer.cornerRadius = 10
        view.backgroundColor = UIColor.background
        tableView.backgroundColor = UIColor.background
        footerView.layer.backgroundColor = UIColor.background.cgColor
    }
    
    func buttonStyle() {
        meanTextField.layer.cornerRadius = meanTextField.frame.height / 2
        wordTextField.layer.cornerRadius = wordTextField.frame.height / 2
        wordFieldView.layer.cornerRadius = wordFieldView.frame.height / 2
        meanFieldView.layer.cornerRadius = meanFieldView.frame.height / 2
        wordSaveButton.neumorphicLayer?.elementBackgroundColor = UIColor.background.cgColor
        wordSaveButton.neumorphicLayer?.cornerRadius = wordSaveButton.frame.height / 2
        wordSaveButton.neumorphicLayer?.depthType = .convex
        wordSaveButton.neumorphicLayer?.elementDepth = 15
        wordSaveButton.neumorphicLayer?.lightShadowOpacity = 10
        wordSaveButton.layer.masksToBounds = false
        wordSaveButton.layer.borderWidth = 0.0
        wordSaveButton.layer.shadowColor = UIColor.black.cgColor
        wordSaveButton.layer.shadowRadius = 2
        wordSaveButton.layer.shadowOpacity = 0.2
        wordSaveButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        doneButton.neumorphicLayer?.elementBackgroundColor = UIColor.background.cgColor
        doneButton.neumorphicLayer?.cornerRadius = wordSaveButton.frame.height / 2
        doneButton.neumorphicLayer?.depthType = .convex
        doneButton.neumorphicLayer?.elementDepth = 15
        doneButton.neumorphicLayer?.lightShadowOpacity = 10
        doneButton.layer.masksToBounds = false
        doneButton.layer.borderWidth = 0.0
        doneButton.layer.shadowColor = UIColor.black.cgColor
        doneButton.layer.shadowRadius = 2
        doneButton.layer.shadowOpacity = 0.2
        doneButton.layer.shadowOffset = CGSize(width: 3, height: 3)

    }
    
    func shadowSetting(textView: UIView) {
        textView.layer.masksToBounds = false
        textView.layer.borderWidth = 0.0
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowRadius = 2
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
//MARK: model
extension ListAddViewController {
    func listAddWord(word: String, mean: String) {
        viewModel.listWordAdd(word: word, mean: mean)
                .subscribe(
                    onSuccess: { _ in
                        self.listGetWord()
                    },
                    onError: { error in
                        debugPrint(error)
                    }
                )
                .disposed(by: disposeBag)
    }
    func listGetWord() {
        let request = ListWordGetRequest()
        let _ = try? GoGakuHttpClient.default.send(request).onSuccess { [weak self] response in
            debugPrint("list get word success: \(response.status_code)")
            self?.viewModel.wordList = response.body.data ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.onError { error in
            debugPrint("list get word error: \(error)")
        }
    }
}

extension ListAddViewController {
    
    @objc func tappedWordSaveButton() {
        if (wordTextField.text == "" && meanTextField.text == "") || (wordTextField.text == "") || (meanTextField.text == "") {
            let alertC = UIAlertController(title: "", message: GOGAKUConst.goGakuSetWordErrorAlertMessage, preferredStyle: .alert)
            let alertA = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertC.addAction(alertA)
            present(alertC, animated: true, completion: nil)
        } else {
            listAddWord(word: wordTextField.text ?? "", mean: meanTextField.text ?? "")
        }
    }
    @objc func tappedDoneButton() {
        navigationController?.popViewControllers(viewsToPop: 2)
    }
}

extension ListAddViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListAddTableViewCell else { fatalError() }
        cell.wordLabel.text = viewModel.wordList[indexPath.row].word
        cell.meanLabel.text = viewModel.wordList[indexPath.row].mean
        cell.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
