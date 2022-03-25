//
//  InitialVcInteractor.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import UIKit

protocol InitialVcInteractorOutputs: AnyObject {
    func onSuccess(result: [ResultResponse])
    func onError(error: String)
}


class InitialVcInteractor: NSObject {
    
    weak var delegate:InitialVcInteractorOutputs?
    
    func getRsults(forSearch searchStr:String, forQuery arrayOfMediaType:[Options])
    {
        var  results:[ResultResponse] = Array()
        let group = DispatchGroup()
        for itm in arrayOfMediaType
        {
            group.enter()
            ResultManager.getResult(forSearch: searchStr, forQuery: itm) { [weak self] success, result in
                guard let _ = self else{
                    return
                }
                if success
                {
                    if let result = result
                    {
                        results.append(result)
                    }
                }
                else
                {
                    
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if !results.isEmpty
            {
                self.delegate?.onSuccess(result: results)
            }
            else
            {
                self.delegate?.onError(error: "Something Went Wrong")
            }
        }
    }
}
