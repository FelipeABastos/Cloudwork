//
//  AddPostViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 30/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import SZTextView

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var vwCloud: UIView?
    @IBOutlet var btnSelectImage: UIButton?
    @IBOutlet var imgImagePicked: UIImageView?
    @IBOutlet var txtPost: UITextView?
    
    var api: APIResponse!
    var user: User!
    
    var imagePicker: ImagePicker!
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateCloud()
        
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
    
    @IBAction private func addPost() {
        
        if let user = Session.get(), let userID = user[Constants.Key.userID]{
            
            addPostAPI(image: imgImagePicked?.image?.jpegData(compressionQuality: 1),
                       userId: userID,
                       text: txtPost?.text ?? "")
        }
    }
    
    private func addPostAPI(image: Data?, userId: String, text: String) {
        
        let parameters = ["id_user" : userId,
                          "text" : text] as [String : String]
        
        let URL = "http://albertolourenco.com.br/cloudwork/?action=postAdd"
        
        RequestManager.upload(endUrl: URL, imagedata: image, parameters: parameters) { (result) in
            if result == true {
                
                Util.showMessage(text: "Posted successfully", type: .success)
                self.dismiss(animated: true, completion: nil)
            }else{
                Util.showMessage(text: "Error", type: .error)
            }
        }
    }
    
    @IBAction func backToHome() {
        self.dismiss(animated: true, completion: nil)
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
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}

extension AddPostViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imgImagePicked!.image = image
    }
}
