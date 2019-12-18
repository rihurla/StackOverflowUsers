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
    private var refreshControl: UIRefreshControl
    private let tableView: UITableView

    // MARK: Lifecyle
    public init(viewModel: UserListViewModelType) {
        self.viewModel = viewModel
        tableView = UITableView()
        refreshControl = UIRefreshControl()
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
        tableView.allowsMultipleSelection = true
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(fetchUsers), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("refresh_component_title",
                                                                                      comment: ""))
        tableView.refreshControl = refreshControl
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func configureFetchHandler() {
        viewModel.fetchHander = { [weak self] error in
            DispatchQueue.main.async {
                if let errorMsg = error {
                    self?.handleErrorWithMessage(errorMsg)
                } else {
                    self?.tableView.reloadData()
                }
                self?.refreshControl.endRefreshing()
            }
        }
        viewModel.updateHander = { [weak self] indexPath in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    @objc private func fetchUsers() {
        viewModel.fetchUserList()
    }

    private func handleErrorWithMessage(_ message: String) {
        let alert = UIAlertController(title: NSLocalizedString("alert_error_title", comment: ""),
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("alert_error_action_ok_title", comment: ""),
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension UserListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCount()
    }

    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        let cellViewModel = UserCellViewModel(user: viewModel.stackOverflowUserFor(indexPath))
        cellViewModel.delegate = viewModel
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UserListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshCell()
        guard viewModel.stackOverflowUserFor(indexPath).status == .blocked else { return }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        refreshCell()
    }

    private func refreshCell() {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
