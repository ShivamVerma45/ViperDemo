//
//  OptionPresenter.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import UIKit

class OptionPresenter: NSObject {
    weak var view: OptionVCInputs!
    var router:OptionRouterOutput!
    
    init(view: OptionVCInputs, router:OptionRouterOutput)
    {
        self.view = view
        self.router = router
    }
}

extension OptionPresenter:OptionVCOutputs
{
    func popWithSelectedItems(selectedItems: [Options]) {
        router.pop(options: selectedItems)
    }
    
    func viewDidLoad()
    {
        view.configure()
    }
}
