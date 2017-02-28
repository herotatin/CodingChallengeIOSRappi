//
//  AplicationsViewController.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit


/**
 *Clase encarga del manejo de la vista que muestra las apps por categoria
 */
class ApplicationsCollectionViewController : UIViewController {

    //Referencia de; viewCollection de apps
    @IBOutlet weak var appsCollection: UICollectionView!

    //Listado de aplicaciones para esta categoria
    var apps : [Application] = []
    
    //Cateogria a mostrar
    var category : Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = category.name
        //Esconder barra de navegación with Swip
       
        
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
    
    //Función encargada de definir el número de filas dentro de cada sección de la colección de apps
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    
    //Función  para definir las celdas por cada app
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let app = apps[indexPath.row]
        
        let cell = appsCollection.dequeueReusableCell(withReuseIdentifier: "appCell", for: indexPath) as! AppCell
        
        cell.application = app
        
        return cell
    }
    
    //Número de secciones dentro de la colección de apps
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Pasando información entre vista, segun el segue activado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Pasando la aplicación seleccionada
        
        if segue.identifier == "showDetailsApp"{
            if let index = self.appsCollection.indexPath(for: sender as! UICollectionViewCell) {
                
                let desVC = segue.destination as! DetailAppViewController
                desVC.application = apps[index.row]
            }
        }
        
        
    }
    

    
    
}
