//
//  HomeViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 12/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var lblWelcomeMessage: UILabel?
    
    @IBOutlet var btnBackToLoginButton: UIButton?
    
    let defaults = UserDefaults.standard
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userName = Session.get(){
        
            lblWelcomeMessage?.text = "Hello" + " " + userName[Constants.Key.userName]!
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction private func backToLogin (){
        
        let alert = UIAlertController(title: "Do you want to logout?",
                                      message: "",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default,
                                      handler: {action in
                                        let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginView") as! LoginViewController
                                        self.present(loginVC, animated: true, completion: nil)
                                        Session.logout()
        }))
        
        alert.addAction(UIAlertAction(title: "No",
                                      style: .default,
                                      handler: nil))
        
        self.present(alert, animated: true)
    }
}
