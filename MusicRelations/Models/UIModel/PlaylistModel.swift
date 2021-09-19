//
//  PlaylistModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistModel {
    var playlistName: String
    var trackAmount: Int
    var playlistImageUrl: String
    
    init?(resultPlaylist: PlaylistResult) {
        guard let playlistName = resultPlaylist.title,
              let playlistImageUrl = resultPlaylist.ogImage,
              let trackAmount = resultPlaylist.trackCount
        else {
            return nil
        }
        self.playlistName = playlistName
        self.playlistImageUrl = playlistImageUrl
        self.trackAmount = trackAmount
    }
    
    class func getPlaylists(from responseModel: PlaylistResponseModel) -> [PlaylistModel] {
        var playlists = [PlaylistModel]()
        if let result = responseModel.result {
            for playlist in result {
                if let playlistToAdd = PlaylistModel(resultPlaylist: playlist) {
                    playlists.append(playlistToAdd)
                }
            }
        }
        return playlists
    }
    
    func playlistSquareImageUrl(with size: Int) -> String? {
        if playlistImageUrl.isEmpty {
            return nil
        }
        var playlistImageUrlWithoutSize = playlistImageUrl
        playlistImageUrlWithoutSize.removeLast(2)
        return "https://\(playlistImageUrlWithoutSize)\(size)x\(size)"
    }
}
