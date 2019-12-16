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
    private var userNameLabel = UILabel()
    private var userReputationLabel = UILabel()
    private var userAvatar = UIImageView()
    private var labelsStackView: UIStackView = UIStackView(frame: .zero)
    private var buttonsStackView: UIStackView = UIStackView(frame: .zero)
    private let followButton: UIButton = ButtonFactory.makeRoundedButton()
    private let blockButton: UIButton = ButtonFactory.makeRoundedButton()

    // MARK: Public methods
    func configure(viewModel: UserCellViewModelType) {
        self.viewModel = viewModel
        clipsToBounds = true
        selectionStyle = .none
        userNameLabel.text = viewModel.userName
        userReputationLabel.text = viewModel.userReputation
        configureAvatarImage(urlString: viewModel.userAvatar)
        configureElements()
        configureLayout()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        userNameLabel.text = ""
        userReputationLabel.text = ""
        userAvatar.image = nil
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

    private func configureElements() {
        guard let viewModel = self.viewModel else { return }
        configureAvatar()
        configureLabels(viewModel: viewModel)
        configureButtons(viewModel: viewModel)
    }

    private func configureAvatar() {
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userAvatar.layer.cornerRadius = Sizing.avatar.width / 2
        userAvatar.clipsToBounds = true

        contentView.addSubview(userAvatar)
    }

    private func configureLabels(viewModel: UserCellViewModelType) {
        userNameLabel.font = FontPallete.title
        userNameLabel.textColor = ColorPalette.text
        userReputationLabel.font =  FontPallete.subtitle
        userReputationLabel.textColor = ColorPalette.text
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

            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.large),
            labelsStackView.leftAnchor.constraint(equalTo: userAvatar.rightAnchor, constant: Spacing.large),
            labelsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Spacing.large * -1),

            blockButton.heightAnchor.constraint(equalToConstant: Sizing.button.height),
            followButton.heightAnchor.constraint(equalToConstant: Sizing.button.height),

            buttonsStackView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: Spacing.large),
            buttonsStackView.leftAnchor.constraint(equalTo: labelsStackView.leftAnchor),
            buttonsStackView.rightAnchor.constraint(equalTo: labelsStackView.rightAnchor),

            contentView.bottomAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: Spacing.large)
        ])
    }
}
