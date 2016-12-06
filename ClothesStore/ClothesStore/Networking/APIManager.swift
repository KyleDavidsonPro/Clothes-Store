//
//  APIManager.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 05/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

struct APIManager {
    private let baseUrl = "https://private-anon-6d5dafff99-ddshop.apiary-mock.com"
    private let session = URLSession.shared
    
    /// build URLRequest for given endpoint
    private func buildRequest(for endpoint: Endpoint) -> URLRequest? {
        let requestUrl = baseUrl + endpoint.url
        
        guard let url = URL(string: requestUrl) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        
        if let headers = endpoint.headers {
            for (header, value) in headers {
                request.addValue(value, forHTTPHeaderField: header)
            }
        }
        
        return request
    }
    
    /// make request to a given endpoint
    func request(endpoint: Endpoint, completion: @escaping (JSON) -> Void) {
        if let request = buildRequest(for: endpoint) {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    let json = JSON(data: data)
                    completion(json)
                } else {
                    print(error)
                }
            }
            
            task.resume()
        }
    }
}



