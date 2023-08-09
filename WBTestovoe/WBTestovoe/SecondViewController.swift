//
//  SecondViewController.swift
//  WBTestovoe
//
//  Created by Stanislav on 08.08.2023.
//

import UIKit

protocol ColorChangeLikeinTableView: AnyObject {
    func colorChangeinTableView(colorIndicator: Bool, indexCell: Int)
}

class SecondViewController: UIViewController {
    
    weak var delegate: ColorChangeLikeinTableView?
    var indexCell: Int?
    var colorIndicator: Bool?
    let citysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let timeFlightsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let dateFlightsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let ticketPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedSystemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var hearthButton: UIButton = {
        let button = UIButton()
        button.setImage(secondImage, for: .normal)
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    
    let firstImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.red)
    let secondImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    func setupImage() {
        print(colorIndicator)
        if colorIndicator == true {
            hearthButton.setImage(secondImage, for: .normal)
        } else {
            hearthButton.setImage(firstImage, for: .normal)
        }
    }
    func setupConstraints() {
        citysLabel.translatesAutoresizingMaskIntoConstraints = false
        timeFlightsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFlightsLabel.translatesAutoresizingMaskIntoConstraints = false
        ticketPrice.translatesAutoresizingMaskIntoConstraints = false
        hearthButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(citysLabel)
        view.addSubview(timeFlightsLabel)
        view.addSubview(dateFlightsLabel)
        view.addSubview(ticketPrice)
        view.addSubview(hearthButton)
        
        NSLayoutConstraint.activate([
            citysLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citysLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            dateFlightsLabel.topAnchor.constraint(equalTo: citysLabel.bottomAnchor),
            dateFlightsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            timeFlightsLabel.topAnchor.constraint(equalTo: dateFlightsLabel.bottomAnchor),
            timeFlightsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            ticketPrice.topAnchor.constraint(equalTo: timeFlightsLabel.bottomAnchor),
            ticketPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            hearthButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hearthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupTexts(startCity: String, endCity: String, startDate: String, endDate: String, startTimeDate: String, endTimeDate: String, ticketPrice: Int, colorIndicator: Bool, indexCell: Int) {
        self.citysLabel.text = "\(startCity) - \(endCity)"
        self.timeFlightsLabel.text = "\(startTimeDate) - \(endTimeDate)"
        self.dateFlightsLabel.text = "\(startDate) - \(endDate)"
        self.ticketPrice.text = "\(ticketPrice)₽"
        self.colorIndicator = colorIndicator
        self.indexCell = indexCell
        setupImage()
    }

    @objc func changeColor() {
        if colorIndicator! {
            colorIndicator = false
            hearthButton.setImage(firstImage, for: .normal)
            delegate?.colorChangeinTableView(colorIndicator: colorIndicator!, indexCell: indexCell!)
        } else {
            colorIndicator = true
            hearthButton.setImage(secondImage, for: .normal)
            delegate?.colorChangeinTableView(colorIndicator: colorIndicator!, indexCell: indexCell!)
        }
    }


}

