//
//  YandexApiCaller.swift
//  DataManager
//
//  Created by Максим Тараканов on 10.09.2021.
//

import Foundation

class YandexApiCaller {
    class func getUser(with id: String, completion: @escaping (UserModel?) -> Void) {
        guard let url = URL(string: Constants.Network.usersUrl + id) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
            } else {
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(UserResponseModel.self, from: data)
                        print(user)
                        completion(UserModel(userResponseModel: user))
                    } catch {
                        print(error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    class func getPlaylists(by userId: String, completion: @escaping (PlaylistResponseModel) -> Void) {
        guard let url = URL(string: Constants.Network.usersUrl + userId + "/playlists/list") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    let playlistResponse = try JSONDecoder().decode(PlaylistResponseModel.self, from: data)
                    print(playlistResponse)
                    completion(playlistResponse)
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
}
