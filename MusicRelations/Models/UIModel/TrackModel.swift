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
    let genre: String?
    
    init?(trackElement: TrackElement) {
        guard let trackName = trackElement.track?.title,
              let clearImageUrl = trackElement.track?.ogImage,
              let artists = trackElement.track?.artists,
              let genre = trackElement.track?.albums?.first?.genre
        else {
            return nil
        }
        self.trackName = trackName
        self.clearImageUrl = clearImageUrl.trimmingCharacters(in: CharacterSet(charactersIn: "%"))
        self.artists = artists.compactMap({ artist in
            artist.name
        })
        self.genre = genre
    }
    
    enum playlistImageSize: Int {
        case small = 100
        case average = 200
        case max = 1000
    }
    
    func imageUrl(with size: playlistImageSize) -> String {
        "https://" + self.clearImageUrl + "\(size)x\(size)"
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
