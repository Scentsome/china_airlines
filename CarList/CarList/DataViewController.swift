//
//  DataViewController.swift
//  CarList
//
//  Created by Michael on 29/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CoreData

class DataViewController: UIViewController {
    @IBAction func addData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity =   NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!
        let car = NSManagedObject(entity: entity,insertInto: managedContext) as! Car
//        car.name = "Test"
//        car.price = 100
        car.setValue("Car", forKeyPath: "name")
        car.setValue(400, forKeyPath: "price")
        do {
            try managedContext.save()
//            cars.append(car)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func listDat(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Car")
        do {
            let cars = try managedContext.fetch(fetchRequest)
            print(cars)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
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
