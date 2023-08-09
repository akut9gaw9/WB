//
//  DateConversion.swift
//  WBTestovoe
//
//  Created by Stanislav on 07.08.2023.
//

import Foundation

protocol DateConversionDelegate: AnyObject {
    func getConversionData(data: Flights?)
}

class DateConversion {
    
    weak var delegate: DateConversionDelegate?
    
    func setupDate(flights: Flights?) {
        guard let flights = flights else { return }
        var arr = flights
        let count = flights.flights.count
        
        for i in 0...count-1 {
            arr.flights[i].startDate = conversionData(string: flights.flights[i].startDate)
            arr.flights[i].endDate = conversionData(string: flights.flights[i].endDate)
            arr.flights[i].startTime = conversionTime(string: flights.flights[i].startDate)
            arr.flights[i].endTime = conversionTime(string: flights.flights[i].endDate)
        }
        
        delegate?.getConversionData(data: arr)
    }
    
    func conversionData(string: String?) -> String? {
        guard let string = string else { return nil }
        var str = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let range = str.range(of: "UTC") {
            str.removeSubrange(range)
        }
        
        guard let date = dateFormatter.date(from: str) else { return nil }
        dateFormatter.dateFormat = "d MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func conversionTime(string: String?) -> String? {
        
        guard let string = string else { return nil }
        var str = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        if let range = str.range(of: "UTC") {
            
            str.removeSubrange(range)
        }
        
        
        guard let date = dateFormatter.date(from: str) else { return nil }
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
}
