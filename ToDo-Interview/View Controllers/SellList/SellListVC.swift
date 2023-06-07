//
//  SellListVC.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import UIKit
import CoreData

class SellListVC: UIViewController {
    
    var fetchedModels: [SellListModel]? = []
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDo_Interview")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var sellListTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [self] in
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        sellListTV.register(UINib(nibName: "BuyListCell", bundle: nil), forCellReuseIdentifier: "BuyListCell")
        let data = fetchSellListModelsFromCoreData()
        print(data)
        
        self.setup()
        
   
        
    }
    
    
    //MARK: - SETUP
    
    func setup(){
        
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        
        
        //Right bar items
        let editImage    = UIImage(systemName: "ellipsis.circle")!
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(self.didTapEditButton))
        navigationItem.rightBarButtonItem = editButton
        
        sellListTV.delegate = self
        sellListTV.dataSource = self
        
        DispatchQueue.main.async { [self] in
            sellListTV.reloadData()
            activityIndicator.stopAnimating()
        }
        
    }
    
    //MARK: - Selectors
    @objc func didTapEditButton(sender: AnyObject){
        
    }
    
    //MARK: - FETCH FROM CORE DATA
    
    func fetchSellListModelsFromCoreData() -> [SellListModel] {
        
        let fetchRequest: NSFetchRequest<SellListEntity> = SellListEntity.fetchRequest()
        do {
            let fetchedData = try managedContext.fetch(fetchRequest)
            
            fetchedModels = fetchedData.map { entity in
                return SellListModel(id: Int(entity.id),
                                     name: entity.name ?? "",
                                     price: Int(entity.price),
                                     quantity: Int(entity.quantity),
                                     type: Int(entity.type))
            }
        } catch {
            // Handle any errors
        }
        
        return fetchedModels!
    }
    
    
    //MARK: - ALERT
    
    func showAlert(msg:String,title:String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
}
//MARK: - EXTENSION
extension SellListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyListCell", for: indexPath) as! BuyListCell
        
        let data = fetchedModels?[indexPath.row]
        cell.nameLbl.text = "Name: \(data?.name ?? "OK")"
        cell.priceLbl.text = "Price: \(data?.price ?? 0)"
        cell.quantityLbl.text = "Quantity: \(data?.quantity ?? 0)"
        
        return cell
    }
    
    
    
}
