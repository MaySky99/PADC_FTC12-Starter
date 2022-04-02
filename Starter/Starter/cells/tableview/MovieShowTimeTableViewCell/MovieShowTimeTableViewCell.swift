//
//  MovieShowTimeTableViewCell.swift
//  Starter
//
//  Created by Cruise on 2/11/22.
//

import UIKit

class MovieShowTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var viewForBackground: UIView!
    @IBOutlet weak var lblSeeMore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblSeeMore.underlineText(text: "SEE MORE")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
