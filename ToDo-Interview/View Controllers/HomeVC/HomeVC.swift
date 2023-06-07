//
//  HomeVC.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    
    let productsData: [[String: Any]] = [
        [
            "id": 1,
            "name": "MacBook Pro",
            "price": 205000,
            "quantity": 1,
            "type": 1
        ],
        [
            "id": 2,
            "name": "iPad",
            "price": 20000,
            "quantity": 2,
            "type": 1
        ],
        [
            "id": 3,
            "name": "Power Bank",
            "price": 10000,
            "quantity": 4,
            "type": 1
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.createData()
    }
    
    @IBAction func callBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCallListVC", sender: self)
    }
    
    
    @IBAction func buyBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "goToBuyListVC", sender: self)
    }
    
    @IBAction func sellBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "goToSellListVC", sender: self)
    }
    
    
    
    
    
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "SellListEntity", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 3 data with loop
        
        for productData in productsData {
            
            let product = NSManagedObject(entity: userEntity, insertInto: managedContext)
            // Set the values for each property of the Product entity
            product.setValue(productData["id"], forKey: "id")
            product.setValue(productData["name"], forKey: "name")
            product.setValue(productData["price"], forKey: "price")
            product.setValue(productData["quantity"], forKey: "quantity")
            product.setValue(productData["type"], forKey: "type")
            
        }
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            print("SAVED.",managedContext)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
}
