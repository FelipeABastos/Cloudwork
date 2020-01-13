//
//  ForgotPasswordViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet var vwUnderlineForgotPassword: UIView?
    @IBOutlet var txtEmailForgotPassword: UITextField?
    @IBOutlet var btnSendEmail: UIButton?
    @IBOutlet var lblTextField: UILabel?
    
    @IBOutlet var constraintAlignCenterInfo: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterEmailField: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterSendButton: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlineEmail: NSLayoutConstraint?

    @IBOutlet var vwCloud: UIView?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fieldEmail = txtEmailForgotPassword {
            Util.tintPlaceholder(field: fieldEmail, color: .white)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.animateCloud()
        
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
    
    @IBAction func backToLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func recover(){
        
        if let text = self.txtEmailForgotPassword?.text, text.isEmpty != true {
            
            if Util.validate(email: text) {
                //Email validated
                self.emailSent()
            }else{
                //Email invalid
                self.emailFieldIncorrectlyFilled()
            }
        }else{
            //Field is Empty
            self.emailFieldIsEmpty()
        }
    }

    private func emailSent() {
           
           let alert = UIAlertController(title: "Email successfully sent!",
                                         message: "Check your inbox and follow the steps to recover your password.",
                                         preferredStyle: .alert)
           
           alert.addAction(UIAlertAction(title: "Confirm",
                                         style: .default,
                                         handler: { action in
                                           self.backToLogin()
           }))
           
           self.present(alert, animated: true)
    }
       
    private func emailFieldIncorrectlyFilled(){
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Fill the text field with a valid email.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: { action in
                                        self.txtEmailForgotPassword?.text = nil
        }))
        
        self.present(alert, animated: true)
    }
    
    private func emailFieldIsEmpty() {
        
        let alert = UIAlertController(title: "Error!",
                                      message: "Fill the text field with an email!",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm",
                                      style: .default,
                                      handler: { action in
                                        self.txtEmailForgotPassword?.text = nil
        }))
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Animate
    private func animateCloud() {
    let options: UIView.AnimationOptions = [.curveEaseInOut,
                                            .repeat,
                                            .autoreverse]
        
        UIView.animate(withDuration: 2.0, delay: 0,
                       options: options,
                       animations: {[weak self] in
                        self?.vwCloud?.frame.size.height *= 0.90
                        self?.vwCloud?.frame.size.height *= 0.90
        }, completion: nil)
    }
}
