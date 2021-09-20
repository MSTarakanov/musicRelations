//
//  PlaylistModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

struct PlaylistModel {
    let playlistName: String
    let trackAmount: Int
    let playlistImageUrl: String
    let kind: Int
    
    init?(resultPlaylist: PlaylistResult) {
        guard let playlistName = resultPlaylist.title,
              let playlistImageUrl = resultPlaylist.ogImage,
              let trackAmount = resultPlaylist.trackCount,
              let kind = resultPlaylist.kind
        else {
            return nil
        }
        self.playlistName = playlistName
        self.playlistImageUrl = playlistImageUrl
        self.trackAmount = trackAmount
        self.kind = kind
    }
    
    static func getPlaylists(from responseModel: PlaylistsResponseModel) -> [PlaylistModel] {
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
