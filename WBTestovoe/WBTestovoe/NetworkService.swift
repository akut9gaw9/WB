//
//  NetworkService.swift
//  WBTestovoe
//
//  Created by Stanislav on 03.08.2023.
//

import Foundation

protocol NetworkServiceDelegate: AnyObject {
    
    func getApi(data: Data)
    
}


class NetworkService {
    
    weak var delegate: NetworkServiceDelegate?
    
    func getApi(urlRequest: URLRequest)  {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { print("ERROR: ", error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            self.delegate?.getApi(data: data)
        }.resume()
    }
}
