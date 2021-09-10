//
//  YandexApiCaller.swift
//  DataManager
//
//  Created by Максим Тараканов on 10.09.2021.
//

import Foundation

public class YandexApiCaller {
    public class func isUser(with id: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: Constants.Network.usersUrl + id) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            } else {
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(UserModel.self, from: data)
                        print(user)
                        completion(true, user.result?.name)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
