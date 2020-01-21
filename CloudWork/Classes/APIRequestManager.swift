//
//  APIRequestManager.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 20/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

// TODO: - Move to the separated file Resource.swift
struct Resource {
    let url: URL
    let method: String = "GET"
}

// TODO: - Move to the separated file GenericResult.swift
enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIClientError: Error {
    case noData
}

// TODO: - Move to the separated file URLRequest+Resource.swift
extension URLRequest {
    
    init(_ resource: Resource) {
        self.init(url: resource.url)
        self.httpMethod = resource.method
    }
}

final class APIClient {
    
    func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let `data` = data else {
                DispatchQueue.main.async {
                    result(.failure(APIClientError.noData))
                }
                return
            }
            if let `error` = error {
                DispatchQueue.main.async {
                    result(.failure(error))
                }
                return
            }
            DispatchQueue.main.async {
                result(.success(data))
            }
        }
        task.resume()
    }
}
