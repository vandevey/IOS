//
//  NetworkManager.swift
//  ProjectDIM
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 Yoan Vandevelde. All rights reserved.
//
import UIKit
import Foundation

class NetworkManager {
    
    private static var sharedNetworkManager: NetworkManager = {
        return NetworkManager(baseURL: APImanager.shared.defaultURL)
    }()
    
    var requestURL: URLComponents
    let session = URLSession.shared
    
    private init(baseURL: URLComponents) {
        self.requestURL = baseURL
    }
    
    class func shared() -> NetworkManager {
        return sharedNetworkManager
    }
    
    func fetchData(path: String, queries: [String: String] = [:] ,completion: @escaping (Data) -> Void) -> Void {
        var baseRequestUrl = requestURL
        baseRequestUrl.path += path
        if !queries.isEmpty {
            queries.forEach { (key: String, value: String) in
                 baseRequestUrl.queryItems?.append(URLQueryItem(name: key, value: value))
            }
           
        }
        if let url = baseRequestUrl.url {
            self.session.dataTask(with: url) { data, response, error in
             
                guard error == nil else {
                    return
                }
                if let data = data {
                    completion(data)
                }
            }.resume()
        }
    }
    
    func getUrl(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getImage(url: String, completion: @escaping (UIImage?) -> ()) {
        if let url = URL(string: url)  {
            getUrl(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async() {
                    completion(UIImage(data: data))
                }
            }
        }
    }
}
