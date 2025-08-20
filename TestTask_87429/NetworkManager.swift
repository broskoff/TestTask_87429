//
//  NetworkManager.swift
//  TestTask_87429
//
//  Created by Tanya G. on 19.08.2025.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let url = "https://fakestoreapi.com/products/1"
    
    func sendRequest(completion: @escaping (String, Float) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data else { return }
           
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                completion(result.title, result.price)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
