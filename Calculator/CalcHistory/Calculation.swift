//
//  Calculation.swift
//  MilestoneCalculator
//
//  Created by Сережа Присяжнюк on 22.06.2022.
//

import Foundation

class Calculation {
    
    let defaults = UserDefaults.standard
    static let shared = Calculation()
    
    struct CalculationHistory: Codable {
        var calculation: String
        var result: String
    }
    
    var calculationHistory: [CalculationHistory] {
        get {
            if let data = defaults.value(forKey: "calc") as? Data {
                return try! PropertyListDecoder().decode([CalculationHistory].self, from: data)
            } else {
                return [CalculationHistory]()
            }
        } set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "calc")
            }
        }
    }
    
    func saveCalculation(calculation: String, result: String) {
        let calculation = CalculationHistory(calculation: calculation, result: result)
        calculationHistory.insert(calculation, at: 0)
    }
}
