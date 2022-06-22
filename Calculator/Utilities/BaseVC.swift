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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gobackward.minus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }
    
    func leftBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
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
