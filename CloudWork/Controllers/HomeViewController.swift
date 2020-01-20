//
//  TableViewController.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 16/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list: Array<Post> = []
    
    @IBOutlet var tbPosts: UITableView!
    @IBOutlet var vwCloud: UIView?
    @IBOutlet var lblWelcomeMessage: UILabel?
    
    let apiClient = APIClient()
    let repository = Repository(apiClient: APIClient())
    //-----------------------------------------------------------------------
    //  MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        repository.getPosts() { (result) in
            switch result {
            case .success(let items):
                self.list = items
                self.tbPosts.reloadData()
                UIView.animate(withDuration: 0.3) {
                    self.tbPosts.alpha = 1
                }
            case .failure(let error):
                print("\(self) retrive error get posts: \(error)")
            }
        }
    }
    
    //-----------------------------------------------------------------------
    //  MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let post: Post = list[indexPath.row]
        
        return (post.imageURL == nil) ? 200: 420
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post: Post = list[indexPath.row]
        
        let identifier: String = (post.imageURL == nil) ? "PostCell_Text" : "PostCell_Image"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PostCell
        cell.loadUI(item: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

