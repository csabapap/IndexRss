//
//  FeedItemTableViewCell.swift
//  Index RSS
//
//  Created by Pap Csaba on 2019. 11. 04..
//  Copyright © 2019. Pap Csaba. All rights reserved.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
