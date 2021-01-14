//
//  HomeViewController.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/10.
//

import UIKit
import EMTNeumorphicView

class HomeViewController: UIViewController {

    var coordinator : HomeViewControllerFlow?
    @IBOutlet weak var studySetListButton: EMTNeumorphicButton!
    @IBOutlet weak var randomStartsubView: GradientView!
    @IBOutlet weak var randomStartView: GradientView!
    @IBOutlet weak var startButtonView: EMTNeumorphicView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

}

// init
extension HomeViewController {
    func initView() {
        configUI()
        studySetListButton.addTarget(self, action: #selector(tappedStudySetListButton), for: .touchUpInside)
        
                                                                        
    }
}

//configUI
extension HomeViewController {
    func configUI() {
        randomStartViewLayer()
        studySetListButtonLayer()
        startButtonLayer()
        navigationBarSetting()
        view.backgroundColor = UIColor.background
    }
    
    func navigationBarSetting() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.title = "\(Calendar.current.shortFormat(Date()))"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.labelNavy]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "D-day", style: .done, target: self, action: #selector(tappedNavigationBarButton(_:)))
    }

    func randomStartViewLayer() {
        randomStartView.layer.cornerRadius = randomStartView.frame.height / 2
        randomStartsubView.layer.cornerRadius = randomStartsubView.frame.height / 2
    }
    func studySetListButtonLayer() {
        studySetListButton.neumorphicLayer?.elementBackgroundColor = UIColor.background.cgColor
        studySetListButton.neumorphicLayer?.cornerRadius = studySetListButton.frame.height / 2
        studySetListButton.neumorphicLayer?.depthType = .convex
        studySetListButton.neumorphicLayer?.elementDepth = 15
        studySetListButton.neumorphicLayer?.lightShadowOpacity = 10
        studySetListButton.neumorphicLayer?.darkShadowOpacity = 5
        studySetListButton.neumorphicLayer?.elementColor = UIColor.background.cgColor
        studySetListButton.neumorphicLayer?.edged = true
    }
    func startButtonLayer() {
        startButtonView.neumorphicLayer?.cornerRadius = startButtonView.frame.height / 2
        startButtonView.neumorphicLayer?.depthType = .convex
        startButtonView.neumorphicLayer?.elementDepth = 30
        startButtonView.neumorphicLayer?.lightShadowOpacity = 10
        startButtonView.neumorphicLayer?.edged = true
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.startButtonStartLayer.cgColor, UIColor.startButtonEndLayer.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.startButtonView.frame.size.width, height: self.startButtonView.frame.size.height)
        gradient.cornerRadius = gradient.frame.height / 2
        self.startButtonView.layer.insertSublayer(gradient, at: 0)
    }
}

extension HomeViewController {
    @objc func tappedStudySetListButton() {
        coordinator?.coordinateToListSetVC()
    }
    @objc func tappedNavigationBarButton(_ sender: UIBarButtonItem) {
        
    }
}
