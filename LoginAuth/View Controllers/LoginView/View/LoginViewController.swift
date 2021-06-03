//
//  ViewController.swift
//  LoginAuth
//
//  Created by Mayur Susare on 03/06/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK:- Variable Declarations
    static let identifier       = "LoginViewController"
    private var model           = LoginViewControllerViewModel()
    private let networkLoader   = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)

    //MARK:- Outlets
    @IBOutlet weak var textFieldUserID: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    ///easy for localisaing the app and similar for the adding the ADA compatibility
    struct StringsConstants {
        static let AlertUserIDEnter = "Please Enter User ID"
        static let AlertPasswordEnter = "Please Enter Password"
        static let AlertAuthFailed = "Authentication failed please try again"
    }
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Netowrk Loader
    //Can be improved better UI
    private func showNetworkLoader() {
        DispatchQueue.main.async {
            self.networkLoader.frame = self.btnLogin.bounds
            self.btnLogin.addSubview(self.networkLoader)
            self.networkLoader.color = .white
            self.networkLoader.backgroundColor = .gray
            self.networkLoader.startAnimating()
        }
    }
    
    private func hideNetworkLoader() {
        DispatchQueue.main.async {
            self.networkLoader.removeFromSuperview()
            self.networkLoader.stopAnimating()
        }
    }
    
    //MARK:- Custom Methods
    @IBAction func loginClicked(_ sender: UIButton) {
        //Validate textField Input and send to Home screen
        if(self.validateInputData())
        {
            self.showNetworkLoader()
            model.loginFromAPI(userID: self.textFieldUserID.text ?? "", password: self.textFieldPassword.text ?? "") { (userDetails, response, error) in
                
                self.hideNetworkLoader()
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil  else {

                    DispatchQueue.main.async {
                        if error != nil {
                            self.showAlert(strMessage: error?.localizedDescription ?? "")
                        }
                        
                        if (response as? HTTPURLResponse)?.statusCode != 200 {
                            self.showAlert(strMessage: StringsConstants.AlertAuthFailed)
                        }
                    }
                    return
                }
                
                guard let userDetails = userDetails else {
                    return
                }
                
                DispatchQueue.main.async {
                    guard let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: HomeViewController.identifier) as? HomeViewController else {
                        return
                    }
                    
                    homeViewController.userDetails = userDetails
                    
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                }
            }
        }
        
    }
    
    //MARK: - Validate data
    //TODO: insted of alert on screen error message can be shown
    private func validateInputData() -> Bool {
        if self.textFieldUserID.text?.isEmpty ?? true {
            self.showAlert(strMessage: StringsConstants.AlertUserIDEnter)
        } else if self.textFieldPassword.text?.isEmpty ?? true{
            self.showAlert(strMessage: StringsConstants.AlertPasswordEnter)
        } else {
            return true
        }
        
        return false
    }

}

