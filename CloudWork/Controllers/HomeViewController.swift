//
//  TableViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 16/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list: Array<Post> = []
    var post: Post!
    var postCell: PostCell!
    let isChecked = false
    
    let refresh = UIRefreshControl()
    
    @IBOutlet var tbPosts: UITableView!
    @IBOutlet var vwCloud: UIView?
    @IBOutlet var lblWelcomeMessage: UILabel?
    
    //-----------------------------------------------------------------------
    //  MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh.addTarget(self, action: #selector(loadPosts), for: UIControl.Event.valueChanged)
        self.tbPosts.addSubview(refresh)
        
        self.tbPosts.alpha = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let userName = Session.get(){
            lblWelcomeMessage?.text = "Hello, " + userName[Constants.Key.userName]!
        }
        
        animateCloud()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadPosts()
        
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let post: Post = list[indexPath.row]
        
        return (post.imageURL.isEmpty) ? 200: 420
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post: Post = list[indexPath.row]
        
        let identifier: String = (post.imageURL.isEmpty) ? "PostCell_Text" : "PostCell_Image"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PostCell
        cell.loadUI(item: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post: Post = list[indexPath.row]
        
        let postDetail = self.storyboard?.instantiateViewController(identifier: "PostDetailView") as! PostDetailViewController
        postDetail.post = post
        self.present(postDetail, animated: true, completion: nil)
        
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Custom Methods
    //-----------------------------------------------------------------------
    
    @IBAction func showAddPost() {
        
        let addPostVC = self.storyboard?.instantiateViewController(identifier: "AddPostView") as! AddPostViewController
        
        self.present(addPostVC, animated: true, completion: nil)
    }
    
    @objc private func loadPosts() {
        
        RequestManager.getPosts { (posts) in
            
            self.list = posts
            UIView.animate(withDuration: 1.5) {
                self.tbPosts.alpha = 1
            }
            self.tbPosts.reloadData()
            self.refresh.endRefreshing()
        }
        
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
    
    @IBAction private func logout() {
        
        
        let alert = UIAlertController(title: "Do you want to logout?",
                                             message: "",
                                             preferredStyle: .alert)
               
                alert.addAction(UIAlertAction(title: "Yes",
                                             style: .default,
                                             handler: { action in
                                               self.dismiss(animated: true, completion: nil)
                                               Session.logout()
               }))
        
                alert.addAction(UIAlertAction(title: "No",
                                              style: .default,
                                              handler: nil))
                       
               self.present(alert, animated: true)
    }
}

