//
//  WebServiceWrapper.swift
//  Demo
//
//  Created by Shivam Verma on 15/09/21.
//

import UIKit

class WebServiceWrapper: NSObject {
    let session = URLSession.shared
    private var request:URLRequest
    
    init(request:URLRequest) {
        self.request = request
    }
    
    func hitApi(completionBlock: @escaping (_ data:Data?, _ error:Error?) -> Void)
    {
        self.session.dataTask(with: self.request) { data, response, error in
            
            if let error = error {
                completionBlock(nil, error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionBlock(nil, error)
                return
            }
            
            switch (httpResponse.statusCode)
            {
            case 200:
                if let data = data{
                    completionBlock(data,error)
                }
                else
                {
                    completionBlock(nil, error)
                }
                break
            default:
                completionBlock(nil, error)
                
            }
        }.resume()
    }
    
    static func downLoadImage(url:URL,completionBlock:@escaping(Data?)->Void)
    {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return
                completionBlock(nil)
            }
            completionBlock(data)
        }.resume()
    }
}
