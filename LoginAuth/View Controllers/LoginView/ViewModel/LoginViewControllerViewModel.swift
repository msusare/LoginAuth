//
//  LoginViewControllerViewModel.swift
//  LoginAuth
//
//  Created by Mayur Susare on 03/06/21.
//

import Foundation

struct LoginViewControllerViewModel {

    /// Function to call login API and after successful response send to caller
    /// - Parameters:
    ///   - userID: UserID in String
    ///   - password: Password in String
    ///   - completionHandler: send the response to the caller
    func loginFromAPI(userID: String, password: String, completionHandler: @escaping (UserDetails?, URLResponse?, Error?) -> Void) {
        
        guard let loginUrl = URL(string: Configuration.loginURL) else {
            return
        }
        
        APIManager.login(url: loginUrl, userID: userID, password: password ) { (userDetails, response, error) in
            if (response as? HTTPURLResponse)?.statusCode != 200 || error != nil {
                completionHandler(nil, response, error)
            }
            
            if let userDetails = userDetails, userDetails.userID != nil, userDetails.password != nil {
                completionHandler(userDetails, response, error)
            }
            
            completionHandler(nil, response, error)
        }
    }
    
}
