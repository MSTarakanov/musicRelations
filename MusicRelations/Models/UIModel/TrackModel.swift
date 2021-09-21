//
//  TrackModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 20.09.2021.
//

import Foundation

struct TrackModel {
    let trackName: String
    
    init?(trackElement: TrackElement) {
        guard let trackName = trackElement.track?.title
        else {
            return nil
        }
        self.trackName = trackName
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
