//
//  ResultPresenter.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import UIKit

class ResultPresenter: NSObject {
    
    weak var view: ResultVCInputs!
    var router:ResultRouterInput!
    
    init(view: ResultVCInputs, router:ResultRouterInput)
    {
        self.view = view
        self.router = router
    }
}

extension ResultPresenter:ResultVCOutputs
{
    func changeUITypeClicled() {
        self.view.changeListIntoCollection()
    }
    
    func viewDidLoad() {
        self.view.configure()
    }
}
