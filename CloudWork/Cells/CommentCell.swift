//
//  CommentCell.swift
//  CloudWork
//
//  Created by Felipe Amorim Bastos on 21/01/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Kingfisher

class CommentCell: UITableViewCell {
    
    @IBOutlet var lblText: UILabel?
    @IBOutlet var lblTime: UILabel?
    @IBOutlet var lblAuthorName: UILabel?
    @IBOutlet var lblTwitter: UILabel?
    @IBOutlet var imgAuthorPicture: UIImageView?
    
    func loadUI(item:Comment){
        
        self.lblText?.text = item.text
        self.lblTime?.text = item.time
        self.lblAuthorName?.text = item.author.name
        self.lblTwitter?.text = item.author.twitter
        
        if let imageURL = item.author.pictureURL {
            self.imgAuthorPicture?.kf.setImage(with: URL.init(string: imageURL))
        }
        
        self.layoutIfNeeded()
    }
    
    
}
