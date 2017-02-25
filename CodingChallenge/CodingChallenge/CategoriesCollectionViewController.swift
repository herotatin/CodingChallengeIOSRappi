//
//  AppsCategoryViewController.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit


/* 
 *View controller encargado de controlar la vista de categorias de aplicciones
 */
class CategoriesCollectionViewController: UIViewController {

    
    //Instancia del table view que muestra los datos en la vista
    
    @IBOutlet weak var categoriesCollection: UICollectionView!
    
    var categories : [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories.append(Category(name: "Musica"))
        categories.append(Category(name: "Musica 2"))
        categories.append(Category(name: "Musica 3"))
        categories.append(Category(name: "Musica 4"))
        categories.append(Category(name: "Musica 5"))
        


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
 *Manejo de los datos de la colleción de categorias
 */
extension CategoriesCollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]
        
        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        cell.labelNameCategory.text = category.name
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
