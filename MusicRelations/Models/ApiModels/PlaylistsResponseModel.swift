//
//  File.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlistResponseModel = try? newJSONDecoder().decode(PlaylistResponseModel.self, from: jsonData)

import Foundation

// MARK: - PlaylistResponseModel
struct PlaylistsResponseModel: Codable {
    let invocationInfo: InvocationInfo?
    let result: [PlaylistResult]?
}

// MARK: - Result
struct PlaylistResult: Codable {
    let owner: Owner?
    let playlistUUID: String?
    let available: Bool?
    let uid, kind: Int?
    let title: String?
    let revision, snapshot, trackCount: Int?
    let visibility: String?
    let collective, isBanner, isPremiere: Bool?
    let durationMS: Int?
    let cover: Cover?
    let ogImage: String?

    enum CodingKeys: String, CodingKey {
        case owner
        case playlistUUID = "playlistUuid"
        case available, uid, kind, title, revision, snapshot, trackCount, visibility, collective, isBanner, isPremiere
        case durationMS = "durationMs"
        case cover, ogImage
    }
}

// MARK: - Cover
struct Cover: Codable {
    let type: String?
    let itemsURI: [String]?
    let custom: Bool?

    enum CodingKeys: String, CodingKey {
        case type
        case itemsURI = "itemsUri"
        case custom
    }
}

// MARK: - Owner
struct Owner: Codable {
    let uid: Int?
    let login, name, sex: String?
    let verified: Bool?
}
