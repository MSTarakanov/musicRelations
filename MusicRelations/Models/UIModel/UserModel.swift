//
//  UserModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import Foundation

struct UserModel: Codable, Hashable {
    let userId: String
    let username: String
    
    init?(userResponseResult: UserResult) {
        guard let userId = userResponseResult.login,
              let username = userResponseResult.name
        else {
            return nil
        }
        self.userId = userId
        self.username = username
    }
}
