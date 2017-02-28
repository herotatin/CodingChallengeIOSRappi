//
//  Category.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Category : NSManagedObject {
    
    
    //Variable para identificar el nombre unico de esta categoria
    @NSManaged var name    :   String?
    
    //Variable que contiene la imagen de la actual categoria
    @NSManaged var image   :   UIImage?
    
    @NSManaged var id      :  String?
   
    func getCategoryFromJson(categoryDict : [String:Any]) {
    
        
        guard let id = categoryDict["im:id"] as? String,
            let label = categoryDict["label"] as? String
            
            else {
                return
        }
        
        self.id = id
        self.name = label
    }
    
}


