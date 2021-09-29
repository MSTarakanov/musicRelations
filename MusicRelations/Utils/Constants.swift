//
//  Constants.swift
//  DataManager
//
//  Created by Максим Тараканов on 10.09.2021.
//

import UIKit

struct Constants {
    private init () {}
    struct Network {
        private init () {}
        static let baseUrl = "https://api.music.yandex.net/"
        static let usersUrl = baseUrl + "users/"
        static let tracksUrl = baseUrl + "tracks/"
        
        static func playlistUrl(with playlist: PlaylistModel) -> String {
            return usersUrl + playlist.ownerLogin + "/playlists/" + String(playlist.kind)
        }
        
        static func likedPlaylistUrl(by user: UserModel) -> String {
            return usersUrl + user.userId + "/likes/tracks"
        }
        
    }
    struct  UI {
        private init () {}
        static let yandexColor = #colorLiteral(red: 0.9698011279, green: 0.2449444234, blue: 0.1140630171, alpha: 1)
    }
}
