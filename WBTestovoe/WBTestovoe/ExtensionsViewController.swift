//
//  ExtensionsViewContorller.swift
//  WBTestovoe
//
//  Created by Stanislav on 03.08.2023.
//

import Foundation
import UIKit

extension ViewController: NetworkServiceDelegate {
    func getApi(data: Data) {
        flightData = try! JSONDecoder().decode(Flights.self, from: data)
        
        let dateConversion = DateConversion()
        dateConversion.delegate = self
        dateConversion.setupDate(flights: flightData)
        
    }
}

extension ViewController: DateConversionDelegate {
    func getConversionData(data: Flights?) {
        flightData = data
        guard let count = flightData?.flights.count else { return }
        DispatchQueue.global(qos: .background).async {
            for i in 0...count-1 {
                self.flightData?.flights[i].indexCell = i
                self.flightData?.flights[i].colorIndicator = true
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: LikeColorChangeDelegate {
    func changeColor(colorIndicator: Bool, number: Int) {
        flightData?.flights[number].colorIndicator = colorIndicator
    }
}

extension ViewController: ColorChangeLikeinTableView {
    
    func colorChangeinTableView(colorIndicator: Bool, indexCell: Int) {
        flightData?.flights[indexCell].colorIndicator = colorIndicator
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRows = flightData?.flights.count else { return 0 }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.delegate = self
        guard let item = flightData?.flights[indexPath.row] else { return UITableViewCell() }
        cell.setupCell(startCity: item.startCity!,
                       endCity: item.endCity!,
                       startDate: item.startDate!,
                       endDate: item.endDate!,
                       startTimeDate: item.startTime!,
                       endTimeDate: item.endTime!,
                       ticketPrice: item.price!,
                       indexCell: item.indexCell!,
                       colorIndicator: item.colorIndicator!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = flightData?.flights[indexPath.row] else { return }
        let vc = SecondViewController()
        vc.delegate = self
        vc.setupTexts(startCity: item.startCity!,
                      endCity: item.endCity!,
                      startDate: item.startDate!,
                      endDate: item.endDate!,
                      startTimeDate: item.startTime!,
                      endTimeDate: item.endTime!,
                      ticketPrice: item.price!,
                      colorIndicator: item.colorIndicator!,
                      indexCell: item.indexCell!)
        navigationController?.pushViewController(vc, animated: true)
    }
}

