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
    
    //-----------------------------------------------------------------------
    //  MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authorOne = Author(name: "Bruno Sena", image: "avatarTwo")
        
        let postOne = Post(text: "Maecenas eu lorem vel est efficitur commodo eu id mauris. Morbi metus nunc, ultrices quis egestas consequat, porta a purus. Vivamus ac ligula vel lorem tempor facilisis. Donec tempor eros at ex tristique luctus. Nam tempor cursus tortor, quis cursus leo accumsan eget. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi bibendum, risus ut ullamcorper iaculis, est leo maximus lacus, sed congue lorem elit id mi. Mauris sem diam, semper at orci in, tristique condimentum mauris. Fusce vestibulum lorem vel diam rhoncus auctor. Nullam dapibus quis augue in suscipit.",
                           image: nil,
                           time: "2 minutes ago.",
                           likes: 20,
                           comments: 12,
                           author: authorOne)
        
        let authorTwo = Author(name: "Alberto Lourenço", image: "avatarOne")
        
        let postTwo = Post(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id nunc id est ultrices egestas at ut tortor. Proin porta nibh vestibulum libero scelerisque lacinia. Suspendisse imperdiet ex et augue convallis fermentum.",
                           image: "imageOne",
                           time: "5 minutes ago.",
                           likes: 23,
                           comments: 18,
                           author: authorTwo)
        
        let authorThree = Author(name: "Hagi", image: "avatarFour")
        
        let postThree = Post(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id nunc id est ultrices egestas at ut tortor. Proin porta nibh vestibulum libero scelerisque lacinia. Suspendisse imperdiet ex et augue convallis fermentum.",
                           image: nil,
                           time: "13 hours ago.",
                           likes: 17,
                           comments: 25,
                           author: authorThree)
        
        let authorFour = Author(name: "Italia Amaral", image: "imageFive")
        
        let postFour = Post(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed id nunc id est ultrices egestas at ut tortor. Proin porta nibh vestibulum libero scelerisque lacinia. Suspendisse imperdiet ex et augue convallis fermentum.",
                           image: "ImageThree",
                           time: "14 hours ago.",
                           likes: 26,
                           comments: 22,
                           author: authorFour)
        
        list = [postTwo, postOne, postFour, postThree]
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
        
        self.tbPosts.reloadData()
    }
    
    //-----------------------------------------------------------------------
    //  MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let post: Post = list[indexPath.row]
        
        return (post.image == nil) ? 200: 420
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post: Post = list[indexPath.row]
        
        let identifier: String = (post.image == nil) ? "PostCell_Text" : "PostCell_Image"
        
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

