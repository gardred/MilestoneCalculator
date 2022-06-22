//
//  UIAlert-.swift
//  MilestoneCalculator
//
//  Created by Сережа Присяжнюк on 21.06.2022.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
}
