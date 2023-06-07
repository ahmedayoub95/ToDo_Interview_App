//
//  CallListVC.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import UIKit

class CallListVC: UIViewController {

    var callList:[CallList]?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var callListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        callListTV.register(UINib(nibName: "CallListCell", bundle: nil), forCellReuseIdentifier: "callListCell")
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
        CallListViewModel.manager.articleApiCall { [self] resp in
            
            switch resp {
            case let .success(resp):
                callList = resp
                callListTV.delegate = self
                callListTV.dataSource = self
                DispatchQueue.main.async { [self] in
                    callListTV.reloadData()
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
extension CallListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "callListCell", for: indexPath) as! CallListCell
        
        let data = callList?[indexPath.row]
        cell.nameLbl.text = "Name: \(data?.name ?? "" )"
        cell.numberLbl.text = "Number: \(data?.number ?? "")"

        return cell
    }
    
    
    
}
