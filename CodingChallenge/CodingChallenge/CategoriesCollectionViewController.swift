//
//  AppsCategoryViewController.swift
//  CodingChallenge
//
//  Created by Jose Omar Colorado Perez on 25/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit
import CoreData


/* 
 *View controller encargado de controlar la vista de categorias de aplicciones
 */
class CategoriesCollectionViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let defaults = UserDefaults.standard

    
    
    //Instancia del table view que muestra los datos en la vista
    @IBOutlet weak var categoriesCollection: UICollectionView!
    
    
    //URL de acceso al JSon con la infirmación
    let url  = URL(string : "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json")
    
    //Clase contenedora de las aplicaciones y categorias
    var topStore : Store!
    
    //Semaforo para escuchar finalización de tareas
    var sema = DispatchSemaphore( value: 0 )
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Creando vista personalizada del navigationBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        
        //Iinicializando tienda
        self.topStore = Store()
        
        //Cargando entradas
        self.downloadAllEntries()
        
        //Esperando finalización de carga de entradas
        sema.wait()
        

        // Ordenamos alfabeticamente los arreglos
        self.topStore.categories = topStore.categories.sorted(by: { (cat1 , cat2) -> Bool in
            return cat1.name! < cat2.name!
        })
        
        // Do any additional setup after loading the view.
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Metodo encargado de traer todas las entradas contenidas en el Json o en CoreData
    func downloadAllEntries() {
        
        //Se verifica si hay conexión a internet
        if NetworkService.isInternetAvailable(){
            
            let task = URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
                if(error != nil){
                    
                    print(error.debugDescription)
                }
                else{
                    
                    //Parseaando el Json
                    let myJson = NetworkService.parseJSONFromData(data)
                    let optionalData = myJson?["feed"] as! [String : Any]
                    let entries =   optionalData["entry"] as! [[String : Any]]
                    self.topStore.downloadAllAplications(entriesDict: entries)
                    
                    
                }
                
                //Se envia la señal al semaforo de que se ha terminado esta tarea
                self.sema.signal()
            }
            
            //Se inicia la tarea con el Json
            task.resume()
        
           

        }
        else {
            
            
            //Se carga desde el CoreData los elementos que se
            //visualizaron la ultima vez
            topStore.getCoreData()
            self.sema.signal()

        }
        
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
    
    
    //Función encargada de definir el número de filas dentro de cada sección de la colección de categorias de apps
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return topStore.categories.count
    }
    
    
    //Función  de define las celdas de cada sección
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = topStore.categories[indexPath.row]
        

        
        let cell = categoriesCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        cell.labelNameCategory.text = category.name
        
        return cell
    }
    
    
    //Función para definir el número de secciones de la colección
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Pasando información entre vista, segun el segue activado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Pasando las aplicaciones por categoria
        if segue.identifier == "showAppsForCategory"{
            
            if let index = self.categoriesCollection.indexPath(for: sender as! UICollectionViewCell) {
                
                //Asignando los parametros de creación de la vista
                //Aplicaciones y categoria
                let desVC = segue.destination as! ApplicationsCollectionViewController
                desVC.apps = topStore.getAppsByCategory(idCategory: topStore.categories[index.row].id!)
                desVC.category = topStore.categories[index.row]
            }
        }
        
    }
    
    
}
