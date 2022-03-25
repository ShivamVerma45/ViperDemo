//
//  ResultRouter.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import Foundation
import UIKit

struct ResultRouterInput: Routable
{
    func push(from: UIViewController, results: [ResultResponse]) {
        let vc = getStoryBoard().instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
        vc.result = results
        vc.presentor = ResultPresenter(view: vc, router: self)
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
