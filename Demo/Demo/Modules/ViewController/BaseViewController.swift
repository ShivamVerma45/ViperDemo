//
//  BaseViewController.swift
//  Demo
//
//  Created by Shivam Verma on 14/09/21.
//

import UIKit

class BaseViewController: UIViewController {
    let indicator = Indicator(text: "Fetching...")

    override func viewDidLoad() {
        self.view.addSubview(indicator)
        indicator.hide()
        super.viewDidLoad()
    }
    
    func addLoader()
    {
        indicator.show()
    }
    
    func removeLoader()
    {
        indicator.hide()
    }
    
    func alert(withTitle title:String, Message str:String , andSingleButtonText txt:String)
    {
        let alert = UIAlertController.init(title: title, message: str, preferredStyle: .alert)
        let act = UIAlertAction.init(title: txt, style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(act)
        self.present(alert, animated: true, completion: nil)
    }
}
