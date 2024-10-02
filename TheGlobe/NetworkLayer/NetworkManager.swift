//
//  NetworkManager.swift
//  TheGlobe
//
//  Created by Daljeet Singh on 30/09/24.
//

import Foundation

class NetworkManager: NSObject {
    private let baseUrl: String

    private init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    static func shared() -> NetworkManager {
        return NetworkManager(baseUrl: Constants.baseUrl)
    }

    func requestWith(path: String,
                     completion: @escaping (Result<Stories, Error>) -> Void){
        if !Reachability.shared().isConnectedToNetwork() {
            completion(.failure(NetworkError.notReachable))
        } else {
            if let url = URL(string: "\(baseUrl)\(path)") {
                URLSession.shared.dataTask(with: url) { data, _, error in

                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let data = data else {
                        completion(.failure(NetworkError.decoding))
                        return
                    }

                    do {
                        let recommendations = try JSONDecoder().decode(Stories.self, from: data)
                        completion(.success(recommendations))
                    } catch {
                        completion(.failure(error))
                    }

                }.resume()
            } else {
                completion(.failure(NetworkError.invalidUrl))
            }
        }
    }
}
