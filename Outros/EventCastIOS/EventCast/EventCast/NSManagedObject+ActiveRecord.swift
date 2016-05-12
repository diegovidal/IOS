//
//  NSManagedObject+ActiveRecord.swift
//  EventCast
//
//  Created by Lucas Eduardo on 04/11/15.
//  Copyright © 2015 RNCDev. All rights reserved.
//

import Foundation
import CoreData
import Cent

/**
 ***** ACTIVE RECORD Pattern like methods for models *****
 
 Using a superclass allows us to create a default init, with no args, to create a new instance regarding of saving it or not
 */
class CoreDataModel: NSManagedObject {
    
    var changed: Bool = false //tells if the element had any attribute changed during sync from server
    @NSManaged var identifier: String
    
    var context: NSManagedObjectContext {
        return self.context
    }
    
    static var context: NSManagedObjectContext {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
    }
    
    convenience init() {
        self.init(temporary: false)
    }
    
    convenience init(temporary: Bool) {
        let entityName = self.dynamicType.className
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: CoreDataModel.context)!
        
        let context: NSManagedObjectContext? = temporary ? nil : CoreDataModel.context
        self.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}


/**
 Using a protocol and it's extension allows us to create generic methods that are already typed, through the Self reserved word, to the final class that implements the protocol. In this way, we can avoid typecastings when returning anyobjects or explicit typing when using generics.
 */
protocol CoreDataActiveRecord {

    //init
    init(identifier: String, temporary: Bool)
    
    //Instance methods
    func save()
    func destroy()
    
    //static methods
    static func saveAll()
    static func all(orderBy: String?, ascending: Bool) -> [Self]
    static func findByIdentifier(identifier: String) -> Self?
    static func findOrCreateByIdentifier(identifier: String) -> Self
    
    //sync server methods
    static func syncLocalDBElement(local localElement: Self, fromServer serverElement: Self)
    static func syncLocalDBCollection(var local localCollection: [Self], fromServer serverCollection: [Self]) -> (syncCollection: [Self], changedElements: [Self], addedElements: [Self], removedElements: [Self])
}

extension CoreDataActiveRecord where Self: CoreDataModel {
    
    init(identifier: String, temporary: Bool = false) {
        self.init(temporary: temporary)
        self.identifier = identifier
    }
    
    /**
     Calls the save method for the default context. Be aware that, although this is an instance method, this will save everything changed in the current context.
     */
    func save() {
        Self.saveAll()
    }
    
    /**
     Removes the object from database
     */
    func destroy() {
        Self.context.deleteObject(self)
        Self.saveAll()
    }
    
    
    /**
     Calls the save method for the default context. Be aware that, although this is an instance method, this will save everything changed in the current context.
     */
    static func saveAll() {
        do {
            try self.context.save()
        } catch {
            debugPrint(error)
        }

    }
    
