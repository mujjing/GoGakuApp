//
//  ListSetUpdateViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import UIKit

class ListSetUpdateViewController: UIViewController {

    @IBOutlet weak var saveButtonSubView: GradientView!
    @IBOutlet weak var saveButtonView: GradientView!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var titleFieldView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var selectImage: UITextField!
    let imagePickerView: UIPickerView = UIPickerView()
    var coordinator : ListSetUpdateViewControllerFlow?
    var viewModel: ListSetUpdateViewModel = ListSetUpdateViewModel()
    var paramTitle = ""
    var paramImage = ""
    var paramId : Int?
    var tag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

extension ListSetUpdateViewController {
    func initView() {
        shadowView()
        viewSetting()
        saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        imageName.text = ""
        pickerViewSetting()
        self.title = "学習リスト編集"
        titleTextField.text = paramTitle
        categoryImage.image = UIImage(named: paramImage)
        view.backgroundColor = UIColor.background
    }
    
    func viewSetting() {
        titleTextField.layer.cornerRadius = titleTextField.frame.height / 2
        titleFieldView.layer.cornerRadius = titleFieldView.frame.height / 2
        
        saveButton.layer.masksToBounds = false
        saveButton.layer.borderWidth = 0.0
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowRadius = 2
        saveButton.layer.shadowOpacity = 0.2
        saveButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        saveButtonView.layer.cornerRadius = saveButtonView.frame.height / 2
        saveButtonSubView.layer.cornerRadius = saveButtonSubView.frame.height / 2
    }
    func pickerViewSetting() {
        let toolBar = createToolBar()
        imagePickerView.delegate = self
        imagePickerView.dataSource = self
        self.selectImage.tintColor = .clear
        selectImage.inputView = imagePickerView
        selectImage.inputAccessoryView = toolBar
    }
    
    private func createToolBar(isDatePicker: Bool = false) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: GOGAKUConst.goGakuToolBarDone, style: .plain, target: self, action: #selector(dismissKeyBoard))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    func shadowView() {
        shadowSetting(textView: titleFieldView)
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
//MARK: Action
extension ListSetUpdateViewController {
    @objc func tappedSaveButton() {
        if (imageName.text == "" && titleTextField.text == "") || (titleTextField.text == "") {
            let alertC = UIAlertController(title: "", message: GOGAKUConst.goGakuSetTitleErrorAlertMessage, preferredStyle: .alert)
            let alertA = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertC.addAction(alertA)
            present(alertC, animated: true, completion: nil)
        } else if imageName.text == "" {
                let alertC = UIAlertController(title: "", message: GOGAKUConst.goGakuSetImageErrorAlertMessage, preferredStyle: .alert)
                let alertA = UIAlertAction(title: "確認", style: .default, handler: nil)
                alertC.addAction(alertA)
                present(alertC, animated: true, completion: nil)
        } else {
            debugPrint("pepepepe \(titleTextField.text ?? "") aaaa \(imageName.text ?? "")")
            jsonRequst(title: titleTextField.text ?? "", image: imageName.text ?? "")
        }
    }
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
}
//MARK: Model
extension ListSetUpdateViewController {

    func jsonRequst(title: String , image: String) {
        viewModel.listTitleUpdate(title: title, image: image)
                .subscribe(
                    onSuccess: { response in
                        let idDelivery = IDDelivery.shared
                        idDelivery.listID = self.paramId ?? 0
                        self.navigationController?.popViewController(animated: true)
                    },
                    onError: { error in
                        debugPrint(error)
                    }
                )
                .disposed(by: disposeBag)
    }
}

extension ListSetUpdateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.imageFileName.count
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return viewModel.imageFileName[row]
//    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryImage.image = UIImage(named: viewModel.imageFileName[row])
        imageName.text = viewModel.imageFileName[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: UIImage(named: viewModel.imageFileName[row]))
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        return imageView
    }
    
    
}
