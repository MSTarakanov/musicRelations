//
//  UserTableViewCell.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 09.09.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpCell(for user: String) {
        self.textLabel?.text = user
        self.accessoryType = .disclosureIndicator
        let backView = UIView()
        backView.backgroundColor = Constants.UI.yandexColor
        self.selectedBackgroundView = backView
    }
}
