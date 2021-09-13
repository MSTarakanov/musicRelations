//
//  UsersWithUserDefaults.swift
//  DataManager
//
//  Created by Максим Тараканов on 10.09.2021.
//

import Foundation

class PlistHandler {
    private init() {}
    
    private static let dataKey = "usersKey"
    
    class func getUsers() -> [UserModel] {
        var users = [UserModel]()
        if let data = UserDefaults.standard.object(forKey: self.dataKey) as? Data{
            if let decodedUsers = try? JSONDecoder().decode([UserModel].self, from: data) {
                users = decodedUsers
            }
        }
        return users
    }
    
    class func save(_ users: [UserModel]) {
        if let encodedUsers = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedUsers, forKey: self.dataKey)
        }
    }
    
    class func add(_ newUser: UserModel) {
        var usersIds = getUsers()
        usersIds.append(newUser)
        save(usersIds)
    }
}
