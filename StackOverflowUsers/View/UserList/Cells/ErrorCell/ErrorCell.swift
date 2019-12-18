//
//  ErrorCell.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 18/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

public final class ErrorCell: UITableViewCell {

    // MARK: Public properties
    public static let identifier = "ErrorCell"

    // MARK: Private properties
    private var viewModel: ErrorCellViewModelType?
    private var errorTitleLabel = UILabel()
    private var errorMessageLabel = UILabel()
    private var retryButton = ButtonFactory.makeRoundedButton()

    // MARK: Public methods
    func configure(viewModel: ErrorCellViewModelType) {
        self.viewModel = viewModel
        clipsToBounds = true
        selectionStyle = .none
        configureElements(viewModel: viewModel)
        configureLayout()
    }

    // MARK: Private methods
    private func configureElements(viewModel: ErrorCellViewModelType) {
        errorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorTitleLabel.text = viewModel.errorTitle
        errorTitleLabel.font = FontPallete.title
        errorTitleLabel.textColor = ColorPalette.text
        errorTitleLabel.textAlignment = .center
        contentView.addSubview(errorTitleLabel)

        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.text = viewModel.errorMessage
        errorMessageLabel.font =  FontPallete.subtitle
        errorMessageLabel.textColor = ColorPalette.text
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        contentView.addSubview(errorMessageLabel)

        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.backgroundColor = .clear
        retryButton.setTitle(viewModel.retryButtonTitle, for: .normal)
        retryButton.setTitleColor(ColorPalette.greenActive, for: .normal)
        retryButton.setTitleColor(.white, for: .highlighted)
        retryButton.addTarget(viewModel, action: #selector(viewModel.didTapRetry), for: .touchUpInside)
        retryButton.layer.borderColor = ColorPalette.greenActive.cgColor
        contentView.addSubview(retryButton)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            errorTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.xlarge),
            errorTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Spacing.large),
            errorTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Spacing.large * -1),

            errorMessageLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: Spacing.small),
            errorMessageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Spacing.large),
            errorMessageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Spacing.large * -1),

            retryButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: Spacing.xlarge),
            retryButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Spacing.large),
            retryButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Spacing.large * -1),
            retryButton.heightAnchor.constraint(equalToConstant: Sizing.button.height),

            contentView.bottomAnchor.constraint(equalTo: retryButton.bottomAnchor, constant: Spacing.xlarge)
        ])
    }
}
