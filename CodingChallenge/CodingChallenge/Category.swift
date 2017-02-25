//
//  Category.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import Foundation
import UIKit

class Category : NSObject{
    
    
    //Variable para identificar el nombre unico de esta categoria
    var name    :   String!
    
    //Variable que contiene la imagen de la actual categoria
    var image   :   UIImage!
    
    
    //Constructor basico de la clase categoria
    init(name : String) {
        self.name   =   name
        //self.image  =   image
    }
    
}
