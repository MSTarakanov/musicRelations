//
//  TracksResponseModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 20.09.2021.
//

import Foundation

// MARK: - TracksResponseModel
struct TracksResponseModel: Codable {
    let invocationInfo: InvocationInfo?
    let result: TracksResult?
}

// MARK: - Result
struct TracksResult: Codable {
    let owner: Owner?
    let playlistUUID: String?
    let available: Bool?
    let uid, kind: Int?
    let title: String?
    let revision, snapshot, trackCount: Int?
    let visibility: String?
    let collective, isBanner, isPremiere: Bool?
    let durationMS: Int?
    let cover: ResultCover?
    let ogImage: String?
    let tracks: [TrackElement]?
    let likesCount: Int?
    let lastOwnerPlaylists: [LastOwnerPlaylist]?
    let pager: Pager?

    enum CodingKeys: String, CodingKey {
        case owner
        case playlistUUID = "playlistUuid"
        case available, uid, kind, title, revision, snapshot, trackCount, visibility, collective, isBanner, isPremiere
        case durationMS = "durationMs"
        case cover, ogImage, tracks, likesCount, lastOwnerPlaylists, pager
    }
}

// MARK: - ResultCover
struct ResultCover: Codable {
    let type, dir, version, uri: String?
    let custom: Bool?
}

// MARK: - LastOwnerPlaylist
struct LastOwnerPlaylist: Codable {
    let owner: Owner?
    let playlistUUID: String?
    let available: Bool?
    let uid, kind: Int?
    let title: String?
    let revision, snapshot, trackCount: Int?
    let visibility: String?
    let collective, isBanner, isPremiere: Bool?
    let durationMS: Int?
    let cover: LastOwnerPlaylistCover?
    let ogImage: String?

    enum CodingKeys: String, CodingKey {
        case owner
        case playlistUUID = "playlistUuid"
        case available, uid, kind, title, revision, snapshot, trackCount, visibility, collective, isBanner, isPremiere
        case durationMS = "durationMs"
        case cover, ogImage
    }
}

// MARK: - LastOwnerPlaylistCover
struct LastOwnerPlaylistCover: Codable {
    let type: String?
    let itemsURI: [String]?
    let custom: Bool?
    let error: String?

    enum CodingKeys: String, CodingKey {
        case type
        case itemsURI = "itemsUri"
        case custom, error
    }
}

// MARK: - Pager
struct Pager: Codable {
    let total, page, perPage: Int?
}

// MARK: - TrackElement
struct TrackElement: Codable {
    let id: Int?
    let track: SubstitutedClass?
    let originalIndex: Int?
    let recent: Bool?
}

// MARK: - SubstitutedClass
class SubstitutedClass: Codable {
    let id, realID, title: String?
    let major: Major?
    let available, availableForPremiumUsers, availableFullWithoutPermission: Bool?
    let durationMS: Int?
    let storageDir: String?
    let fileSize: Int?
    let normalization: Normalization?
    let r128: R128?
    let previewDurationMS: Int?
    let artists: [Artist]?
    let albums: [Album]?
    let coverURI, ogImage: String?
    let lyricsAvailable: Bool?
    let type: String?
    let rememberPosition: Bool?
    let trackSharingFlag: String?
    let substituted: SubstitutedClass?
    let version, error: String?

    enum CodingKeys: String, CodingKey {
        case id
        case realID = "realId"
        case title, major, available, availableForPremiumUsers, availableFullWithoutPermission
        case durationMS = "durationMs"
        case storageDir, fileSize, normalization, r128
        case previewDurationMS = "previewDurationMs"
        case artists, albums
        case coverURI = "coverUri"
        case ogImage, lyricsAvailable, type, rememberPosition, trackSharingFlag, substituted, version, error
    }

    init(id: String?, realID: String?, title: String?, major: Major?, available: Bool?, availableForPremiumUsers: Bool?, availableFullWithoutPermission: Bool?, durationMS: Int?, storageDir: String?, fileSize: Int?, normalization: Normalization?, r128: R128?, previewDurationMS: Int?, artists: [Artist]?, albums: [Album]?, coverURI: String?, ogImage: String?, lyricsAvailable: Bool?, type: String?, rememberPosition: Bool?, trackSharingFlag: String?, substituted: SubstitutedClass?, version: String?, error: String?) {
        self.id = id
        self.realID = realID
        self.title = title
        self.major = major
        self.available = available
        self.availableForPremiumUsers = availableForPremiumUsers
        self.availableFullWithoutPermission = availableFullWithoutPermission
        self.durationMS = durationMS
        self.storageDir = storageDir
        self.fileSize = fileSize
        self.normalization = normalization
        self.r128 = r128
        self.previewDurationMS = previewDurationMS
        self.artists = artists
        self.albums = albums
        self.coverURI = coverURI
        self.ogImage = ogImage
        self.lyricsAvailable = lyricsAvailable
        self.type = type
        self.rememberPosition = rememberPosition
        self.trackSharingFlag = trackSharingFlag
        self.substituted = substituted
        self.version = version
        self.error = error
    }
}

// MARK: - Album
struct Album: Codable {
    let id: Int?
    let title, metaType: String?
    let year: Int?
    let coverURI, ogImage, genre: String?
    let trackCount, likesCount: Int?
    let recent, veryImportant: Bool?
    let artists: [Artist]?
    let labels: [Major]?
    let available, availableForPremiumUsers, availableForMobile, availablePartially: Bool?
    let trackPosition: TrackPosition?
    let type: String?
    let bests: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, title, metaType, year
        case coverURI = "coverUri"
        case ogImage, genre, trackCount, likesCount, recent, veryImportant, artists, labels, available, availableForPremiumUsers, availableForMobile, availablePartially, trackPosition, type, bests
    }
}

// MARK: - Artist
struct Artist: Codable {
    let id: Int?
    let name: String?
    let various, composer: Bool?
    let cover: ArtistCover?
}

// MARK: - ArtistCover
struct ArtistCover: Codable {
    let type, coverPrefix, uri: String?

    enum CodingKeys: String, CodingKey {
        case type
        case coverPrefix = "prefix"
        case uri
    }
}

// MARK: - Major
struct Major: Codable {
    let id: Int?
    let name: String?
}

// MARK: - TrackPosition
struct TrackPosition: Codable {
    let volume, index: Int?
}

// MARK: - Normalization
struct Normalization: Codable {
    let gain: Double?
    let peak: Int?
}

// MARK: - R128
struct R128: Codable {
    let i, tp: Double?
}
