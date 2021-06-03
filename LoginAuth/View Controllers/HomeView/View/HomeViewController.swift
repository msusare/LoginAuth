//
//  HomeViewController.swift
//  LoginAuth
//
//  Created by Mayur Susare on 03/06/21.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- Variables
    static let identifier = "HomeViewController"

    //MARK:- OUTLETS
    @IBOutlet weak var labelUserID: UILabel!
    
    //MARK:- String Constants
    struct StringConstants {
        static let title = "Home"
    }
    
    //MARK:- Internal Variable Declaration
    var userDetails: UserDetails?
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = StringConstants.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.labelUserID.text = userDetails?.userID ?? ""
    }

}
