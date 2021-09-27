//
//  UserTableViewCell.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 09.09.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let id = "UserTableViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
        configureSelectedBackgroundView()
    }
    
    private func configureSelectedBackgroundView() {
        let selectedBackView = UIView()
        selectedBackView.backgroundColor = Constants.UI.yandexColor
        self.selectedBackgroundView = selectedBackView
    }
    
    func setUpCell(for user: UserModel) {
        self.textLabel?.text = user.username
    }
}
