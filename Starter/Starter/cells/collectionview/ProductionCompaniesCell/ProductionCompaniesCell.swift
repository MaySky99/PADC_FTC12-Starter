//
//  ProductionCompaniesCell.swift
//  Starter
//
//  Created by Cruise on 3/25/22.
//

import UIKit

class ProductionCompaniesCell: UICollectionViewCell {

    @IBOutlet weak var imageViewBackDrop : UIImageView!
    @IBOutlet weak var labelCompanyName : UILabel!
    
    var data : ProductionCompany? {
        didSet {
            if let data = data {
                let backdropPath = "\(AppConstants.basicImageURL)\(data.logoPath ?? "")"
                imageViewBackDrop.sd_setImage(with: URL(string: backdropPath))
                
                if data.logoPath == nil || data.logoPath!.isEmpty{
                    labelCompanyName.text = data.name
                }else {
                    labelCompanyName.text = ""
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
