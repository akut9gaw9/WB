//
//  ViewController.swift
//  WBTestovoe
//
//  Created by Stanislav on 03.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var flightData: Flights?
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .systemBackground
        self.title = "Пора в путешествие"
        setupURLRequest()
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupURLRequest() {
        let networkService = NetworkService()
        
        guard let url = URL(string: "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap"),
              let payload = "{\"startLocationCode\": \"LED\"}".data(using: .utf8)
        else { return }
        
        let headers = [
            "authority": "vmeste.wildberries.ru",
            "accept": "application/json, text/plain, */*",
            "cache-control": "no-cache",
            "content-type": "application/json",
            "origin": "https://vmeste.wildberries.ru",
            "pragma": "no-cache",
            "referer": "https://vmeste.wildberries.ru/avia",
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-origin"
        ]
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        request.httpBody = payload
        networkService.delegate = self
        networkService.getApi(urlRequest: request)
    }
}

