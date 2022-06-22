//
//  CalcHistoryViewController.swift
//  MilestoneCalculator
//
//  Created by Сережа Присяжнюк on 20.06.2022.
//

import UIKit


class CalcHistoryViewController: BaseVC {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var calcHistoryTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Configuration
        configureNavigationBar()
        tableViewConfiguration()
    }
    
    // MARK: - UI Configuration
    
    private func configureNavigationBar() {
        backBarButton()
        navigationTitle()
    }
    
    private func tableViewConfiguration() {
        
        calcHistoryTableView.register(UINib(nibName: "CalcHistoryTVC", bundle: nil), forCellReuseIdentifier: CalcHistoryTVC.identifier)
        calcHistoryTableView.dataSource = self
        calcHistoryTableView.rowHeight = 132
    }
}

// MARK: - TableView data source

extension CalcHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Calculation.shared.calculationHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CalcHistoryTVC.identifier, for: indexPath) as! CalcHistoryTVC
        
        cell.config(calc: Calculation.shared.calculationHistory[indexPath.row].calculation,
                    result: Calculation.shared.calculationHistory[indexPath.row].result)
        
        return cell
    }
}

//  MARK: - UITableView Delegate

extension CalcHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            let index: Int = 0
            Calculation.shared.calculationHistory.remove(at: index)
            tableView.reloadData()
        }
    }
}


