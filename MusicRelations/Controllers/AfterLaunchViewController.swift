//
//  AfterLaunchViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 12.09.2021.
//

import UIKit

// class is created to animate logo before showing homescreen
class AfterLaunchViewController: UIViewController {

    @IBOutlet weak var heightLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.animateLogo()
    }
    
    private func animateLogo() {
        heightLogoConstraint = heightLogoConstraint.setMultiplier(multiplier: 2)
        
        UIView.animate(withDuration: 1.3, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.logoImage.alpha = 0
        }) { done in
            if done {
                // setup mainNavVC
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC")
                let mainNavController = UINavigationController(rootViewController: homeViewController)
                mainNavController.modalTransitionStyle = .crossDissolve
                mainNavController.modalPresentationStyle = .fullScreen
                mainNavController.navigationBar.isTranslucent = false
                mainNavController.navigationBar.tintColor = .white
                // setup UINavigationBarAppearance
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = Constants.UI.yandexColor
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
                mainNavController.navigationBar.standardAppearance = appearance
                mainNavController.navigationBar.scrollEdgeAppearance = mainNavController.navigationBar.standardAppearance

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.present(mainNavController, animated: true, completion: nil)
                }
            }
        }
    }
}


