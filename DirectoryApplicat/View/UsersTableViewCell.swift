//
//  UsersTableViewCell.swift
//  Directory App
//
//  Created by SAISURAJ on 3/18/22.
//  Copyright © 2022 SAISURAJ. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var favColour: UILabel!
    let imageCache = NSCache<NSString, UIImage>()
    var modelUser:PeopleModel?{
        didSet{
            getImageViewCircle()
            userConfig()
        }
    }
    
    func getImageViewCircle(){
        let radius = avatar.frame.height / 2.5
        avatar.layer.cornerRadius = radius
        avatar.layer.masksToBounds = false
        
    }
    func cacheImages(){
     if let url = URL(string: (modelUser?.avatar)!) {
         URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

       if error != nil {
         print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
         return
       }
      DispatchQueue.main.async { [weak self] in
        if let data = data {
         if let downloadedImage = UIImage(data: data) {
             self?.imageCache.setObject(downloadedImage, forKey: NSString(string: (self!.modelUser?.avatar)!))
             self!.avatar.image = downloadedImage
                 }
             }
          }
       }).resume()
      }
    }
    func userConfig(){
        
        cacheImages()
        name.text = "Name:" + "" + (modelUser?.firstName)! + "" + (modelUser?.lastName)!
        email.text = "Email:" + "" + (modelUser?.email)!
        jobTitle.text = "Job Title:" + "" + (modelUser?.jobtitle)!
        favColour.text = "FavColor:" + "" + (modelUser?.favouriteColor)!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

}



