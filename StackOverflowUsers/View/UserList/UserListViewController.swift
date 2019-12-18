//
//  UserListViewController.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import UIKit

final class UserListViewController: UIViewController {

    // MARK: Private properties
    private var viewModel: UserListViewModelType
    private let tableView: UITableView

    // MARK: Lifecyle
    public init(viewModel: UserListViewModelType) {
        self.viewModel = viewModel
        tableView = UITableView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        configureFetchHandler()
        fetchUsers()
    }

    // MARK: Private
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = NSLocalizedString("user_list_title", comment: "")
        navigationController?.configureAppearance()
    }

    private func configureTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.register(ErrorCell.self, forCellReuseIdentifier: ErrorCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func configureFetchHandler() {
        viewModel.fetchHander = { [weak self] success in
            DispatchQueue.main.async {
                success ? self?.handleSuccess() : self?.handleError()
            }
        }
        viewModel.updateHander = { [weak self] indexPath in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    private func fetchUsers() {
        viewModel.fetchUserList()
    }

    private func handleSuccess() {
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = true
        tableView.reloadData()
    }

    private func handleError() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.allowsMultipleSelection = false
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension UserListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shouldDisplayError ? 1 : viewModel.userCount()
    }

    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.shouldDisplayError {
            let cellViewModel = ErrorCellViewModel(errorMessage: viewModel.errorMessage)
            cellViewModel.delegate = viewModel
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorCell.identifier, for: indexPath) as! ErrorCell
            cell.configure(viewModel: cellViewModel)
            return cell
        }

        let cellViewModel = UserCellViewModel(user: viewModel.stackOverflowUserFor(indexPath))
        cellViewModel.delegate = viewModel
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UserListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        refreshCell()
        guard viewModel.stackOverflowUserFor(indexPath).status == .blocked else { return }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        refreshCell()
    }

    private func refreshCell() {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
