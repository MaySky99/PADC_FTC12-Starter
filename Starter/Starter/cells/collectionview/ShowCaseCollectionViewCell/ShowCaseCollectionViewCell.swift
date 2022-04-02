//
//  ShowCaseCollectionViewCell.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
//

import UIKit

class ShowCaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelContentTitle: UILabel!
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    @IBOutlet weak var labelReleasedDate: UILabel!

    var data : MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle ?? data.originalName
                let backdropPath = "\(AppConstants.basicImageURL)\(data.backdropPath ?? "")"
                let date = data.releaseDate ?? "underfined"
                
                labelContentTitle.text = title
                imageViewBackdrop.sd_setImage(with: URL(string: backdropPath))
                labelReleasedDate.text = date
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
