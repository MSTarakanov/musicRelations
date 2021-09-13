//
//  UserModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 10.09.2021.
//

import Foundation

// MARK: - UserModel
struct UserResponseModel: Codable {
    let invocationInfo: InvocationInfo?
    let result: Result?
}

// MARK: - InvocationInfo
struct InvocationInfo: Codable {
    let hostname, reqID, execDurationMillis: String?

    enum CodingKeys: String, CodingKey {
        case hostname
        case reqID = "req-id"
        case execDurationMillis = "exec-duration-millis"
    }
}

// MARK: - Result
struct Result: Codable {
    let uid: Int?
    let login, name, displayName, fullName: String?
    let verified: Bool?
    let statistics: Statistics?
}

// MARK: - Statistics
struct Statistics: Codable {
    let likedUsers, likedByUsers: Int?
    let hasTracks: Bool?
    let likedArtists, likedAlbums, ugcTracks: Int?
}
