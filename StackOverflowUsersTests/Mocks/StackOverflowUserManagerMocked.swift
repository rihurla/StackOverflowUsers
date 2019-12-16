//
//  StackOverflowUserManagerMocked.swift
//  StackOverflowUsersTests
//
//  Created by Ricardo Hurla on 16/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation
@testable import StackOverflowUsers

final class StackOverflowUserManagerMocked: StackOverflowUserManagerType {
    func followUnfollowUser(_ user: StackOverflowUser) {}
    func blockUnblockUser(_ user: StackOverflowUser) {}
}
