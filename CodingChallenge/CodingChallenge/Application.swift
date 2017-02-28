//
//  Application.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class Application : NSManagedObject{

    
    
    @NSManaged var name : String!
    @NSManaged var developer : String!
    @NSManaged var imageURL : String!
    @NSManaged var image : NSData?
    @NSManaged var summary : String!
    @NSManaged var category : String!
    
    
    func getAppFromJson(applicationDict: [String: Any]) {
        guard let name = applicationDict["im:name"] as? [String:String],
            let images = applicationDict["im:image"] as? [[String : Any]],
            let summ   = applicationDict["summary"] as? [String:String],
            let dev = applicationDict["im:artist"] as? [String : Any]
            
            else {
                return
        }
        
        
        let newCategory =   (applicationDict["category"] as! [String : Any])["attributes"] as! [ String : Any ]
        guard let idCategory = newCategory["im:id"] as? String
            
            
            else {
                return
        }
        
        let url = images[2]
        self.imageURL = url["label"] as! String!
        self.name = name["label"]!
        self.developer = dev["label"]! as! String
        self.summary = summ["label"]
        self.category = idCategory
        
    }
    

    
    
}


