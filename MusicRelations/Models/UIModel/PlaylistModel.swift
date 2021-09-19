//
//  PlaylistModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import UIKit

class PlaylistModel {
    var playlistName: String?
    var trackAmount: Int?
    var playlistImageUrl: String?
    
    init(resultPlaylist: PlaylistResult) {
        playlistName = resultPlaylist.title
        playlistImageUrl = resultPlaylist.ogImage
        trackAmount = resultPlaylist.trackCount
    }
    
    class func getPlaylists(from responseModel: PlaylistResponseModel) -> [PlaylistModel] {
        var playlists = [PlaylistModel]()
        if let result = responseModel.result {
            for playlist in result {
                let playlistToAdd = PlaylistModel(resultPlaylist: playlist)
                playlists.append(playlistToAdd)
            }
        }
        return playlists
    }
    
    func playlistSquareImageUrl(with size: Int) -> String? {
        guard var playlistImageUrlWithoutSize = self.playlistImageUrl, !playlistImageUrlWithoutSize.isEmpty else { return nil }
        playlistImageUrlWithoutSize.removeLast(2)
        return "https://\(playlistImageUrlWithoutSize)\(size)x\(size)"
    }
}
