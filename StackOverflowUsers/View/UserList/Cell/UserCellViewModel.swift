//
//  UserCellViewModel.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

protocol UserCellViewModelDelegate: AnyObject {
    func followUnfollowUser(_ user: StackOverflowUser)
    func blockUnblockUser(_ user: StackOverflowUser)
}

@objc protocol UserCellViewModelType {
    var userName: String { get }
    var userAvatar: String? { get }
    var userReputation: String { get }
    var followButtonTitle: String { get }
    var blockButtonTitle: String { get }
    var isFollowing: Bool { get }
    var isBlocking: Bool { get }

    func didTouchFollowUnfollowButton()
    func didTouchBlockButton()
}

final class UserCellViewModel: UserCellViewModelType {
    private let user: StackOverflowUser

    weak var delegate: UserCellViewModelDelegate?
    let userName: String
    let userAvatar: String?
    let userReputation: String
    let followButtonTitle: String
    let blockButtonTitle: String
    var isFollowing: Bool
    var isBlocking: Bool

    init(user: StackOverflowUser) {
        self.user = user
        userName = user.name
        userAvatar = user.profileImage
        userReputation = NSLocalizedString("reputation_prefix", comment: "") + String(user.reputation)
        followButtonTitle = user.status == .followed
            ? NSLocalizedString("following_button_title", comment: "")
            : NSLocalizedString("follow_button_title", comment: "")
        blockButtonTitle = user.status == .blocked
            ? NSLocalizedString("blocked_button_title", comment: "")
            : NSLocalizedString("block_button_title", comment: "")

        isFollowing = user.status == .followed
        isBlocking = user.status == .blocked
    }

    @objc func didTouchFollowUnfollowButton() {
        delegate?.followUnfollowUser(user)
    }

    @objc func didTouchBlockButton() {
        delegate?.blockUnblockUser(user)
    }
}
