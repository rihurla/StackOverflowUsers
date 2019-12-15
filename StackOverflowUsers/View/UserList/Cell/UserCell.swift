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

    // MARK: Public methods
    func configure(viewModel: UserCellViewModelType) {
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
        userAvatar.layer.cornerRadius = Sizing.avatar.width / 2
        userAvatar.clipsToBounds = true
        userNameLabel.font = FontPallete.title
        userNameLabel.textColor = ColorPalette.title
        userReputationLabel.font =  FontPallete.subtitle
        userReputationLabel.textColor = ColorPalette.subtitle

        contentView.addSubview(userAvatar)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userReputationLabel)

        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userReputationLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            userAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userAvatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Spacing.large),
            userAvatar.widthAnchor.constraint(equalToConstant: Sizing.avatar.width),
            userAvatar.heightAnchor.constraint(equalToConstant: Sizing.avatar.height),

            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.large),
            userNameLabel.leftAnchor.constraint(equalTo: userAvatar.rightAnchor, constant: Spacing.large),
            userNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Spacing.large * -1),

            userReputationLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: Spacing.micro),
            userReputationLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor),
            userReputationLabel.rightAnchor.constraint(equalTo: userNameLabel.rightAnchor),

            contentView.bottomAnchor.constraint(equalTo: userReputationLabel.bottomAnchor, constant: Spacing.large)
        ])
    }
}
