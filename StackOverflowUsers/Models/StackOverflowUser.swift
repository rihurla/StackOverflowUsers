//
//  StackOverflowUser.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public enum StackOverflowUserStatus: String, Codable {
    case blocked
    case followed
    case none
}

public struct StackOverflowUser: Codable, Equatable {
    let accountId: Int
    let name: String
    let profileImage: String?
    let reputation: Int
    var status: StackOverflowUserStatus {
        get {
           return StackOverflowUserStorage().retrieveUser(self)?.status ?? .none
        }
    }

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case name = "display_name"
        case profileImage = "profile_image"
        case reputation
    }
}
