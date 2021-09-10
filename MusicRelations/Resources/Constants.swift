//
//  Constants.swift
//  DataManager
//
//  Created by Максим Тараканов on 10.09.2021.
//

import UIKit

struct Constants {
    init () {}
    struct Network {
        init () {}
        static let baseUrl = "https://api.music.yandex.net/"
        static let usersUrl = baseUrl + "users/"
    }
    struct  UI {
        init () {}
        static let yandexColor = #colorLiteral(red: 0.9698011279, green: 0.2449444234, blue: 0.1140630171, alpha: 1)
    }
}
