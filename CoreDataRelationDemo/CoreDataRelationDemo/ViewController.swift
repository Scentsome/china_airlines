//
//  ViewController.swift
//  CoreDataRelationDemo
//
//  Created by Michael on 18/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CoreData

enum EntityName : String {
    case user = "User"
    case car = "Car"
}

class ViewController: UIViewController {
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func fetchData(_ sender: Any) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.user.rawValue)
        
        userFetch.fetchLimit = 2
        userFetch.predicate = NSPredicate(format: "name = %@ && email = %@", "Michael", "scentsome@gmail.com")
        userFetch.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let users = try managedContext.fetch(userFetch)
            let john: User = users.first as! User
            print("Email: \(john.email!)")
            let johnCars = john.cars?.allObjects as! [Car]
            
            for car in johnCars {
                print(car.model)
                print(car.year)
            }
            print("has \(johnCars.count)")
        } catch {
            print(error)
        }
        
    
        
        
        
        
        
        
        
        
    }
    
    @IBAction func fetchCars(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let carFetch = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.car.rawValue)
        var predicateForCars = NSPredicate(format: " model BEGINSWITH %@", "B")
        carFetch.predicate = predicateForCars
        do {
            let cars =  try managedContext.fetch(carFetch)
            print(cars.count)
            
            guard let rCars = cars as? [Car] else{return}
            for car in rCars {
                print(car.model, car.year)
            }
        }catch {
            print(error)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let userEntity = NSEntityDescription.entity(forEntityName: EntityName.user.rawValue, in:
            managedContext)!
        
//        var user  = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        var user:User = User(entity: userEntity, insertInto: managedContext)
        
//        user.setValue("John", forKey: "name")
//        user.setValue("john@test.com", forKey: "email")
        user.name = "Michael"
        user.email = "scentsome@gmail.com"
        
        
        
        let carEntity = NSEntityDescription.entity(forEntityName: "Car", in:
            managedContext)!
        
        let car1 = Car(entity: carEntity, insertInto: managedContext)
        car1.model = "Benz"
        car1.year = 1990
        
        user.addToCars(car1)
//        car1.onwer = user
//        car1.setValue("Audi TT", forKey: "model")
//        car1.setValue(2010, forKey: "year")
//        car1.setValue(user, forKey: "onwer")
        
        let car2 = Car(entity: carEntity, insertInto: managedContext)
        car2.setValue("BMW X6", forKey: "model")
        car2.setValue(2014, forKey: "year")
//        car2.setValue(user, forKey: "onwer")
        
        user.addToCars(car2)
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

