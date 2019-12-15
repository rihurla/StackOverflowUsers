//
//  StackOverflowUserList.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public struct StackOverflowUserList: Codable, Equatable {
    let users: [StackOverflowUser]
    let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case users = "items"
        case hasMore = "has_more"
    }
}
