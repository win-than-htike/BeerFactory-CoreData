//
//  BeerTableViewCell.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/30/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ingredient: UILabel!
    @IBOutlet weak var hops: UILabel!
    @IBOutlet weak var malts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
