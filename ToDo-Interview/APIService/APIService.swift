//
//  APIService.swift
//  ToDo-Interview
//
//  Created by Ahmed on 6/7/23.
//


import Foundation
import Alamofire
import UIKit

let BASEURL_CALL_LIST = "https://my-json-server.typicode.com/imkhan334/demo-1/call"
let BASEURL_BUY_LIST = "https://my-json-server.typicode.com/imkhan334/demo-1/buy"
let BASEURL_SELL_LIST = ""


class APIService :  NSObject {
    
    static let servicesManager = APIService()
    

    func getList<T:Decodable>(requestUrl: String,resultType: T.Type, completionHandler:@escaping(Swift.Result<T?,Error>)-> Void) {
        
        AF.request(requestUrl, method: .get).response { response in
            
            //to get status code
            switch(response.result) {
            case .success(let JSON):
                let decoder = JSONDecoder()
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: JSON!, options: JSONSerialization.ReadingOptions())
                    let prettyData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let result = try decoder.decode(T.self, from: prettyData)
                    completionHandler(.success(result))
                    print(result)
                }
                catch let error {
                    debugPrint("error occured while decoding = \(error)")
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}

