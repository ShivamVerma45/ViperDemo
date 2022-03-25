//
//  InitialRouter.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import UIKit

protocol Routable
{
    func getStoryBoard() -> UIStoryboard
}

extension Routable
{
    func getStoryBoard() -> UIStoryboard
    {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
}

protocol InitialRouterProtocol:AnyObject, Routable
{
    func moveToOptionList(arrayOfMediaType:[Options], from viewController:UIViewController)
    func moveToResultList(with result:[ResultResponse], from viewController:UIViewController)
}

class InitialRouter: InitialRouterProtocol {
    
    func moveToOptionList(arrayOfMediaType:[Options] ,from viewController:UIViewController) {
        OptionRouterInput().push(from: viewController, arrayOfMediaType: arrayOfMediaType)
    }
    
    func moveToResultList(with result: [ResultResponse], from viewController: UIViewController) {
        ResultRouterInput().push(from: viewController, results: result)
    }
    
    weak var delegate:InitialRouterProtocol?
    
    
}
