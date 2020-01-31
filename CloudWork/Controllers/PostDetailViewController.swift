//
//  DetailsViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 21/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Alamofire

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list: Array<Comment> = []
    var post: Post!
    
    @IBOutlet var tbPosts: UITableView!
    
    @IBOutlet var txtInsertComment: UITextField?
    @IBOutlet var vwCommentView: UIView?
    @IBOutlet var vwCommentSpace: UIView?
    
    let refresh = UIRefreshControl()
    
    @IBOutlet var constraintAlignBottomCommentView: NSLayoutConstraint?
    
    @IBOutlet var imgPicture: UIImageView?
    @IBOutlet var imgAuthorPicture: UIImageView?
    @IBOutlet var lblAuthorName: UILabel?
    @IBOutlet var lblTwitter: UILabel?
    @IBOutlet var lblTime: UILabel?
    @IBOutlet var lblText: UILabel?
    @IBOutlet var lblLikes: UILabel?
    @IBOutlet var lblComments: UILabel?
    @IBOutlet var btnLike: UIButton?
    @IBOutlet var vwBlankView: UIView?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let commentField = txtInsertComment {
            Util.tintPlaceholder(field: commentField, color: .darkGray)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        
        
        self.tbPosts.estimatedRowHeight = 44.0
        self.tbPosts.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        RequestManager.getPost(postId: post.id) { (post) in
            
            if let object = post {
                self.post = object
                self.list = object.comments
            }
            
            self.tbPosts.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tbPosts.alpha = 1
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.comments.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let comment = post.comments[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        cell.loadUI(item: comment)
        return cell
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction func addLike() {
        
        RequestManager.like(postID: post.id) { (result) in
            if result == true {
                self.btnLike?.setImage(#imageLiteral(resourceName: "LikedImage"), for: .normal)
                var like = self.post.amountLikes
                like = self.post.amountLikes + 1
                self.lblLikes?.text = "\(like ?? 0)"
                
            }else{
                return
            }
        }
    }
    
    @IBAction func addComment() {
        
        if let user = Session.get(), let userID = user[Constants.Key.userID], let postID = post.id {
            
            addCommentAPI(userID: userID,
                          postID: String(postID),
                          text: txtInsertComment?.text ?? "")
        }
        
        txtInsertComment?.text = ""
        self.view.endEditing(true)
        
        RequestManager.getPost(postId: post.id) { (post) in
            
            if let object = post {
                self.post = object
                self.list = object.comments
            }
            
            self.tbPosts.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tbPosts.alpha = 1
            }
        }
        
    }
    
    @objc private func addCommentAPI(userID: String, postID: String, text: String) {
        
        let parameters = ["id_user" : userID,
                          "id_post" : postID,
                          "text" : text] as [String : String]
        
        RequestManager.postComment(parameters: parameters) { (result) in
            if result == true{
                print("Comentado")
            }else{
                print("fail")
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.constraintAlignBottomCommentView?.constant = keyboardHeight
            
            UIView.animate(withDuration: 0.5,
                         animations: { [weak self] in
                          self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
            
            self.constraintAlignBottomCommentView?.constant = 0
            
            UIView.animate(withDuration: 1,
                         animations: { [weak self] in
                          self?.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func loadUI(){
        
        self.lblAuthorName?.text = post.author.name
        self.lblTwitter?.text = post.author.twitter
        self.lblTime?.text = post.time
        self.lblText?.text = post.text
        self.lblLikes?.text = "\(post.amountLikes ?? 0)"
        self.lblComments?.text = "\(post.amountComments ?? 0)"
        
        if let imageURL = post.imageURL {
            self.imgPicture?.kf.setImage(with: URL.init(string: imageURL))
        }
        
        if let imageURL = post.author.pictureURL {
            self.imgAuthorPicture?.kf.setImage(with: URL.init(string: imageURL))
        }
    }
    
    @IBAction private func backToHome() {
        self.dismiss(animated: true, completion: nil)
    }
}
