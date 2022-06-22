//
//  ViewController.swift
//  MilestoneCalculator
//
//  Created by Сережа Присяжнюк on 20.06.2022.
//

import UIKit

class MainViewController: BaseVC {
    
    // MARK: - Enum
    
    enum OperationType {
        case add
        case subtract
        case multiply
        case divide
        case percentage
    }
    
    // MARK: - UI Elements
    
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    
    // MARK: - Variables
    private var firstNumber: Float = 0.0
    private var secondNumber: Float = 0.0
    private var result: Float = 0.0
    
    private var currentOperation: OperationType?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI configuration
        configureNavigationBar()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(lightMode), name: NSNotification.Name("LightMode"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkMode), name: NSNotification.Name("DarkMode"), object: nil)
    }
    
    // MARK: - UI Configuration
    
    private func configureNavigationBar() {
        
        rightBarButton()
        leftBarButton()
        navigationTitle()
        
        navigationItem.rightBarButtonItem?.action = #selector(rightBarButtonNavigation)
        navigationItem.leftBarButtonItem?.action = #selector(leftBarButtonNavigation)
    }
    
    private func configureUI() {
        resultButton.layer.cornerRadius = 4
    }
    
    // MARK: - Objc functions
    
    @objc private func rightBarButtonNavigation() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController (withIdentifier: "CalcHistoryViewController") as! CalcHistoryViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func leftBarButtonNavigation() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController (withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func lightMode() {
        
        if overrideUserInterfaceStyle == .light {
            presentAlert(title: "Ooooops...", message: "Dark mode is already in use")
        } else {
            overrideUserInterfaceStyle = .light
            calculationLabel.textColor = .black
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    @objc func darkMode() {
        
        if overrideUserInterfaceStyle == .dark {
            presentAlert(title: "Ooooops...", message: "Dark mode is already in use")
        } else {
            calculationLabel.textColor = .white
            overrideUserInterfaceStyle = .dark
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    // MARK: - Private functions
    
    private func showNumber(_ number: String) {
        guard let text = calculationLabel.text else { return }
        
        if text == "0" {
            calculationLabel.text = "\(number)"
        } else {
            calculationLabel.text = "\(text)\(number)"
        }
    }
    
    private func operationPressed(currentOperation: OperationType) {
        
        guard let text = calculationLabel.text, let value = Float(text) else { return }
        
        firstNumber = value
        
        switch currentOperation {
        case .add:
            calculationLabel.text = ""
        case .subtract:
            calculationLabel.text = ""
        case .multiply:
            calculationLabel.text = ""
        case .divide:
            calculationLabel.text = ""
        case .percentage:
            calculationLabel.text = "\(value) %"
        }
    }
    
    private func showResult(result: Float, withSign: String) {
        
        resultLabel.isHidden = false
        
        if currentOperation == .percentage {
            resultLabel.text = "\(firstNumber) \(withSign)"
        } else {
            resultLabel.text = "\(firstNumber) \(withSign) \(secondNumber)"
        }
        
        calculationLabel.text = "= \(result)"
        calculationLabel.textColor = hexStringToUIColor(hex: "#11998E")
        
        Calculation.shared.saveCalculation(calculation: "\(firstNumber) \(withSign) \(secondNumber)", result: "\(result)")
    }
    
    private func resultButtonPressed(currentOperation: OperationType) {
        
        if let text = calculationLabel.text, let value = Float(text) {
            secondNumber = value
            
        }
        
        switch currentOperation {
            
        case .add:
            
            result =  firstNumber + secondNumber
            showResult(result: result, withSign: "+")
            
        case .subtract:
            
            result =  firstNumber - secondNumber
            showResult(result: result, withSign: "-")
       
        case .multiply:
            
            result =  firstNumber * secondNumber
            showResult(result: result, withSign: "×")
            
        case .divide:
           
            if secondNumber == 0 {
                presentAlert(title: "Error", message: "Cannot be divided by 0")
            } else {
                result =  firstNumber / secondNumber
                showResult(result: result, withSign: "÷")
            }
            
        case .percentage:
            
            result = firstNumber / 100
            showResult(result: result, withSign: "%")
        }
    }
    
    // MARK: - IB Actions
    
    @IBAction func clearAction(_ sender: Any) {
        
        calculationLabel.text = "0"
        calculationLabel.textColor = UIColor.black
        
        resultLabel.text = ""
        resultLabel.isHidden = true
        
        currentOperation = nil
        firstNumber = 0
    }
    
    @IBAction func resultAction(_ sender: Any) {
        guard let currentOperation = currentOperation else { return }
        resultButtonPressed(currentOperation: currentOperation)
    }
    @IBAction func subtractAction(_ sender: Any) {
        operationPressed(currentOperation: .subtract)
        currentOperation = .subtract
    }
    
    @IBAction func addAction(_ sender: Any) {
        operationPressed(currentOperation: .add)
        currentOperation = .add
    }
    
    @IBAction func divideAction(_ sender: Any) {
        operationPressed(currentOperation: .divide)
        currentOperation = .divide
    }
    
    @IBAction func multiplyAction(_ sender: Any) {
        operationPressed(currentOperation: .multiply)
        currentOperation = .multiply
    }
    
    @IBAction func percentageButtonAction(_ sender: Any) {
        operationPressed(currentOperation: .percentage)
        currentOperation = .percentage
    }
    
    @IBAction func changeSignAction(_ sender: Any) {
       
        firstNumber.negate()
        calculationLabel.text = ""
    }
    
    @IBAction func dotAction(_ sender: Any) {
        
        if calculationLabel.text?.contains(".") == true {
            presentAlert(title: "Error", message: "Your number already contains a .")
        } else {
            calculationLabel.text?.append(".")
        }
        
    }
    
    @IBAction func removeLastAction(_ sender: Any) {
        
        if calculationLabel.text == "" {
            presentAlert(title: "Error", message: "Nothing to delete")
        } else {
            calculationLabel.text?.removeLast()
        }
        
    }
    
    @IBAction func oneButtonAction(_ sender: Any) {
        showNumber("1")
    }
    
    @IBAction func twoButtonAction(_ sender: Any) {
        showNumber("2")
    }
    
    @IBAction func threeButtonAction(_ sender: Any) {
        showNumber("3")
    }
    
    @IBAction func fourButtonAction(_ sender: Any) {
        showNumber("4")
    }
    
    @IBAction func fiveButtonAction(_ sender: Any) {
        showNumber("5")
    }
    
    @IBAction func sixButtonAction(_ sender: Any) {
        showNumber("6")
    }
    
    @IBAction func sevenButtonAction(_ sender: Any) {
        showNumber("7")
    }
    
    @IBAction func eightButtonActtion(_ sender: Any) {
        showNumber("8")
    }
    
    @IBAction func nineButtonAction(_ sender: Any) {
        showNumber("9")
    }
    
    @IBAction func zeroButtonActtion(_ sender: Any) {
        showNumber("0")
    }
}
