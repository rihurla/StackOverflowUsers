//
//  ServiceManager.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public typealias RepositoryParameters = [String: String]

public protocol RepositoryResources {
    func fetchUserList(parameters: RepositoryParameters?,
                       success: @escaping ([StackOverflowUser]) -> Void,
                       failure: @escaping (Error?) -> Void)
}

public struct StackOverflowRepository: RepositoryResources {
    private let service: RepositoryServiceType
    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = ServiceUrls.scheme
        urlComponents.host = ServiceUrls.baseUrl + ServiceUrls.apiVersion
        return urlComponents
    }

    init(service: RepositoryServiceType = RepositoryService()) {
        self.service = service
    }

    public func fetchUserList(parameters: RepositoryParameters?,
                              success: @escaping ([StackOverflowUser]) -> Void,
                              failure: @escaping (Error?) -> Void) {
        var components = urlComponents
        components.path = ServiceUrls.userListPath
        if let queryParameters = parameters { components.setQueryItems(with: queryParameters) }
        service.makeRequest(url: components.url, success: { (users: [StackOverflowUser]) in
            success(users)
        }, failure: { (error) in
            failure(error)
        })
    }
}
