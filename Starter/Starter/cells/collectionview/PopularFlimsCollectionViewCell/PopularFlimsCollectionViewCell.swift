//
//  PopularFlimsCollectionViewCell.swift
//  Starter
//
//  Created by Cruise on 2/11/22.
//

import UIKit

class PopularFlimsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelContentTitle: UILabel!
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    @IBOutlet weak var ratingStar: RatingControl!
    @IBOutlet weak var labelrating: UILabel!
    
    var data : MovieResult? {
        didSet {
            if let data = data {
                let title = data.originalTitle ?? data.originalName
                let posterPath = "\(AppConstants.basicImageURL)\(data.posterPath ?? data.backdropPath ?? "")"
                
                labelContentTitle.text = title
                imageViewBackdrop.sd_setImage(with: URL(string: posterPath))
                
                let voteAverage = data.voteAverage ?? 0.0
                labelrating.text = String(format: "%.1f", voteAverage)
                ratingStar.starCount = Int(voteAverage * 0.5)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
