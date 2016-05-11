//
//  CarCloudKit.swift
//  CKONE
//
//  Created by Diego Vidal on 13/04/15.
//  Copyright (c) 2015 Diego Vidal. All rights reserved.
//

import Foundation
import CloudKit

class CarCloudKit: Car {
    
    var record: CKRecord
    
    var id: String? {
        return record.recordID.recordName
    }
    
    var modelName: String{
        get{
            return record.objectForKey("model") as! String
        }
        set{
            record.setObject(newValue, forKey: "model")
        }
    }
    
    var year: UInt{
        get{
            return record.objectForKey("year") as! UInt
        }
        set{
            record.setObject(newValue, forKey: "year")
        }
    }
    
    // MARK: Init
    
    init(modelName: String, year: UInt){
        
        record = CKRecord(recordType: "Car")
        
        self.modelName = modelName
        self.year = year
    }
    
    init(record: CKRecord){
        self.record = record
    }
    
    // MARK: CRUD
    
    class func create(modelSring: String, year: UInt, completionHandler: (success: Bool, carCL: CarCloudKit?) -> ()){
        
        let publicCloudDatabase = CarCloudKit.publicCloudDatabase()
        
        let carCloudKit = CarCloudKit(modelName: modelSring, year: year)
        
        publicCloudDatabase.saveRecord(carCloudKit.record, completionHandler: { (record, error) -> Void in
            if error == nil{
                println("Funfou!")
                carCloudKit.record = record
                completionHandler(success: true, carCL: carCloudKit)
            }
            else{
                println("Error: \(error)")
            }
        })
    }
    
    class func deleteByYear(year: UInt){
        let publicCloudDatabase = CarCloudKit.publicCloudDatabase()
        
        let query = CKQuery(recordType: "Car", predicate: NSPredicate(format: "year = \(year)"))
        
        // Para pegar todos os dados da tabela
        //let query = CKQuery(recordType: "Car", predicate: NSPredicate(value: true))
        
        publicCloudDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error == nil{
                println("Deu certo na Query")
                
                let carCloudsKits = results.map({ (car) -> CarCloudKit in
                    CarCloudKit(record: car as! CKRecord)
                })
                for car in carCloudsKits{
                    publicCloudDatabase.deleteRecordWithID(car.record.recordID!, completionHandler: { (record, error) -> Void in
                        if error == nil{
                            println("Deletou")
                        }
                        else{
                            println("Erro")
                        }
                    })
                }
                
               // completionHandler(success: true, carCL: carCloudsKits)
            }
            else{
               println("Deu erro na Query")
            }
        }
    }
    
    
    class func queryByYear(year: UInt, completionHandler: (success: Bool, carCL: [CarCloudKit]?) -> ()){
        let publicCloudDatabase = CarCloudKit.publicCloudDatabase()
        
        let query = CKQuery(recordType: "Car", predicate: NSPredicate(format: "year = \(year)"))
        
        // Para pegar todos os dados da tabela
        //let query = CKQuery(recordType: "Car", predicate: NSPredicate(value: true))
        
        publicCloudDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error == nil{
                let carCloudsKits = results.map({ (car) -> CarCloudKit in
                    CarCloudKit(record: car as! CKRecord)
                })
                
                completionHandler(success: true, carCL: carCloudsKits)
            }
            else{
                completionHandler(success: false, carCL: nil)
            }
        }
    }
    
    // MARK: Helper
    
    class func publicCloudDatabase() -> CKDatabase{
        let defaultContainer = CKContainer.defaultContainer()
        return defaultContainer.publicCloudDatabase
    }
}
