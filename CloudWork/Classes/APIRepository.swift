//
//  APIRepository.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 20/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation

final class Repository {
    
    private let apiClient: APIClient!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getPosts(_ completion: @escaping ((Result<[Post]>) -> Void)) {
        let resource = Resource(url: URL(string: "http://albertolourenco.com.br/cloudwork/feed.php")!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
