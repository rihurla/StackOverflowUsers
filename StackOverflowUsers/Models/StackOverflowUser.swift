//
//  StackOverflowUser.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public struct StackOverflowUser: Decodable, Equatable {
    let name: String
    let reputation: String
}
