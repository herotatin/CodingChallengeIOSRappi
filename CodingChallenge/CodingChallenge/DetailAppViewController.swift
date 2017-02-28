//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit

class DetailAppViewController: UIViewController {

    
    //Variable de la aplicación a mostrar
    var application : Application!
    
      //@IBOutlets
  
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDev: UILabel!
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var imageApp: UIImageView!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        labelSummary.text = application.summary
        labelDev.text = application.developer
        labelName.text = application.name
        
        if let thumbImage = application.imageURL {
            
            let netService = NetworkService(url: URL(string:thumbImage)!)
            netService.downloadImage({ (imageData) in
                let image = UIImage(data: imageData as Data)
                DispatchQueue.main.async {
                    self.imageApp.image = image
                }
            })
        }
        //Creando vista personalizada del navigationBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

