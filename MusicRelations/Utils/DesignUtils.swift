//
//  DesignUtils.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 21.09.2021.
//

import UIKit

class DesignUtils {
    private init () {}
    
    static func styleViewCell(view: UIView) {
        view.layer.borderWidth = 3
        view.layer.borderColor = Constants.UI.yandexColor.cgColor
        view.layer.cornerRadius = 20
        //view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
    }
}
