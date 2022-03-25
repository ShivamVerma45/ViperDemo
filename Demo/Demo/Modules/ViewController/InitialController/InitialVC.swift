//
//  InitialVC.swift
//  Demo
//
//  Created by Shivam Verma on 14/09/21.
//

import UIKit

protocol InitialVCViewInputs: AnyObject {
    func configure()
    func indicatorView(animate: Bool)
    func showAlert(msg:String)
}

protocol InitialVCViewOutputs: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func submitClicked(forSearch searchStr:String, forQuery arrayOfMediaType:[Options])
    func searchMediaClicked(arrayOfMediaType:[Options])
}


class InitialVC: BaseViewController {
    
    var presenter: InitialVCViewOutputs?
    @IBOutlet weak var lblSelectedMediaType: UILabel!
    @IBOutlet weak var txtFld: UITextField!
    var arrayOfMediaType:[Options] = [.musicVideo]
    var router = InitialRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = InitialPresenter(view: self, interactor: InitialVcInteractor(), router: InitialRouter())
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @IBAction func searchMediaType(_ sender: Any) {
        presenter?.searchMediaClicked(arrayOfMediaType: arrayOfMediaType)
    }
    
    @IBAction func actOnSubmit(_ sender: Any) {
        self.view.endEditing(true)
        presenter?.submitClicked(forSearch: txtFld.text!, forQuery: arrayOfMediaType)
    }
}

extension InitialVC:InitialVCViewInputs
{
    
    func showAlert(msg:String)
    {
        let aler = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let act = UIAlertAction.init(title: "Ok", style: .default) { action in
            aler.dismiss(animated: true)
        }
        
        aler.addAction(act)
        self.present(aler, animated: true)
    }
    
    func configure() {
        txtFld.delegate = self
        var str = ""
        for itm in arrayOfMediaType
        {
            if itm == arrayOfMediaType.first
            {
                str = itm.rawValue
            }
            else
            {
                str = str + ", \(itm.rawValue)"
            }
        }
        
        lblSelectedMediaType.text = str
    }
    
    func indicatorView(animate: Bool) {
        if animate
        {
            self.addLoader()
        }
        else
        {
            DispatchQueue.main.async {
                self.removeLoader()
            }
        }
    }
}


extension InitialVC : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
