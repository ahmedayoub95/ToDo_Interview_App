//
//  BuyListVC.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import UIKit

class BuyListVC: UIViewController {
    
    
    var buyList:[BuyList]?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var buyListTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        buyListTV.register(UINib(nibName: "BuyListCell", bundle: nil), forCellReuseIdentifier: "BuyListCell")
        self.setup()
        self.apiCall()
    }
    
    
    func setup(){
        
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        
        
        //Right bar items
        let editImage    = UIImage(systemName: "ellipsis.circle")!
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(self.didTapEditButton))
        navigationItem.rightBarButtonItem = editButton
        
    }
    //MARK: - Selectors
    @objc func didTapEditButton(sender: AnyObject){
        
    }
    
    //MARK: - API CALL
    
    func apiCall(){
        
        DispatchQueue.main.async { [self] in
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        BuyListViewModel.manager.articleApiCall { [self] resp in
            
            switch resp {
            case let .success(resp):
                buyList = resp
                buyListTV.delegate = self
                buyListTV.dataSource = self
                DispatchQueue.main.async { [self] in
                    buyListTV.reloadData()
                    activityIndicator.stopAnimating()
                }
                
            case let .failure(error):
                print(error)
                showAlert(msg: "", title: error.localizedDescription)
                break
                
            }
        }
    }
    
    func showAlert(msg:String,title:String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

    
}


//MARK: - EXTENSION
extension BuyListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyListCell", for: indexPath) as! BuyListCell
        
        let data = buyList?[indexPath.row]
        cell.nameLbl.text = "Name: \(data?.name ?? "OK")"
        cell.priceLbl.text = "Price: \(data?.price ?? 0)"
        cell.quantityLbl.text = "Quantity: \(data?.quantity ?? 0)"
        
        return cell
    }
    
    
    
}
