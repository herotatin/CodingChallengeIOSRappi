//
//  Store.swift
//  Top Apps
//
//  Created by Jose Omar Colorado Perez on 26/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//


//Clase principal, contenedora de todos los datos del tipo aplicación y las diversas categorias

import UIKit
import CoreData

class Store: NSObject, NSFetchedResultsControllerDelegate {
    
    
    //Listado de aplicaciones que la tienda posee
    var applications : [Application] = []
    
    //Listado de posible categorias para las aplicaciones
    var categories : [Category] = []
    
    var context : NSManagedObjectContext! = nil
    
    var fetchResultsController : NSFetchedResultsController<Application>!
    
    override init() {
        super.init()
        getContext()
    }
    
    /*Se obtiene el manejador de objeto desde el AppDelegate, para hacer
    inserciones de los datos del Json y eliminaciones en CoreData
     */
    func getContext() {
       
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            self.context = container.viewContext
            
        }
    }
    
    
    //Función que trae todos las aplicaciones y categorias guardadas en CoreData
    //Se usa solo en este caso, dado que los elementos son pocos
    func getCoreData(){
        if self.context != nil {
            
            
            //Petición de la clase Aplicación que trae todo los elementos de la Entidad
            let requestApp : NSFetchRequest<Application> = NSFetchRequest(entityName: "Application")
            //let request : NSFetchRequest<Application> = Application.fetchRequest()
            
            do{
                self.applications = try context.fetch(requestApp)
            }
            catch{
                print("Error al obtener aplicaciones : \(error)")
            }
            
            //Se traen los elementos de la entidad Category
            let requestCat :NSFetchRequest<Category> = NSFetchRequest(entityName: "Category")
            
            do{
                self.categories = try context.fetch(requestCat)
            }
            catch{
                print("Error al obtener categorias : \(error)")
            }
            
        }
    }
    
    //Función para guardar las peticiones contenidos en el NSManagedObjectContext
    func saveChangesInCoreData()  {
        do{
            try context.save()
        }
        catch{
            print("Error al grabar: \(error)")

        }
    }
    
    //Limpiado de todos los datos
    func clearActualCoreData(){
        
        //Se crean las peticiones para traer los datos de las entidades y se hace la petición
        let fetchCat = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let requestCat = NSBatchDeleteRequest(fetchRequest: fetchCat)
        
        let fetchApps = NSFetchRequest<NSFetchRequestResult>(entityName: "Application")
        let requestApps = NSBatchDeleteRequest(fetchRequest: fetchApps)
        do{
            try context.execute(requestCat)
            try context.execute(requestApps)
        }
        catch{
            print("Error al grabar: \(error)")
            
        }
    }
    
    //Función que crea aplicaciones a partir de cada una de las entradas del Json convertidas en diccionarios
    // entriesDict -> Diccionario donde se encuentran las entradas con la información del App y Categoria
    func downloadAllAplications(entriesDict : [[String : Any]]) {
        for case let entrie in entriesDict {
            
            //Se limpian los datos de CoreData, ya que llegan nuevos desde la conexión remota
            clearActualCoreData()
            
            //Se accede a una dircción especifica del diccionario donde esta contenida la categoria
            let newCategory =   (entrie["category"] as! [String : Any])["attributes"] as! [ String : Any ]
            
            //Se solicita crear una nueva categoria, antes de crear una nueva aplicación
            self.createNewCategory(categorieDict: newCategory)

            //Se crea el App a partir del NSManagedObjectContext
            let app = NSEntityDescription.insertNewObject(forEntityName: "Application", into: context ) as? Application
            app?.getAppFromJson(applicationDict : entrie)
        
            //Se valida que se haya mapeado un App
            if app?.name != nil {
                
                //Se agreaga a las aplicaciones
                self.applications.append(app!)
                
            }
            else{print("No es posible crear la nueva app")}
        }
        
        //Se solicita grabar todo en CoreData
        saveChangesInCoreData()
    }
    
    //Función empleada para crear una categoria
    // categorieDict -> Donde esta la definción de una categoria
    func createNewCategory(categorieDict : [String : Any]) {
        
        let categorie = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as? Category
        categorie?.getCategoryFromJson(categoryDict : categorieDict)
        
        
        //Se verifica la creación de la nueva categoria
        if categorie?.id != nil {
            
            //Se verifica que la categoria no exista ya
            if !categories.contains(where: { $0.id == categorie?.id }) {
                self.categories.append(categorie!)
                
            }
            else{
                print("ya existe la categoria a agregar")
                context.delete(categorie!)
            }
        }
        else{print("No es posible crear la categoria")}
        
    }
    
    
    //Función usada para determinar las aplicaciones por Cateogia
    // idCategiry -> Identificador de la categoria de la cual se daran las Apps
    func getAppsByCategory(idCategory : String) -> [Application] {
        
        var appsByCat : [Application] = []
        
        for app in applications{
            if(app.category == idCategory){
                appsByCat.append(app)
            }
        }
        
        return appsByCat
    }
}
