//
//  InitialPresenter.swift
//  Demo
//
//  Created by Shivam Verma on 25/03/22.
//

import UIKit

class InitialPresenter: NSObject {
    weak var view: InitialVCViewInputs!
    var interactor:InitialVcInteractor!
    var router:InitialRouterProtocol!

    init(view: InitialVCViewInputs, interactor:InitialVcInteractor, router:InitialRouterProtocol)
    {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension InitialPresenter:InitialVCViewOutputs
{
    func viewDidLoad() {
        view.configure()
    }
    
    func viewWillAppear(){
        view.configure()
    }
    
    func submitClicked(forSearch searchStr:String, forQuery arrayOfMediaType:[Options]){
        interactor.delegate = self
        if !Reachability.isConnectedToNetwork()
        {
            self.view.showAlert(msg: "Internet not available.")
            return
        }
        
        if arrayOfMediaType.isEmpty
        {
            self.view.showAlert(msg: "Please select media type")
            return
        }
        

        self.view.indicatorView(animate: true)
        self.interactor.getRsults(forSearch: searchStr, forQuery: arrayOfMediaType)
    }
    
    func searchMediaClicked(arrayOfMediaType:[Options])
    {
        self.router.moveToOptionList(arrayOfMediaType: arrayOfMediaType, from: view as! UIViewController)
    }
}

extension InitialPresenter:InitialVcInteractorOutputs
{
    func onSuccess(result: [ResultResponse]) {
        self.view.indicatorView(animate: false)
        self.router.moveToResultList(with: result, from: view as! InitialVC)
    }
    
    func onError(error: String) {
        self.view.indicatorView(animate: false)
        self.view.showAlert(msg: error)
    }    
}
