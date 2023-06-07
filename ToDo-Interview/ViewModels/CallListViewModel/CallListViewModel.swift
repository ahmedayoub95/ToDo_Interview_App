//
//  CallListViewModel.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//

import Foundation


class CallListViewModel: NSObject{
    
    static let manager = CallListViewModel()
    private var apiService: APIService?
    
    override init() {
        self.apiService = APIService()
    }
    
    func articleApiCall(completionHandler : @escaping(Result<[CallList], Error>)-> Void ) {

        self.apiService?.getList(requestUrl: BASEURL_CALL_LIST,resultType: [CallList].self, completionHandler: { response in
            
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
