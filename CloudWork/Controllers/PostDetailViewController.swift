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
