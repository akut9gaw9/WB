//
//  Model.swift
//  WBTestovoe
//
//  Created by Stanislav on 03.08.2023.
//

import Foundation

struct Flights: Codable {
    var flights: [FlightsData]
}

struct FlightsData: Codable {
    var startDate: String?
    var startTime: String?
    var endTime: String?
    var endDate: String?
    var startCity: String?
    var endCity: String?
    var price: Int?
    var indexCell: Int?
    var colorIndicator: Bool?
}

