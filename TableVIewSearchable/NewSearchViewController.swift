//
//  NewSearchViewController.swift
//  TableVIewSearchable
//
//  Created by GIGL iOS on 07/06/2022.
//

import UIKit

protocol ItemCategoryDelegate {
    func addCategory(_ theNewItem: [String])
}

class NewSearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    var delegate: ItemCategoryDelegate?
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please select category of item"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let controller = UISearchBar()
        controller.placeholder = "Search for a category"
        controller.searchBarStyle = .minimal
        controller.showsCancelButton = true
        controller.translatesAutoresizingMaskIntoConstraints = false
        controller.tintColor = .black
        return controller
    }()
    
    private var discoverTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var categoriesAndDetails = [["RowVersion": "AAAAAAUBT4Y =", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Books & Magazine", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4c=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Art & Craft", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 0], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Kitchen ware & Utensils", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Ware", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Utensils", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Kitchen", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1]]
    
    var theFilteredArray = [[String:Any]]()
    var isSearchStations = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        theFilteredArray = categoriesAndDetails
        activateConstraint()
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        
        searchBar.delegate = self
        
        self.discoverTableView.reloadData()
        print("these are the array from page b4 ->> \(categoriesAndDetails)")
    }
    
    private func activateConstraint() {
        view.addSubview(backButton)
        view.addSubview(instructionLabel)
        view.addSubview(searchBar)
        view.addSubview(discoverTableView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            instructionLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -2),
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchBar.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 30),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            discoverTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            discoverTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            discoverTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            discoverTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    
    @objc func didTapCancelButton() {
        print("back pressed")
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theFilteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoverTableView.dequeueReusableCell(withIdentifier: "cell")
        let theCategoriesAndDetails =  theFilteredArray[indexPath.row]
        var theCategory = ""
        theCategory = theCategoriesAndDetails["CategoryName"] as! String
        cell?.textLabel?.text = theCategory
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filteredCategoryIndex = theFilteredArray[indexPath.row]
        let category = filteredCategoryIndex["CategoryName"]
        let servicesAvailable = (filteredCategoryIndex["isGoStandard"], filteredCategoryIndex["isGoFaster"])
        var arrayOfAvailableServices = [String]()
        var availableService = ""
        
        if filteredCategoryIndex["IsGoFaster"] as! Int != 1 || filteredCategoryIndex["IsGoStandard"] as! Int != 1 {
            print("alert issearch true")
            if filteredCategoryIndex["IsGoFaster"] as! Int == 1 {
                availableService = "GoFaster"
            } else {
                availableService = "GoStandard"
            }
            showCustomSimpleAlert("", message: "\(category ?? "") can only be shipped from the US through \(availableService). Would you like to proceed.", okString: "Yes", cancelString: "No") { _ in
                arrayOfAvailableServices.append(availableService)
                self.delegate?.addCategory(arrayOfAvailableServices)
                print("okay, it is \(availableService)")
                self.navigationController?.popViewController(animated: true)
            } cancelCompletion: { _ in
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            arrayOfAvailableServices.append("GoFaster")
            arrayOfAvailableServices.append("GoStandard")
            print("-- here is array of available services = \(arrayOfAvailableServices)")
            self.delegate?.addCategory(arrayOfAvailableServices)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if categoriesAndDetails.count == 0 {
            return
        }
        if searchText == "" {
            theFilteredArray = categoriesAndDetails
            discoverTableView.reloadData()
        }
        else {
            searchAutocompleteEntriesWithSubstring(searchText.uppercased())
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchAutocompleteEntriesWithSubstring(_ substring:String) {
        
        theFilteredArray.removeAll()
        theFilteredArray = categoriesAndDetails.filter({ (text) -> Bool in
            let tmp: NSString = text["CategoryName"] as! NSString
            let range = tmp.range(of: substring, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        discoverTableView.reloadData()
    }
    
    func showCustomSimpleAlert(_ title:String, message:String?, okString: String, cancelString: String, completion: @escaping (UIAlertAction) -> (), cancelCompletion: @escaping (UIAlertAction) -> ()) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okString, style: .default, handler:completion)
        let cancelAction = UIAlertAction(title: cancelString, style: .cancel, handler: cancelCompletion)
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
}

extension String {
    func containsString(theString:String) -> Bool {
        return self.range(of: theString) != nil
    }
}
