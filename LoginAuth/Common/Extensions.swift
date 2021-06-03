//
//  Extensions.swift
//  LoginAuth
//
//  Created by Mayur Susare on 03/06/21.
//

import Foundation
import UIKit

//MARK: - UIViewController
extension UIViewController {
     func showAlert(strMessage: String) {
        let alertVw =  UIAlertController.init(title: Configuration.title, message: strMessage, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
            alertVw.dismiss(animated: true, completion: nil)
        }
        alertVw.addAction(action)
        self.present(alertVw, animated: true, completion: nil)
    }
}
