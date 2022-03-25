//
//  ResultManager.swift
//  Demo
//
//  Created by Shivam Verma on 15/09/21.
//

import UIKit

class ResultManager: NSObject {
    static func getResult(forSearch searchStr:String, forQuery str:Options , completionBlock:@escaping (_ success : Bool,_ model:ResultResponse?) -> Void)
    {
        let nSearchStr = searchStr.replacingOccurrences(of: " ", with: "+")
        let urlStr = "https://itunes.apple.com/search?term=\(nSearchStr)&entity=\(str.getValForApi())"
        var request = URLRequest(url: URL(string:urlStr )!)
        request.httpMethod = "GET"
        let service = WebServiceWrapper(request: request)
        
        service.hitApi { data, error in
            if error == nil && data != nil
            {
                if var obj = try? JSONDecoder().decode(ResultResponse.self, from: data!)
                {
                    obj.responseType = str.rawValue
                    completionBlock(true,obj)
                }
                else
                {
                    completionBlock(false,nil)
                }
            }
            else
            {
                completionBlock(false,nil)
            }
        }
        
    }
}

struct ResultResponse:Decodable {
    var resultCount:Int
    var responseType:String?
    var results:[ResultModel]
}

