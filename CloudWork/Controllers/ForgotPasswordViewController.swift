//
//  ForgotPasswordViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet var txtEmailForgotPassword: UITextField?
    @IBOutlet var vwUnderlineForgotPassword: UIView?
    
    @IBOutlet var btnSendEmail: UIButton?
    
    @IBOutlet var lblInfo: UILabel?
    
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
        
    //---------------------------------------------------------------------------------------------
    //  MARK: - Animations Requirements
    //---------------------------------------------------------------------------------------------
        
        constraintAlignCenterInfo?.constant -= view.bounds.width
        constraintAlignCenterEmailField?.constant -= view.bounds.width
        constraintAlignCenterUnderlineEmail?.constant -= view.bounds.width
        constraintAlignCenterSendButton?.constant -= view.bounds.width
        
        self.lblInfo?.alpha = 0
        self.txtEmailForgotPassword?.alpha = 0
        self.vwUnderlineForgotPassword?.alpha = 0
        self.btnSendEmail?.alpha = 0
        
        self.animateCloud()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    //---------------------------------------------------------------------------------------------
    //  MARK: - Bounce Animations
    //---------------------------------------------------------------------------------------------
        
        constraintAlignCenterInfo?.constant = 0
        
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        
        constraintAlignCenterEmailField?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.2,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterUnderlineEmail?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.2,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterSendButton?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                    delay: 0.3,
                    options: [],
                    animations: { [weak self] in
                     self?.view.layoutIfNeeded()
        }, completion: nil)
        
    //---------------------------------------------------------------------------------------------
    //  MARK: - Fade In Animations
    //---------------------------------------------------------------------------------------------
        
        UIView.animate(withDuration: 1.5, animations: {self.lblInfo?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtEmailForgotPassword?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlineForgotPassword?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.btnSendEmail?.alpha = 1})
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        }
    
    
    //-----------------------------------------------------------------------
    //    MARK: Private Functions
    //-----------------------------------------------------------------------
    
    @IBAction private func backToLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func recover(){
        
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
    
    //---------------------------------------------------------------------------------------------
    //  MARK: - Cloud Animation
    //---------------------------------------------------------------------------------------------
    
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
