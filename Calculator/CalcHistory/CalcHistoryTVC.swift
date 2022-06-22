//
//  CalcHistoryTVC.swift
//  MilestoneCalculator
//
//  Created by Сережа Присяжнюк on 20.06.2022.
//

import UIKit

class CalcHistoryTVC: UITableViewCell {

    static let identifier = "CalcHistoryTVC"
    
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func config(calc: String, result: String) {
        calculationLabel.text = calc
        resultLabel.text = result
    }
}
