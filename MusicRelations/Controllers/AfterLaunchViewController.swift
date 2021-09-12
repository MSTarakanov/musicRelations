//
//  AfterLaunchViewController.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 12.09.2021.
//

import UIKit

class AfterLaunchViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animateLogo()
    }
    
    private func animateLogo() {
        UIView.animate(withDuration: 1.5, animations: {
            heightConstraint = 
        }) { done in
            if done {
                
            }
        }
    }
}
