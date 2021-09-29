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
                        if let userResult = user.result {
                            completion(UserModel(userResponseResult: userResult))
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    class func getPlaylists(by userId: String, completion: @escaping (PlaylistsResponseModel) -> Void) {
        guard let url = URL(string: Constants.Network.usersUrl + userId + "/playlists/list") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    let playlistResponse = try JSONDecoder().decode(PlaylistsResponseModel.self, from: data)
                    print(playlistResponse)
                    completion(playlistResponse)
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    class func getTracks(from playlist: PlaylistModel, completion: @escaping (TracksResponseModel) -> Void) {
        let urlString = Constants.Network.playlistUrl(with: playlist)
        guard let url = URL(string: urlString) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    let tracksResponse = try JSONDecoder().decode(TracksResponseModel.self, from: data)
                    print(tracksResponse)
                    completion(tracksResponse)
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
}

