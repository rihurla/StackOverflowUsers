//
//  RepositoryService.swift
//  StackOverflowUsers
//
//  Created by Ricardo Hurla on 15/12/2019.
//  Copyright © 2019 Ricardo Hurla. All rights reserved.
//

import Foundation

public protocol RepositoryServiceType {
    func makeRequest<T: Decodable>(url: URL?,
                                   success: @escaping (T) -> Void,
                                   failure: @escaping (Error?) -> Void)
}

public struct RepositoryService: RepositoryServiceType {
    public func makeRequest<T: Decodable>(url: URL?,
                                           success: @escaping (T) -> Void,
                                           failure: @escaping (Error?) -> Void) {
        guard let requestUrl = url else {
            failure(RepositoryError.urlError)
            return
        }
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            guard let requestData = data, error == nil else {
                failure(error)
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: requestData)
                success(decodedObject)
            } catch {
                failure(error)
            }
        }.resume()
    }
}
