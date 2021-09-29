// This file was generated from JSON Schema using quicktype, do not modify it directly.


import Foundation

// MARK: - TrackResponseModel
struct TrackResponseModel: Codable {
    let invocationInfo: TrackInvocationInfo?
    let result: [TrackResult]?
}

// MARK: - Result
struct TrackResult: Codable {
    let id, realID, title, contentWarning: String?
    let major: Major?
    let available, availableForPremiumUsers, availableFullWithoutPermission: Bool?
    let storageDir: String?
    let durationMS, fileSize: Int?
    let normalization: Normalization?
    let r128: R128?
    let previewDurationMS: Int?
    let artists: [Artist]?
    let albums: [Album]?
    let coverURI, ogImage: String?
    let lyricsAvailable: Bool?
    let type: String?
    let rememberPosition: Bool?
    let backgroundVideoURI: String?
    let trackSharingFlag: String?

    enum CodingKeys: String, CodingKey {
        case id
        case realID = "realId"
        case title, contentWarning, major, available, availableForPremiumUsers, availableFullWithoutPermission, storageDir
        case durationMS = "durationMs"
        case fileSize, normalization, r128
        case previewDurationMS = "previewDurationMs"
        case artists, albums
        case coverURI = "coverUri"
        case ogImage, lyricsAvailable, type, rememberPosition
        case backgroundVideoURI = "backgroundVideoUri"
        case trackSharingFlag
    }
}

struct TrackInvocationInfo: Codable {
    let reqID, hostname: String?
    let execDurationMillis: Int?

    enum CodingKeys: String, CodingKey {
        case reqID = "req-id"
        case hostname
        case execDurationMillis = "exec-duration-millis"
    }
}


// MARK: - Artist
struct TrackArtist: Codable {
    let id: Int?
    let name: String?
    let various, composer: Bool?
    let cover: TrackCover?
    let decomposed: [DecomposedElement]?
}

// MARK: - Cover
struct TrackCover: Codable {
    let type: TypeEnum?
    let uri, coverPrefix: String?

    enum CodingKeys: String, CodingKey {
        case type, uri
        case coverPrefix = "prefix"
    }
}

enum TypeEnum: String, Codable {
    case fromAlbumCover = "from-album-cover"
    case fromArtistPhotos = "from-artist-photos"
}

enum DecomposedElement: Codable {
    case decomposedClass(DecomposedClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(DecomposedClass.self) {
            self = .decomposedClass(x)
            return
        }
        throw DecodingError.typeMismatch(DecomposedElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DecomposedElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .decomposedClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - DecomposedClass
struct DecomposedClass: Codable {
    let id: Int?
    let name: String?
    let various, composer: Bool?
}

