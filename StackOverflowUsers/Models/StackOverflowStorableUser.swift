//
//  StackOverflowStorableUser.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

public struct StackOverflowStorableUser: Codable {
    let user: StackOverflowUser
    let status: StackOverflowUserStatus
}
