//
//  ListAddViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import UIKit
import EMTNeumorphicView

class ListAddViewController: UIViewController {
    
    @IBOutlet weak var wordSaveButton: EMTNeumorphicButton!
    @IBOutlet weak var titleFieldView: UIView!
    @IBOutlet weak var meanFieldView: UIView!
    @IBOutlet weak var wordFieldView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var meanTextField: UITextField!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categorySelectButton: EMTNeumorphicButton!
    @IBOutlet weak var saveButton: EMTNeumorphicButton!
    @IBOutlet weak var tableView: UITableView!
    var coordinator : ListAddViewControllerFlow?
    var viewModel : ListAddViewModel = ListAddViewModel()
    var tag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

}

extension ListAddViewController {
    func initView() {
        configUI()
        buttonStyle()
        shadowView()
        tableView.delegate = self
        tableView.dataSource = self
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        wordSaveButton.addTarget(self, action: #selector(tappedWordSaveButton), for: .touchUpInside)
        self.title = "セット追加"
    }
    
    func configUI() {
        tableView.layer.cornerRadius = 10
        view.backgroundColor = UIColor.background
        tableView.backgroundColor = UIColor.background
        footerView.layer.backgroundColor = UIColor.background.cgColor
        titleTextField.layer.cornerRadius = titleTextField.frame.height / 2
        meanTextField.layer.cornerRadius = meanTextField.frame.height / 2
        wordTextField.layer.cornerRadius = wordTextField.frame.height / 2
        wordFieldView.layer.cornerRadius = wordFieldView.frame.height / 2
        meanFieldView.layer.cornerRadius = meanFieldView.frame.height / 2
        titleFieldView.layer.cornerRadius = titleFieldView.frame.height / 2
    }
    
    func buttonStyle() {
        saveButton.neumorphicLayer?.elementBackgroundColor = UIColor.background.cgColor
        saveButton.neumorphicLayer?.cornerRadius = saveButton.frame.height / 2
        saveButton.neumorphicLayer?.depthType = .convex
        saveButton.neumorphicLayer?.elementDepth = 15
        saveButton.neumorphicLayer?.lightShadowOpacity = 10
        saveButton.layer.masksToBounds = false
        saveButton.layer.borderWidth = 0.0
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowRadius = 2
        saveButton.layer.shadowOpacity = 0.2
        saveButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        
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
        
        categorySelectButton.neumorphicLayer?.elementBackgroundColor = UIColor.background.cgColor
        categorySelectButton.neumorphicLayer?.depthType = .convex
        categorySelectButton.neumorphicLayer?.elementDepth = 0
        categorySelectButton.neumorphicLayer?.lightShadowOpacity = 0
        categorySelectButton.neumorphicLayer?.darkShadowOpacity = 0
        categorySelectButton.neumorphicLayer?.elementColor = UIColor.background.cgColor
        categorySelectButton.neumorphicLayer?.edged = false

    }
    
    func shadowView() {
        shadowSetting(textView: titleFieldView)
        shadowSetting(textView: wordFieldView)
        shadowSetting(textView: meanFieldView)
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

extension ListAddViewController {
    @objc func tappedSaveButton() {
        if (tag == 0 && titleTextField.text == "") || (tag == 1 && titleTextField.text == "") {
            let alertC = UIAlertController(title: "", message: GOGAKUConst.goGakuSetTitleErrorAlertMessage, preferredStyle: .alert)
            let alertA = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertC.addAction(alertA)
            present(alertC, animated: true, completion: nil)
        } else {
            debugPrint("add")
        }
    }
    
    @objc func tappedWordSaveButton() {
        if (wordTextField.text == "" && meanTextField.text == "") || (wordTextField.text == "") || (meanTextField.text == "") {
            let alertC = UIAlertController(title: "", message: GOGAKUConst.goGakuSetWordErrorAlertMessage, preferredStyle: .alert)
            let alertA = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertC.addAction(alertA)
            present(alertC, animated: true, completion: nil)
        } else {
            tag = 1
            viewModel.dummyTable.append(dummyTableData(word: wordTextField.text ?? "", mean: meanTextField.text ?? ""))
            tableView.reloadData()
        }
    }
}

extension ListAddViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dummyTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListAddTableViewCell else { fatalError() }
        cell.wordLabel.text = viewModel.dummyTable[indexPath.row].word
        cell.meanLabel.text = viewModel.dummyTable[indexPath.row].mean
        cell.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
