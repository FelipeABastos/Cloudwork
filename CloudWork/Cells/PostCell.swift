//
//  CustomCell.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 16/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Kingfisher

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
        self.lblLikes?.text = "\(item.amountLikes ?? 0)"
        self.lblComments?.text = "\(item.amountComments ?? 0)"
        self.lblTwitter?.text = item.author.twitter
        
        if let imageURL = item.imageURL {
            self.imgPicture?.kf.setImage(with: URL.init(string: imageURL))
        }
        
        if let imageURL = item.author.pictureURL {
            self.imgAuthorPicture?.kf.setImage(with: URL.init(string: imageURL))
        }
    }
}

