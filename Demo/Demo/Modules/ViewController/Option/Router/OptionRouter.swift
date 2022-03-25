//
//  OptionRouter.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import Foundation
import UIKit

struct OptionRouterInput: Routable
{
    func push(from: UIViewController, arrayOfMediaType: [Options]) {
        let vc = getStoryBoard().instantiateViewController(withIdentifier: "OptionVC") as! OptionVC
        vc.selectedItems = arrayOfMediaType
        vc.presenter = OptionPresenter(view: vc, router: OptionRouterOutput(view: vc))
        from.navigationController?.pushViewController(vc, animated: true)
    }
}

struct OptionRouterOutput: Routable
{
    let view:UIViewController!
    init(view:UIViewController) {
        self.view = view
    }
    
    func pop(options: [Options]) {
        if let vc = view.navigationController?.viewControllers.last
        {
            let obj = vc as! InitialVC
            obj.arrayOfMediaType = options
        }
    }
}
