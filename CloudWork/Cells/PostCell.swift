//
//  CustomCell.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 16/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet var imgPicture: UIImageView?
    @IBOutlet var imgAuthorPicture: UIImageView?
    @IBOutlet var lblAuthorName: UILabel?
    @IBOutlet var lblTime: UILabel?
    @IBOutlet var lblText: UILabel?
    @IBOutlet var lblLikes: UILabel?
    @IBOutlet var lblComments: UILabel?
    @IBOutlet var btnLike: UIButton?
    @IBOutlet var vwBlankView: UIView?
    @IBOutlet var lblTwitter: UILabel?
    
    func loadUI(item: Post) {
        
        self.lblText?.text = item.text
        self.lblAuthorName?.text = item.author.name
        self.lblTime?.text = item.time
        self.lblLikes?.text = "\(item.likes ?? 0)"
        self.lblComments?.text = "\(item.comments ?? 0)"
        self.lblTwitter?.text = item.author.twitter
        
        self.imgPicture?.alpha = 0
        self.imgPicture?.image = nil
        
        DispatchQueue.global().async {
            if let imageURL = item.imageURL {
                let url:URL? = URL(string: imageURL)
                let data:Data? = try? Data(contentsOf : url!)
                let image = UIImage(data : data!)
                DispatchQueue.main.async {
                    self.imgPicture?.image = image
                    UIView.animate(withDuration: 0.3) {
                        self.imgPicture?.alpha = 1
                    }
                }
            }
        }
        
        self.imgAuthorPicture?.alpha = 0
        self.imgAuthorPicture?.image = nil
        
        DispatchQueue.global().async {
            if let imageURL = item.author.pictureURL {
                let url:URL? = URL(string: imageURL)
                let data:Data? = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imgAuthorPicture?.image = image
                    UIView.animate(withDuration: 0.3) {
                        self.imgAuthorPicture?.alpha = 1
                    }
                }
            }
        }
    }
}
