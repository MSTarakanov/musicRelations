// This file was generated from JSON Schema using quicktype, do not modify it directly.

import Foundation

// MARK: - LikedTracksResponseModel
struct LikedTracksResponseModel: Codable {
    let invocationInfo: InvocationInfo?
    let result: LikedTracksResult?
}

// MARK: - Result
struct LikedTracksResult: Codable {
    let library: Library?
}

// MARK: - Library
struct Library: Codable {
    let uid, revision: Int?
    let tracks: [Track]?
}

// MARK: - Track
struct Track: Codable {
    let id, albumID: String?
    let timestamp: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "albumId"
        case timestamp
    }
}
