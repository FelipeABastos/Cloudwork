//
//  RegisterViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 11/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import RKDropdownAlert

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageAvatar: UIImageView!

    var imagePicker: ImagePicker!
    
    @IBOutlet var txtName: UITextField?
    @IBOutlet var txtEmail: UITextField?
    @IBOutlet var txtPasswordOne: UITextField?
    @IBOutlet var txtPasswordTwo: UITextField?
    @IBOutlet var txtTwitter: UITextField?
    
    
    
    @IBOutlet var btnAvatar: UIButton?
    
    @IBOutlet var svScrollView: UIScrollView?
    
    @IBOutlet var btnRegister: UIButton?
    
    @IBOutlet var vwUnderlineName: UIView?
    @IBOutlet var vwUnderlineEmailRegister: UIView?
    @IBOutlet var vwUnderlinePasswordOne: UIView?
    @IBOutlet var vwUnderlinePasswordTwo: UIView?
    @IBOutlet var vwUnderlineTwitter: UIView?
    @IBOutlet var vwCloud: UIView?
    
    @IBOutlet var constraintAlignCenterName: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlineName: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterEmail: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlineEmail: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterPasswordOne: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlinePasswordOne: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterPasswordTwo: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlinePasswordTwo: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterRegisterButton: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterTwitter: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterUnderlineTwitter: NSLayoutConstraint?
    @IBOutlet var constraintAlignCenterAvatar: NSLayoutConstraint?
    
    let defaults = UserDefaults.standard
    
    //---------------------------------------------------------------------------------------------
    //  MARK: - UIViewController
    //---------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideForms()
        
        self.centerConstraints()
        
        self.animateCloud()
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.svScrollView?.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: 1200)
        
        self.animateForms()

        self.showForms()
        
    }
    
    //---------------------------------------------------------------------------------------------
    //  MARK: - Private Functions
    //---------------------------------------------------------------------------------------------
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction private func backToLogin() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func makeRegister(image: Data, name: String, email: String, twitter: String, password: String) {
        
        let parameters = ["name": name,
                          "email": email,
                          "twitter": "@\(twitter)",
                          "password": password] as [String : String]

        let URL = "http://albertolourenco.com.br/cloudwork/?action=userAdd"

        RequestManager.upload(endUrl: URL, imagedata: image, parameters: parameters) { (result) in
            if result == true {
                Util.showMessage(text: "Successfully registered", type: .success)
                self.btnRegister?.isEnabled = false
                self.dismiss(animated: true, completion: nil)
            }else{
                Util.showMessage(text: "Error", type: .error)
            }
        }
    }
    
    @IBAction private func registerButton() {
        
        guard let validatedName = txtName?.text, validatedName.isEmpty == false else {
            Util.showMessage(text: "Fill the name field", type: .warning)
            return
        }

        guard let validatedEmail = txtEmail?.text, validatedEmail.isEmpty == false else {
            Util.showMessage(text: "fill the email field", type: .warning)
            return
        }
        
        guard let validatedTwitter = txtTwitter?.text, validatedTwitter.isEmpty == false else {
            Util.showMessage(text: "Fill the twitter field", type: .warning)
            return
        }
        
        guard let validatedPassword = txtPasswordOne?.text, validatedPassword.isEmpty == false else {
            Util.showMessage(text: "Fill the password field", type: .warning)
            return
        }
        
        guard let passwordConfirm = txtPasswordTwo?.text, passwordConfirm.isEmpty == false else {
            Util.showMessage(text: "fill the password confirm", type: .warning)
            return
        }

        if Util.validate(email: validatedEmail) == false {
            Util.showMessage(text: "Fill the text field with a valid email.", type: .warning)
            return
        }
        
        if validatedPassword != passwordConfirm {
            Util.showMessage(text: "The passwords must be equals", type: .warning)
            return
        }
        
        guard let avatar = imageAvatar.image else {
            Util.showMessage(text: "You must select an image", type: .warning)
            return
        }
        
        let twitter = validatedTwitter.replacingOccurrences(of: "@", with: "")
        
        self.makeRegister(image: avatar.jpegData(compressionQuality: 1)!,
                          name: validatedName,
                          email: validatedEmail,
                          twitter: twitter,
                          password: validatedPassword)
    }

    private func passwordAreNotTheSame() {
        
        if let fieldPasswordOne = txtPasswordOne {
            Util.tintPlaceholder(field: fieldPasswordOne, color: .red)
        }
        if let fieldPasswordTwo = txtPasswordTwo {
            Util.tintPlaceholder(field: fieldPasswordTwo, color: .red)
        }
    }
    
    private func passwordAreNotTheSameAlert(){
        
        Util.showMessage(text: "Password must be equals!", type: .warning)
        
        self.vwUnderlinePasswordOne?.backgroundColor = UIColor.red
        self.vwUnderlinePasswordTwo?.backgroundColor = UIColor.red
        self.txtPasswordOne?.text = nil
        self.txtPasswordTwo?.text = nil
        self.txtPasswordOne?.becomeFirstResponder()
    }
    
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
    
    private func hideForms(){
        
        self.btnAvatar?.alpha = 0
        self.txtName?.alpha = 0
        self.vwUnderlineName?.alpha = 0
        self.txtEmail?.alpha = 0
        self.vwUnderlineEmailRegister?.alpha = 0
        self.txtPasswordOne?.alpha = 0
        self.vwUnderlinePasswordOne?.alpha = 0
        self.txtPasswordTwo?.alpha = 0
        self.btnRegister?.alpha = 0
        self.btnRegister?.alpha = 0
        self.txtTwitter?.alpha = 0
        self.vwUnderlineTwitter?.alpha = 0
    }
    
    private func showForms(){
        
        UIView.animate(withDuration: 1.5, animations: {self.btnAvatar?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtName?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlineName?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtEmail?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlineEmailRegister?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtPasswordOne?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlinePasswordOne?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtPasswordTwo?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlinePasswordTwo?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.btnRegister?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.txtTwitter?.alpha = 1})
        UIView.animate(withDuration: 1.5, animations: {self.vwUnderlineTwitter?.alpha = 1})
    }
    
    private func animateForms(){
        
        constraintAlignCenterAvatar?.constant = 0
        
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        
        constraintAlignCenterName?.constant = 0
        constraintAlignCenterUnderlineName?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.2,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterEmail?.constant = 0
        constraintAlignCenterUnderlineEmail?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.3,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterTwitter?.constant = 0
        constraintAlignCenterUnderlineTwitter?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.4,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)

        constraintAlignCenterPasswordOne?.constant = 0
        constraintAlignCenterUnderlinePasswordOne?.constant = 0

        UIView.animate(withDuration: 0.5,
                     delay: 0.5,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
        
        constraintAlignCenterPasswordTwo?.constant = 0
        constraintAlignCenterUnderlinePasswordTwo?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.6,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
                
        constraintAlignCenterRegisterButton?.constant = 0
        
        UIView.animate(withDuration: 0.5,
                     delay: 0.7,
                     options: [],
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func centerConstraints(){
       
        constraintAlignCenterAvatar?.constant -= view.bounds.width
        constraintAlignCenterName?.constant -= view.bounds.width
        constraintAlignCenterUnderlineName?.constant -= view.bounds.width
        constraintAlignCenterEmail?.constant -= view.bounds.width
        constraintAlignCenterUnderlineEmail?.constant -= view.bounds.width
        constraintAlignCenterPasswordOne?.constant -= view.bounds.width
        constraintAlignCenterUnderlinePasswordOne?.constant -= view.bounds.width
        constraintAlignCenterPasswordTwo?.constant -= view.bounds.width
        constraintAlignCenterUnderlinePasswordTwo?.constant -= view.bounds.width
        constraintAlignCenterRegisterButton?.constant -= view.bounds.width
        constraintAlignCenterTwitter?.constant -= view.bounds.width
        constraintAlignCenterUnderlineTwitter?.constant -= view.bounds.width
    }
    
    private func validatePassword() -> Bool {
        
        if self.txtPasswordOne?.text == self.txtPasswordTwo?.text {
            
            return true
        }else {
              
            self.passwordAreNotTheSame()
            self.passwordAreNotTheSameAlert()
            
            return false
        }
    }
    
    private func checkPasswordField() -> Bool {
        
        if self.txtPasswordOne?.text == "" {
            
            RKDropdownAlert.title(nil, message: "You need to fill the password field!", backgroundColor: UIColor.red, textColor: UIColor.white, time: 3)
            
            return false
        }else{
            return true
        }
    }
    
    private func checkNameField() -> Bool {
        
        if txtName == nil {
            
            return true
        }
        return false
    }
    
    private func configUI() {
        
        if let fieldName = txtName {
            Util.tintPlaceholder(field: fieldName, color: .white)
        }
        
        if let fieldEmail = txtEmail {
            Util.tintPlaceholder(field: fieldEmail, color: .white)
        }
        
        if let fieldTwitter = txtTwitter {
            Util.tintPlaceholder(field: fieldTwitter, color: .white)
        }
        
        if let fieldPasswordOne = txtPasswordOne {
            Util.tintPlaceholder(field: fieldPasswordOne, color: .white)
        }
        if let fieldPasswordTwo = txtPasswordTwo {
            Util.tintPlaceholder(field: fieldPasswordTwo, color: .white)
        }
    }
    
}

extension RegisterViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageAvatar.image = image
    }
}





