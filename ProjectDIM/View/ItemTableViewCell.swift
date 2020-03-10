//
//  ItemTableViewCell.swift
//  ProjectDIM
//
//  Created by  on 04/03/2020.
//  Copyright © 2020 Yoan Vandevelde. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var cellDesc: UILabel!

    @IBOutlet weak var cellImage: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
   
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    
    override func prepareForReuse() {
        self.cellDesc.text = nil
        self.cellImage.image = nil
        self.cellTitle.text = nil
        self.releaseDate.text = nil
        
    }
    
}
