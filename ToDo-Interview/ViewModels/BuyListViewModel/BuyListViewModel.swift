//
//  BuyListViewModel.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import Foundation


class BuyListViewModel: NSObject{
    
    static let manager = BuyListViewModel()
    private var apiService: APIService?
    
    override init() {
        self.apiService = APIService()
    }
    
    func articleApiCall(completionHandler : @escaping(Result<[BuyList], Error>)-> Void ) {

        self.apiService?.getList(requestUrl: BASEURL_BUY_LIST,resultType: [BuyList].self, completionHandler: { response in
            
            switch response {
            case .success(let response):
                print(response as Any)
                completionHandler(.success(response!))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        })
    }
}