    /**
     Gets all instances of the model inside DB.
     */
    static func all(orderBy: String? = nil, ascending: Bool = true) -> [Self] {
        let fetchRequest = NSFetchRequest(entityName: self.className)
        
        if let orderBy = orderBy {
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: orderBy, ascending: ascending)]
        }
        
        return try! context.executeFetchRequest(fetchRequest) as! [Self]
    }
    
    /**
     Find and return the element of the passed id. Return nil if the element does not exists
     */
    static func findByIdentifier(identifier: String) -> Self? {
        
        guard identifier != "" else { return nil }
        
        let fetchRequest = NSFetchRequest(entityName: self.className)
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "identifier", identifier)
        return try! context.executeFetchRequest(fetchRequest).first() as? Self
    }
    
    /**
     Try to dind and return the element of the passed id. if such element does not exist, create a new one with the passed id.
     */
    static func findOrCreateByIdentifier(identifier: String) -> Self {
        
        if let element = Self.findByIdentifier(identifier) {
            return element
        }
        
        return Self.init(identifier: identifier)
    }
    
    /**
     This synchronizes a single element in memory, loaded originally from database, with a equivalent element freshly loaded from server.
     */
    static func syncLocalDBElement<T: CoreDataModel>(local localElement: T, fromServer serverElement: T) {

        for attrName in localElement.entity.attributesByName.keys {
            let oldValue = (localElement as CoreDataModel).valueForKey(attrName) as? NSObject
            let newValue = (serverElement as CoreDataModel).valueForKey(attrName) as? NSObject
          
            if let oldValue = oldValue, newValue = newValue where oldValue != newValue {
                localElement.changed = true
                (localElement as CoreDataModel).setValue(newValue, forKey: attrName)
            }
        }
        
//        for relationshipName in localElement.entity.relationshipsByName.keys {
//            
//            debugPrint(relationshipName)
//            
//            //TODO: and if relationship was set to nil?
//            if let localRelationshipToOne = (localElement as CoreDataModel).valueForKey(relationshipName) as? CoreDataModel, let serverRelationshipToOne = (serverElement as CoreDataModel).valueForKey(relationshipName) as? CoreDataModel {
//                
//                print("\n\nTO ONE!!:")
//                debugPrint(localRelationshipToOne)
//                self.syncLocalDBElement(local: localRelationshipToOne, fromServer: serverRelationshipToOne)
//                
//            } else if let localRelationshipToMany = (localElement as CoreDataModel).valueForKey(relationshipName) as? Set<CoreDataModel>, let serverRelationshipToMany = (localElement as CoreDataModel).valueForKey(relationshipName) as? Set<CoreDataModel> {
//                
//                print("\n\nTO MANY!!:")
//                debugPrint(localRelationshipToMany)
//                
//                let localCollection = Array(localRelationshipToMany) as! [Self]
//                let serverCollection = Array(serverRelationshipToMany) as! [Self]
//                
//                let result = Self.syncLocalDBCollection(local: localCollection, fromServer: serverCollection)
//                
//                let syncSet = Set(result.syncCollection)
//                (localElement as CoreDataModel).setValue(syncSet, forKey: relationshipName)
//            }
//            
//        }
    }
    
 
    /**
     This synchronizes a local array in memory, loaded originally from database, with a new array freshly loaded from server.
     */
    static func syncLocalDBCollection<T: CoreDataModel>(var local localCollection: [T], var fromServer serverCollection: [T]) -> (syncCollection: [T], changedElements: [T], addedElements: [T], removedElements: [T]) {
        
        var changedElements = [T]()
        var addedElements = [T]()
        var removedElements = [T]()
        
        //*** Update or remove elements ***
        for localElement in localCollection {
            
            let serverElement = serverCollection.filter{ $0.identifier == localElement.identifier }.first()
            if let serverElement = serverElement {
                
                //if element exists in server array, just sync its properties. Then, we need to remove the 'copy' from coredata
                self.syncLocalDBElement(local: localElement, fromServer: serverElement)
                
                if localElement.changed {
                    changedElements.append(localElement)
                }
                
                serverCollection.remove(serverElement)
                //serverElement.destroy()
            } else {
                
                //delete element locally if it's not in server array anymore
                localCollection.remove(localElement)
                removedElements.append(localElement)
            }
        }
        
        //*** Add new elements ***
        for serverElement in serverCollection {
            let localElement = localCollection.filter{ $0.identifier == serverElement.identifier }.first()
            
            //if server element does not exist locally, add it in the array
            if localElement == nil {
                localCollection.append(serverElement) //TODO: add this temporary guy in context
                addedElements.append(serverElement)
            }
        }
        
        return (syncCollection: localCollection, changedElements: changedElements, addedElements: addedElements, removedElements: removedElements)
    }
    
    //TODO: create merge context method, that checks for elements with same identifier and remove 
    
}


/**
 Used to get the class name as a String, to be used for the NSEntityDescription
 */
extension NSObject {
    public class var className: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    public var className: String {
        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
    }
}