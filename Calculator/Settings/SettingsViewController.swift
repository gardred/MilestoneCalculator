//
//  SettingsViewController.swift
//  MilestoneCalculator
//
//  Created by Сережа Присяжнюк on 20.06.2022.
//

import UIKit

class SettingsViewController: BaseVC {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var lightModeButon: UIButton!
    @IBOutlet weak var darkModeButton: UIButton!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI Configuration
        configureUIElements()
        configureNavigationBar()
        
    }

    // MARK: - UI Configuration
    
    private func configureNavigationBar() {
        backBarButton()
        navigationTitle()
    }
    
    private func configureUIElements() {
        
        backgroundView.layer.cornerRadius = backgroundView.frame.height / 2
    }
    
    // MARK: - IBActions
    
    @IBAction func lightModeAction(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("LightMode"), object: nil)
        
        if overrideUserInterfaceStyle == .light {
            presentAlert(title: "Ooooops...", message: "Dark mode is already in use")
        } else {
            overrideUserInterfaceStyle = .light
            navigationController?.navigationBar.tintColor = UIColor.black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }
    
    
    @IBAction func darkModeAction(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name("DarkMode"), object: nil)
        
        if overrideUserInterfaceStyle == .dark {
            presentAlert(title: "Ooooops...", message: "Dark mode is already in use")
        } else {
            overrideUserInterfaceStyle = .dark
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
}
