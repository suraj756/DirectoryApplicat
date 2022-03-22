
//
//  UserDataModel.swift
//  Directory App
//
//  Created by SAISURAJ on 3/18/22.
//  Copyright © 2022 SAISURAJ. All rights reserved.
//

import UIKit


class UserDataModel {
    
    var URLReqObj:URLRequest!
    var dataTaskObj:URLSessionDataTask!
    var arrUsers = [PeopleModel]()
    var arrRooms = [RoomsModel]()
    var endPoint = String()
    weak var vc:ViewController?
    weak var vc2:RoomsViewController?
    var roomsDetails = Bool()

 
    func getAllUserData(){
        if roomsDetails == false{
            endPoint = "people"
        }
        else{
            endPoint = "rooms"
        }
        DispatchQueue.main.async {
            self.vc?.addSplashLoaderView()
        }
        URLSession.shared.dataTask(with: URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/\(endPoint)")!) { (data, response, error) in
            if error == nil{
                
                if let data = data{
                  do{
                    if self.roomsDetails == false{
                    let userResponse = try JSONDecoder().decode([PeopleModel].self, from: data)
                   // print(userResponse)
                    for users in userResponse{
                        self.arrUsers.append(users)
                     }
                     peopleModelData.append(contentsOf: self.arrUsers)
                    DispatchQueue.main.async {
                        self.vc?.removeLoader()
                        self.vc?.tblView.reloadData()
                      }
                    }
                    else{
                        let roomsResponse = try JSONDecoder().decode([RoomsModel].self, from: data)
                          
                        // print(userResponse)
                         for rooms in roomsResponse{
                             self.arrRooms.append(rooms)
                          }
                       DispatchQueue.main.async {
                         self.vc?.removeLoader()
                          self.vc2?.tblView.reloadData()
                        }
                     }
                  }
                  catch{
                    
                    print(error.localizedDescription)
                   }
                }
            }
            else{
                DispatchQueue.main.async {
                  self.vc?.removeLoader()
                }
                print(error?.localizedDescription)
            }
        }.resume()
     }
}
