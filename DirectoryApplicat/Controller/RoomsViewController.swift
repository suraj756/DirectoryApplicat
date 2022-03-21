//
//  RoomsViewController.swift
//  Directory App
//
//  Created by SAISURAJ on 3/18/22.
//  Copyright © 2022 SAISURAJ. All rights reserved.
//

import UIKit

class RoomsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    @IBOutlet weak var tblView: UITableView!
    
    var viewModelRooms = UserDataModel()
    var modelUsers: PeopleModel? = nil
    var storeRoomIds = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModelRooms.vc2 = self
        viewModelRooms.roomsDetails = true
       self.viewModelRooms.getAllUserData()
    navigationController?.navigationBar.isHidden = true
 
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
        
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsTableViewCell", for: indexPath) as? RoomsTableViewCell
        if viewModelRooms.arrRooms.count != 0{
        for id in 0...viewModelRooms.arrRooms.count-1{
            if modelUsers?.id == viewModelRooms.arrRooms[id].id{
                let modelRooms = viewModelRooms.arrRooms[id]
            cell?.modelRooms = modelRooms
            }
          }
        }
        return cell!
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
}
