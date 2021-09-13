//
//  File.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//


import Foundation

// MARK: - PlaylistResponse
struct PlaylistResponseModel: Codable {
    let invocationInfo: InvocationInfo?
    let result: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case invocationInfo
        case result = "result"
    }
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
    let collective: Bool?
    let created, modified: Date?
    let isBanner, isPremiere: Bool?
    let durationMS: Int?
    let cover: Cover?
    let ogImage: String?

    enum CodingKeys: String, CodingKey {
        case owner
        case playlistUUID = "playlistUuid"
        case available, uid, kind, title, revision, snapshot, trackCount, visibility, collective, created, modified, isBanner, isPremiere
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
