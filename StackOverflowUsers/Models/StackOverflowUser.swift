//
//  StackOverflowUser.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public struct StackOverflowUser: Codable, Equatable {
    let name: String
    let profileImage: String?
    let reputation: Int

    enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case profileImage = "profile_image"
        case reputation
    }
}
