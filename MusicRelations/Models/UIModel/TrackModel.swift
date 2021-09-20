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
}
