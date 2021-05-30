//
//  ServerListViewModel.swift
//  Windscribe Coding Challenge
//
//  Created by Deep on 2021-05-30.
//

import Foundation

class ServerListViewModel {
    
    func fetchServersJSON(completion: @escaping (Result<Servers, Error>) -> ()) {
        
        let urlString = "https://assets.windscribe.com/serverlist/ikev2/1/89yr4y78r43gyue4gyut43guy"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            // successful
            do {
                let serverList = try JSONDecoder().decode(Servers.self, from: data!)
                completion(.success(serverList))
                
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            
        }.resume()
    }
    
    func listServers() {
        fetchServersJSON { (result) in
            switch result {
            case .success(let servers):
                print(servers.data[0].countryCode)
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
}
