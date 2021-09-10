//
//  UsersWithUserDefaults.swift
//  DataManager
//
//  Created by Максим Тараканов on 10.09.2021.
//

import Foundation

class PlistHandler {
    private init() {}
    
    private static let dataKey = "usersIdsKey"
    
    class func getUsersIds() -> [String] {
        var usersIds = [String]()
        if let data = UserDefaults.standard.stringArray(forKey: self.dataKey) {
            usersIds = data
        }
        return usersIds
    }
    
    class func save(_ usersId: [String]) {
        UserDefaults.standard.set(usersId, forKey: self.dataKey)
    }
    
    class func add(_ newUserId: String) {    // check if already have it
        var usersIds = getUsersIds()                // check is it a yandex id?
        usersIds.append(newUserId)
        save(usersIds)
    }
}
