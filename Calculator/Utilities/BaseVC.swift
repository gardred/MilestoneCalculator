//
//  BaseVC.swift
//  MilestoneCalculator
//
//  Created by Сережа Присяжнюк on 20.06.2022.
//

import UIKit


class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func navigationTitle() {
        navigationItem.title = "Calculator"
    }

    func rightBarButton() {
        let image = UIImage(named: "history")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }
    
    func leftBarButton() {
        let image = UIImage(named: "settings")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .plain,
                                                           target: self,
                                                           action: nil)
    }
    
    func backBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(popViewController))
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
