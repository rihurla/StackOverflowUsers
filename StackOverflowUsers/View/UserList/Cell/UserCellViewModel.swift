//
//  UserCellViewModel.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol UserCellViewModelType {
    var userName: String { get }
    var userAvatar: String? { get }
    var userReputation: String { get }
}

final class UserCellViewModel: UserCellViewModelType {
    let userName: String
    let userAvatar: String?
    let userReputation: String

    init(user: StackOverflowUser) {
        self.userName = user.name
        self.userAvatar = user.profileImage
        self.userReputation = NSLocalizedString("reputation_prefix", comment: "") + String(user.reputation)
    }
}
