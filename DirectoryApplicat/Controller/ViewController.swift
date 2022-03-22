//
//  ViewController.swift
//  Directory App
//
//  Created by SAISURAJ on 3/18/22.
//  Copyright © 2022 SAISURAJ. All rights reserved.
//

import UIKit

var peopleModelData = [PeopleModel]()
var searchResults = [PeopleModel]()

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchControllerDelegate {

    @IBOutlet var noResultsView: UIView!
    @IBOutlet weak var tblView: UITableView!
    var searchActive = false
    let searchController = UISearchController(searchResultsController: nil)
    var viewModelUser = UserDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelUser.vc = self
        viewModelUser.roomsDetails = false
        viewModelUser.getAllUserData()
        self.noResultsView.frame  = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        self.noResultsView.center = self.tblView.center
        hideKeyboardWhenTappedAround()
      
        // Do any additional setup after loading the view.
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    func addSplashLoaderView() {
      if let customView = Bundle.main.loadNibNamed("SplashLoader", owner: self, options: nil)?.first as? SplashLoader {
            customView.frame = self.view.frame
            customView.tag   = 150
         self.view.addSubview(customView)
        }
    }
    func removeLoader() {
        let customView = self.view.viewWithTag(150)
        customView?.removeFromSuperview()
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.noResultsView.isDescendant(of: self.view) {
                   self.noResultsView.removeFromSuperview()
               }
        searchBarSetup()
        navigationController?.navigationBar.isHidden = false
    }
    
    private func searchBarSetup(){
    
    searchController.searchResultsUpdater = self as? UISearchResultsUpdating
    searchController.searchBar.placeholder = "Search Your Name"
    searchController.searchBar.delegate = self
        // navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
         self.tblView.tableHeaderView = searchController.searchBar
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive == true {
            return searchResults.count
        }
        else{
            return viewModelUser.arrUsers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell
        if searchController.isActive == true {
            searchActive = true
            let modelUser = searchResults[indexPath.row]
            cell?.modelUser = modelUser
        }
        else{
       searchActive = false
       let modelUser = viewModelUser.arrUsers[indexPath.row]
       cell?.modelUser = modelUser
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let RoomsViewController = self.storyboard?.instantiateViewController(withIdentifier: "RoomsViewController") as! RoomsViewController
        if searchActive == true {
           self.tblView.tableHeaderView = nil
          let modelUser = searchResults[indexPath.row]
          RoomsViewController.modelUsers = modelUser
        }
        else{
        let modelUser = viewModelUser.arrUsers[indexPath.row]
        RoomsViewController.modelUsers = modelUser
        }
    self.navigationController?.pushViewController(RoomsViewController, animated: true)
    }

}

extension ViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        // later
        guard let searchText = searchController.searchBar.text else { return }
        if searchText == ""{
            viewModelUser.arrUsers = peopleModelData
        }else{
         
            searchResults = [PeopleModel]()
            viewModelUser.arrUsers = peopleModelData
            viewModelUser.arrUsers = viewModelUser.arrUsers.filter{
               
                $0.firstName!.contains(searchText) || $0.lastName!.contains(searchText)
            }
            
        }
        searchResults.append(contentsOf: viewModelUser.arrUsers)
        print(viewModelUser.arrUsers,"firstArrUsers")
        tblView.reloadData()
    }
    
}
