//
//  ViewController.swift
//  TableVIewSearchable
//
//  Created by GIGL iOS on 31/05/2022.
//

import UIKit

class ViewController: UIViewController, ItemCategoryDelegate  {
    func addCategory(_ theNewItem: [String]) {
        var finalString = ""
        if theNewItem.count == 2 {
            let one = theNewItem[0]
            let two = theNewItem[1]
            finalString = one + two
        } else {
            finalString = theNewItem[0]
        }
        self.instructionLabel.text = finalString
        let vc = HideViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
    
    private var instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Press okay to select"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        activateConstraint()
        print("loaded")
        
        let arr = ["v", "r"]
        print(arr.count)
        
        for cat in self.categoriesAndDetails {
            self.categories.append(cat["CategoryName"] as! String)
            print(categories)
        }
        
        APINetworking().getInternationalShipmentInstructionNotAlamoFire { theResponseValue, errorMessage in
//            print(theResponseValue?.object as Any, errorMessage as Any)
        }
    }
   
    
    private func addSubviews() {
        view.addSubview(okButton)
        view.addSubview(instructionLabel)
    }
    
    func activateConstraint() {
        NSLayoutConstraint.activate([
            okButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: 60),
            okButton.heightAnchor.constraint(equalToConstant: 30),
            
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func didTapOkButton(_ sender: Any) {
        print("ok tapped")
        let vc = NewSearchViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

