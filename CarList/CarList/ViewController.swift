//
//  ViewController.swift
//  CarList
//
//  Created by Michael on 29/03/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var cars: [NSManagedObject] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "New Car",message: "Add a new car",preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",style: .default) { [unowned self] action in
            guard let nameField = alert.textFields?.first,
                let nameToSave = nameField.text else {
                    print("name is empty")
                    return
            }
            guard let priceField = alert.textFields?[1],
                let priceToSave = priceField.text,
                let price = Int(priceToSave) else {
                    print("price is not good")
                    return
            }
//            self.cars.append((nameToSave,price))
            self.savaData(newData: (nameToSave,price))
                self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",style: .default)
        alert.addTextField()
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)

    }
    
    func savaData(newData:(name:String, price:Int)){
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =   NSEntityDescription.entity(forEntityName: "Car", in: managedContext)!
        let car = NSManagedObject(entity: entity,insertInto: managedContext)
        car.setValue(newData.name, forKeyPath: "name")
        car.setValue(newData.price, forKeyPath: "price")
        do {
            try managedContext.save()
            cars.append(car)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    @IBOutlet weak var addCar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Car")
        do {
            cars = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "CellID"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
//        cell?.textLabel?.text = cars[indexPath.row].name
        let car:NSManagedObject = cars[indexPath.row]
        cell?.textLabel?.text = car.value(forKey: "name") as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (action, view, handler) in
            let toDeleteObject = self.cars[indexPath.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(toDeleteObject)
            do {
                try managedContext.save()
                self.cars.remove(at: indexPath.row)
                
                let indexSet = IndexSet([0])
                self.tableView.reloadSections(indexSet, with: UITableViewRowAnimation.fade)
                print("Deleted object")
            }catch {
                print(error)
            }
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
