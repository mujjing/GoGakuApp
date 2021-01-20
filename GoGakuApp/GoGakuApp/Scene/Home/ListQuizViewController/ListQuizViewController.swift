//
//  ListQuizViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import UIKit

class ListQuizViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var judgeLabel: UILabel!
    @IBOutlet weak var checkButtonView: GradientView!
    @IBOutlet weak var checkButtonSubView: GradientView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var doneButtonView: GradientView!
    @IBOutlet weak var donButton: UIButton!
    @IBOutlet weak var donButtonSubView: GradientView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var inCorrectLabel: UILabel!
    var paramTitle: String?
    var correct : Int = 0
    var inCorrect : Int = 0
    var Index: Int = 0
    var viewModel: ListQuizViewModel = ListQuizViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listGetWord()
    }
}

//MARK: function
extension ListQuizViewController {
    
    func initView() {
        
        titleLabel.text = paramTitle
        configUI()
        correctLabel.text = "O:\(correct)"
        inCorrectLabel.text = "X:\(inCorrect)"
        checkButton.addTarget(self, action: #selector(tappedCheckButton), for: .touchUpInside)
        donButton.addTarget(self, action: #selector(tappedDonButton), for: .touchUpInside)
    }
    
    func configUI() {
        checkButtonView.layer.cornerRadius = checkButtonView.frame.height / 2
        checkButtonSubView.layer.cornerRadius = checkButtonSubView.frame.height / 2
        doneButtonView.layer.cornerRadius = doneButtonView.frame.height / 2
        donButtonSubView.layer.cornerRadius = donButtonSubView.frame.height / 2
//        quizTextFieldView.layer.cornerRadius = quizTextFieldView.frame.height / 2
//        quizTextFieldView.layer.masksToBounds = false
//        quizTextFieldView.layer.borderWidth = 0.0
//        quizTextFieldView.layer.shadowColor = UIColor.black.cgColor
//        quizTextFieldView.layer.shadowRadius = 2
//        quizTextFieldView.layer.shadowOpacity = 0.2
//        quizTextFieldView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: collectionView.frame.size.height - 30)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemAlpha = 1.0
        flowLayout.sideItemScale = 0.8
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = flowLayout

    }
}

extension ListQuizViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ListQuizCollectionViewCell else {fatalError()}
        let data = viewModel.list[indexPath.row]
        cell.wordLabel.text = data.word
        return cell
    }
    
    
}

//MARK: model
extension ListQuizViewController {
    func listGetWord() {
        let request = ListWordGetRequest()
        let _ = try? GoGakuHttpClient.default.send(request).onSuccess { [weak self] response in
            debugPrint("list get word success: \(response.status_code)")
            self?.viewModel.list = response.body.data ?? []
        }.onError { error in
            debugPrint("list get word error: \(error)")
        }
    }
}
//MARK: Action
extension ListQuizViewController {
    @objc func tappedCheckButton() {
//        let quizList = viewModel.list
//        for i in 0..<viewModel.list.count {
//            if quizTextField.text == quizList[i].mean {
//                correct += 1
//                judgeLabel.text = "O"
//                judgeLabel.textColor = UIColor.green
//                if (viewModel.list.count != 0) && (i == viewModel.list.count) {
//                    let alertC = UIAlertController(title:"", message: GOGAKUConst.goGakuQuizDone, preferredStyle: .alert)
//                    let alertA = UIAlertAction(title: "確認", style: .default, handler: nil)
//                    alertC.addAction(alertA)
//                    present(alertC, animated: true, completion: nil)
//                }
//            } else {
//                inCorrect += 1
//                judgeLabel.text = "X"
//                judgeLabel.textColor = UIColor.red
//                if (viewModel.list.count != 0) && (i == viewModel.list.count) {
//                    let alertC = UIAlertController(title:"", message: GOGAKUConst.goGakuQuizDone, preferredStyle: .alert)
//                    let alertA = UIAlertAction(title: "確認", style: .default, handler: nil)
//                    alertC.addAction(alertA)
//                    present(alertC, animated: true, completion: nil)
//                }
//            }
//        }
    }
    @objc func tappedDonButton() {
        dismiss(animated: true, completion: nil)
    }
}
