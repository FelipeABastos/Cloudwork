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
    
    func loadUI(item: Post) {
        
        self.lblText?.text = item.text
        self.lblAuthorName?.text = item.author.name
        self.lblTime?.text = item.time
        self.lblLikes?.text = "\(item.likes ?? 0)"
        self.lblComments?.text = "\(item.comments ?? 0)"
        
        if let imageName = item.author.image {
            self.imgAuthorPicture?.image = UIImage(named: imageName)
        }
        
        if let imageName = item.image {
            self.imgPicture?.image = UIImage(named: imageName)
        }
    }
}
