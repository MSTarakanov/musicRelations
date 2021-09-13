//
//  UserModel.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 13.09.2021.
//

import Foundation

struct UserModel: Codable {
    var userId: String?
    var username:String?
    
    init(userResponseModel: UserResponseModel) {
        userId = userResponseModel.result?.login
        username = userResponseModel.result?.name
    }
}
