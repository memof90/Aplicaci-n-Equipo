//
//  CeldaEquipo.swift
//  AppTeams
//
//  Created by Memo Figueredo on 6/27/19.
//  Copyright © 2019 DeTodoUnPoquito. All rights reserved.
//

import UIKit

class CeldaEquipo: UITableViewCell {
    
    //MARK: conectores
    @IBOutlet weak var nombreEquipo: UILabel!
    
    @IBOutlet weak var fotoImagenEquipo: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
