//
//  AplicationsViewController.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit

class ApplicationsCollectionViewController : UIViewController {

    @IBOutlet weak var appsCollection: UICollectionView!

    
    var apps : [Application] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apps.append(Application(name: "Aplica"))
        apps.append(Application(name: "Aplica"))
        apps.append(Application(name: "Aplica"))
        apps.append(Application(name: "Aplica"))
        apps.append(Application(name: "Aplica"))
        apps.append(Application(name: "Aplica"))
        
        
        //Ocultar todas las celdas que no tienen datos
//        self.tableViewApps.tableFooterView = UIView(frame : CGRect.zero)
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

/**
 *Manejo de los datos de la colección de apps
 */
extension ApplicationsCollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let app = apps[indexPath.row]
        
        let cell = appsCollection.dequeueReusableCell(withReuseIdentifier: "appCell", for: indexPath) as! AppCell
        
        cell.labelNameApp.text = app.name
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
