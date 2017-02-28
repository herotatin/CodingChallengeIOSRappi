//
//  AppCell.swift
//  Top Apps
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    
    
    
    
    //Referencia de la imagen de la celda, esta representa la imagen del app
    @IBOutlet weak var imageApp: UIImageView!
    
    //Referencia del label que muestra el titulo del app
    @IBOutlet weak var labelNameApp: UILabel!
    
    
    //Referencia al label que identifica al desarrollador del app
    @IBOutlet weak var labelDevApp: UILabel!
    
    var application : Application! {
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        self.labelNameApp.text  =   application.name
        self.labelDevApp.text   =   application.developer
        
        if let thumbImage = application.imageURL {
            
            let netService = NetworkService(url: URL(string:thumbImage)!)
            netService.downloadImage({ (imageData) in
                let image = UIImage(data: imageData as Data)
                DispatchQueue.main.async {
                    self.imageApp.image = image
                }
            })
        }
    }
}
