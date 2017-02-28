//
//  NetworkService.swift
//  Top Apps
//
//  Created by Jose Omar Colorado Perez on 26/02/17.
//  Copyright © 2017 Jose Omar Colorado Perez. All rights reserved.
//

import UIKit
import SystemConfiguration


//Clase empleada para realizar diversas funciones relacionadas con la red
class NetworkService{
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: URL
    
    //Se crear
    init(url: URL) {
        self.url = url
    }
    
    
    //Función empleadas para descargar imagenes dada la URL
    typealias ImageDataHandler = ((Data) -> Void)
    
    func downloadImage(_ completion: @escaping ImageDataHandler)
    {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
                
            }
        })
        
        dataTask.resume()
    }

}

extension NetworkService
{
    
    //Metodo empleado para traer y luego mapear el JSON con los datos
    static func parseJSONFromData(_ jsonData: Data?) -> [String : AnyObject]?
    {
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                return jsonDictionary
                
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
    
    
    //Función que verifica si el dispositivo tiene una conexión a interner
    static func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}




