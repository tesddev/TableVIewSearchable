//
//  SearchViewController.swift
//  TableVIewSearchable
//
//  Created by GIGL iOS on 31/05/2022.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var categoriesAndDetails = [Dictionary<String, Any>]()
    
    let refreshController = UIRefreshControl()
    
    var cat = [["RowVersion": "AAAAAAUBT4Y =", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Books & Magazine", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4c=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Art & Craft", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 0], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Kitchen ware & Utensils", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Ware", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Utensils", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1], ["RowVersion": "AAAAAAUBT4g=", "DateCreated": "2022-06-01T11:16:50.747", "CategoryName": "Kitchen", "DateModified": "2022-06-01T11:16:50.747", "IsDeleted": 0, "IsGoFaster": 1, "IsGoStandard": 1]]
        
    var isSearch : Bool = false
    var filteredTableData:[[String: Any]] = [[:]]
    
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
        label.text = "Select category of item"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let controller = UISearchBar()
        controller.placeholder = "Search for a category"
        controller.searchBarStyle = .minimal
        controller.showsCancelButton = true
        controller.translatesAutoresizingMaskIntoConstraints = false
        
        return controller
    }()
    
    private var discoverTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.categoriesAndDetails = self.cat
            self.discoverTableView.reloadData()
        }

        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
//        discoverTableView.delegate = self
//        discoverTableView.dataSource = self
        
        activateConstraint()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.categoriesAndDetails = self.cat
//            self.discoverTableView.reloadData()
//        }
        
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        
        searchBar.delegate = self
        
        discoverTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearch) {
            return filteredTableData.count
        }else{
            return categoriesAndDetails.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = discoverTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        if (isSearch) {
            cell.textLabel?.text = filteredTableData[indexPath.row]["CategoryName"] as! String
            return cell
        }
        else {
            cell.textLabel?.text = categoriesAndDetails[indexPath.row]["CategoryName"] as! String
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearch {
            let filteredCategoryIndex = filteredTableData[indexPath.row]
            let category = filteredCategoryIndex["CategoryName"]
            if filteredCategoryIndex["IsGoFaster"] as! Int != 1 || filteredCategoryIndex["IsGoStandard"] as! Int != 1 {
                print("alert issearch true")
            }
            print("did select pressed")
        } else {
            let categoryIndex = categoriesAndDetails[indexPath.row]
            if categoryIndex["IsGoFaster"] as! Int != 1 || categoryIndex["IsGoStandard"] as! Int != 1 {
                print("alert")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    @objc func didTapCancelButton() {
        print("back pressed")
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate{
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        isSearch = false
        discoverTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearch = false
            self.discoverTableView.reloadData()
        } else {
            filteredTableData = categoriesAndDetails.filter({ (text) -> Bool in
                let tmp: NSString = text["CategoryName"] as! NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if(filteredTableData.count == 0){
                isSearch = false
            } else {
                isSearch = true
                print(">>> \(filteredTableData)")
            }
            self.discoverTableView.reloadData()
        }
    }
}
