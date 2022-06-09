//
//  HideViewController.swift
//  TableVIewSearchable
//
//  Created by GIGL iOS on 08/06/2022.
//

import UIKit

class HideViewController: UIViewController {

    var availableOption = [String]()
    var goStandard: UIButton = {
        let button = UIButton()
        button.setTitle("GoStandard", for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.backgroundColor = .systemGray
//        button.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var goFaster: UIButton = {
        let button = UIButton()
        button.setTitle("GoFaster", for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.backgroundColor = .systemGray
//        button.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activateConstraint()
        print("omo see available ones - \(availableOption)")
        addCategory(availableOption)
    }
    
    func addCategory(_ theNewItem: [String]) {
        var finalString = ""
        if theNewItem.count == 2 {
            print("no problem")
        }
        else {
            finalString = theNewItem[0]
            print("wahala")
            if finalString == "GoFaster" {
                goStandard.isHidden = true
            } else {
                goFaster.isHidden = true
            }
        }
    }
    
    func activateConstraint() {
        view.addSubview(goStandard)
        view.addSubview(goFaster)
        NSLayoutConstraint.activate([
            goStandard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            goStandard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goStandard.widthAnchor.constraint(equalToConstant: 120),
            goStandard.heightAnchor.constraint(equalToConstant: 30),
            
            goFaster.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            goFaster.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goFaster.widthAnchor.constraint(equalToConstant: 120),
            goFaster.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
