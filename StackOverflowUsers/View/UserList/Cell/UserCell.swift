//
//  UserCell.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

public final class UserCell: UITableViewCell {

    // MARK: Public properties
    public static let identifier = "UserCell"

    // MARK: Private properties
    private var viewModel: UserCellViewModelType?
    private var collapsedConstraint: NSLayoutConstraint?
    private var expandedConstraint: NSLayoutConstraint?
    private var userNameLabel = UILabel()
    private var userReputationLabel = UILabel()
    private var userAvatar = UIImageView()
    private var badge = UIImageView()
    private var labelsStackView: UIStackView = UIStackView(frame: .zero)
    private var buttonsStackView: UIStackView = UIStackView(frame: .zero)
    private let followButton: UIButton = ButtonFactory.makeRoundedButton()
    private let blockButton: UIButton = ButtonFactory.makeRoundedButton()

    // MARK: Public methods
    func configure(viewModel: UserCellViewModelType) {
        self.viewModel = viewModel
        clipsToBounds = true
        selectionStyle = .none
        configureElements(viewModel: viewModel)
        configureLayout()
        configureExpandableCell()
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        toggleExpanded()
    }

    // MARK: Private methods
    private func configureAvatarImage(urlString: String?) {
        guard let imageUrlString = urlString, let url = URL(string: imageUrlString) else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    self?.userAvatar.image = UIImage(data: data)
                }
            } catch {
                return
            }
        }
    }

    private func configureElements(viewModel: UserCellViewModelType) {
        configureAvatarImage(urlString: viewModel.userAvatar)
        configureAvatar(viewModel: viewModel)
        configureBadge(viewModel: viewModel)
        configureLabels(viewModel: viewModel)
        configureButtons(viewModel: viewModel)
    }

    private func configureAvatar(viewModel: UserCellViewModelType) {
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userAvatar.layer.cornerRadius = Sizing.avatar.width / 2
        userAvatar.clipsToBounds = true
        userAvatar.alpha = viewModel.isBlocking ? 0.5 : 1.0

        contentView.addSubview(userAvatar)
    }

    private func configureBadge(viewModel: UserCellViewModelType) {
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.isHidden = !viewModel.isFollowing && !viewModel.isBlocking
        badge.image = viewModel.isFollowing
            ? ImageCollection.followBadgeIcon
            : ImageCollection.blockBadgeIcon

        contentView.addSubview(badge)
    }

    private func configureLabels(viewModel: UserCellViewModelType) {
        userNameLabel.text = viewModel.userName
        userNameLabel.font = FontPallete.title
        userNameLabel.textColor = ColorPalette.text
        userNameLabel.alpha = viewModel.isBlocking ? 0.5 : 1.0

        userReputationLabel.text = viewModel.userReputation
        userReputationLabel.font =  FontPallete.subtitle
        userReputationLabel.textColor = ColorPalette.text
        userReputationLabel.alpha = viewModel.isBlocking ? 0.5 : 1.0

        labelsStackView = StackViewFactory.makeLabelStackView(subViews: [userNameLabel, userReputationLabel])

        contentView.addSubview(labelsStackView)
    }

    private func configureButtons(viewModel: UserCellViewModelType) {
        let followBgColor: UIColor = viewModel.isFollowing ? ColorPalette.greenActive : .clear
        let followTitleColor: UIColor = viewModel.isFollowing ? .white : ColorPalette.greenActive
        followButton.backgroundColor = followBgColor
        followButton.setTitle(viewModel.followButtonTitle, for: .normal)
        followButton.setTitleColor(followTitleColor, for: .normal)
        followButton.addTarget(viewModel, action: #selector(viewModel.didTouchFollowUnfollowButton), for: .touchUpInside)
        followButton.layer.borderColor = ColorPalette.greenActive.cgColor

        let blockBgColor: UIColor = viewModel.isBlocking ? ColorPalette.redActive : .clear
        let blockTitleColor: UIColor = viewModel.isBlocking ? .white : ColorPalette.redActive
        blockButton.backgroundColor = blockBgColor
        blockButton.setTitle(viewModel.blockButtonTitle, for: .normal)
        blockButton.setTitleColor(blockTitleColor, for: .normal)
        blockButton.addTarget(viewModel, action: #selector(viewModel.didTouchBlockButton), for: .touchUpInside)
        blockButton.layer.borderColor = ColorPalette.redActive.cgColor

        buttonsStackView = StackViewFactory.makeButtonsStackView(subViews: [followButton, blockButton])

        contentView.addSubview(buttonsStackView)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            userAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.large),
            userAvatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Spacing.large),
            userAvatar.widthAnchor.constraint(equalToConstant: Sizing.avatar.width),
            userAvatar.heightAnchor.constraint(equalToConstant: Sizing.avatar.height),

            badge.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: -Spacing.large),
            badge.leftAnchor.constraint(equalTo: userAvatar.rightAnchor, constant: -Spacing.small),
            badge.widthAnchor.constraint(equalToConstant: Sizing.badge.width),
            badge.heightAnchor.constraint(equalToConstant: Sizing.badge.height),

            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.large),
            labelsStackView.leftAnchor.constraint(equalTo: userAvatar.rightAnchor, constant: Spacing.large),
            labelsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Spacing.large * -1),

            blockButton.heightAnchor.constraint(equalToConstant: Sizing.button.height),
            followButton.heightAnchor.constraint(equalToConstant: Sizing.button.height),

            buttonsStackView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: Spacing.large),
            buttonsStackView.leftAnchor.constraint(equalTo: labelsStackView.leftAnchor),
            buttonsStackView.rightAnchor.constraint(equalTo: labelsStackView.rightAnchor)
        ])
    }

    private func configureExpandableCell() {
        collapsedConstraint = contentView.bottomAnchor.constraint(equalTo: labelsStackView.bottomAnchor,
                                                                  constant: Spacing.large)
        expandedConstraint = contentView.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor,
                                                                 constant: Spacing.large)
        toggleExpanded()
    }

    private func toggleExpanded() {
        isSelected ? setExpanded() : setCollapsed()
    }

    private func setExpanded() {
        collapsedConstraint?.isActive = false
        expandedConstraint?.isActive = true
    }

    private func setCollapsed() {
        expandedConstraint?.isActive = false
        collapsedConstraint?.isActive = true
    }
}
