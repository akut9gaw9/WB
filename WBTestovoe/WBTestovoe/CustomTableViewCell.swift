//
//  CustomTableViewCell.swift
//  WBTestovoe
//
//  Created by Stanislav on 07.08.2023.
//

import UIKit

protocol LikeColorChangeDelegate: AnyObject {
    func changeColor(colorIndicator: Bool, number: Int)
}

class CustomTableViewCell: UITableViewCell {

    weak var delegate: LikeColorChangeDelegate?
    var colorIndicator = true
    var indexCell = 0
    let firstImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.red)
    let secondImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
     
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
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        setupConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        citysLabel.translatesAutoresizingMaskIntoConstraints = false
        timeFlightsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFlightsLabel.translatesAutoresizingMaskIntoConstraints = false
        ticketPrice.translatesAutoresizingMaskIntoConstraints = false
        hearthButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(citysLabel)
        contentView.addSubview(timeFlightsLabel)
        contentView.addSubview(dateFlightsLabel)
        contentView.addSubview(ticketPrice)
        contentView.addSubview(hearthButton)
        
        NSLayoutConstraint.activate([
            ticketPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            ticketPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            dateFlightsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            dateFlightsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            timeFlightsLabel.bottomAnchor.constraint(equalTo: dateFlightsLabel.topAnchor),
            timeFlightsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            citysLabel.bottomAnchor.constraint(equalTo: timeFlightsLabel.topAnchor),
            citysLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        
            hearthButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            hearthButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    func setupCell(startCity: String, endCity: String, startDate: String, endDate: String, startTimeDate: String, endTimeDate: String, ticketPrice: Int, indexCell: Int, colorIndicator: Bool) {
        self.citysLabel.text = "\(startCity) - \(endCity)"
        self.timeFlightsLabel.text = "\(startTimeDate) - \(endTimeDate)"
        self.dateFlightsLabel.text = "\(startDate) - \(endDate)"
        self.ticketPrice.text = "\(ticketPrice)₽"
        self.indexCell = indexCell
        setupImage(colorIndicator: colorIndicator)
    }
    
    func setupImage(colorIndicator: Bool) {
        if colorIndicator {
            hearthButton.setImage(secondImage, for: .normal)
            self.colorIndicator = colorIndicator
        } else {
            hearthButton.setImage(firstImage, for: .normal)
        }
    }
    
    @objc func changeColor() {
        if colorIndicator {
            colorIndicator = false
            hearthButton.setImage(firstImage, for: .normal)
            delegate?.changeColor(colorIndicator: colorIndicator, number: indexCell)
        } else {
            colorIndicator = true
            hearthButton.setImage(secondImage, for: .normal)
            delegate?.changeColor(colorIndicator: colorIndicator, number: indexCell)
        }
    }
    
}
