//
//  FeedItemTableViewCell.swift
//  Index RSS
//
//  Created by Pap Csaba on 2019. 11. 04..
//  Copyright © 2019. Pap Csaba. All rights reserved.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {
    
    let itemTitle = UILabel()
//    @IBOutlet weak var itemDescription: UILabel!
//    @IBOutlet weak var itemImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(itemTitle)
        
        itemTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        itemTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
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
