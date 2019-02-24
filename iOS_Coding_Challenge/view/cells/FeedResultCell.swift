//
//  AppleMusicCell.swift
//  iOS_Coding_Challenge
//
//  Created by Nika Kirkitadze on 2/24/19.
//  Copyright © 2019 organization. All rights reserved.
//

import UIKit
import SDWebImage

class FeedResultCell: UITableViewCell {
    
    var name: String?
    var artWorkURL: String?
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameLabel)
        self.addSubview(coverImageView)
        
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: self.coverImageView.rightAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
//        let margins = self.layoutMarginsGuide
//        nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 110).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let name = name {
            nameLabel.text = name
        }
        
        if let url = artWorkURL {
            coverImageView.sd_setImage(with: URL(string: url)!, placeholderImage: UIImage(named: "img_placeholder"))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
