//
//  YandexApiCaller.swift
//  DataManager
//
//  Created by Максим Тараканов on 10.09.2021.
//

import Foundation

class YandexApiCaller {
    class func isUser(with id: String) -> Bool {
        if let url = URL(string: Constants.Network.usersUrl + id) {
            let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print(error)
                } else {
                    if let data = data {
                        do {
                            let user = try JSONDecoder().decode(UserModel.self, from: data)
                            print(user)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
        return true
    }
}
