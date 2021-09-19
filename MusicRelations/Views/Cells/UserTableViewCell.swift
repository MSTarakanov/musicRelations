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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpCell(for user: UserModel) {
        self.textLabel?.text = user.username
        self.accessoryType = .disclosureIndicator
        // add selection backgroundView
        let selectedBackView = UIView()
        selectedBackView.backgroundColor = Constants.UI.yandexColor
        self.selectedBackgroundView = selectedBackView
    }
}
