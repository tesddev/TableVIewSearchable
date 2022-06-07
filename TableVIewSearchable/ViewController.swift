//
//  ViewController.swift
//  TableVIewSearchable
//
//  Created by GIGL iOS on 31/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var categories = [String]()
    
    var categoriesAndDetails = [["RowVersion": "AAAAAAUBT4Y =", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Books & Magazine", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4c=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Art & Craft", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4g =", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Kitchen ware & Utensils", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1]]

    var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        activateConstraint()
        print("loaded")
        
        for cat in self.categoriesAndDetails {
            self.categories.append(cat["CategoryName"] as! String)
            print(categories)
        }
        
        APINetworking().getInternationalShipmentInstructionNotAlamoFire { theResponseValue, errorMessage in
            print(theResponseValue?.object as Any, errorMessage as Any)
            let category = theResponseValue?.object
            for each in category ?? [] {
                
            }
        }
        
    }
    
    private func addSubviews() {
        view.addSubview(okButton)
    }
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            okButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: 60),
            okButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc func didTapOkButton(_ sender: Any) {
        print("ok tapped")
        self.navigationController?.pushViewController(NewSearchViewController(), animated: true)

    }
    
}

