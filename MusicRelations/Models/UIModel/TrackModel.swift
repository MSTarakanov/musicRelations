//
//  TrackModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 20.09.2021.
//

import Foundation

struct TrackModel {
    let trackName: String
    let clearImageUrl: String
    let artists: [String]
    
    init?(trackElement: TrackElement) {
        guard let trackName = trackElement.track?.title,
              let clearImageUrl = trackElement.track?.ogImage, !clearImageUrl.isEmpty,
              let artists = trackElement.track?.artists
        else {
            return nil
        }
        self.trackName = trackName
        self.clearImageUrl = clearImageUrl.trimmingCharacters(in: CharacterSet(charactersIn: "%"))
        self.artists = artists.compactMap({ artist in
            artist.name
        })
    }
    
    var imageUrlWithSize100: String {
        "https://" + clearImageUrl + "100x100"
    }
    
    static func getTracks(from playlistModel: PlaylistModel, completion: @escaping ([TrackModel]) -> Void) {
        YandexApiCaller.getTracks(from: playlistModel) { trackResponseModel in
            let tracks = trackResponseModel.result?.tracks?.compactMap({TrackModel(trackElement: $0)})
            if let tracksFromApi = tracks {
                completion(tracksFromApi)
            }
        }
    }    
}
