//
//  BestActorsCollectionViewCell.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
//

import UIKit

class BestActorsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivheart: UIImageView!
    @IBOutlet weak var ivheartFill: UIImageView!
    @IBOutlet weak var imageForProfile: UIImageView!
    @IBOutlet weak var lableActorName: UILabel!
    @IBOutlet weak var lableKnownForDepartment: UILabel!
    
    var delegate : ActorActionDelegate? = nil
    
    var data : ActorInfoResponse? {
        didSet {
            if let data = data {
                let name = data.name ?? "underfined"
                let profilePath = "\(AppConstants.basicImageURL)\(data.profilePath ?? "")"
                let department = data.knownForDepartment ?? "underfined"
                
                lableActorName.text = name
                imageForProfile.sd_setImage(with: URL(string: profilePath))
                lableKnownForDepartment.text = department
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initGestureRecognizers()
    }
    
    private func initGestureRecognizers(){
        
        let tapGestureForFavorite = UITapGestureRecognizer(target: self, action: #selector(onTapFavorite))
        ivheartFill.isUserInteractionEnabled = true
        ivheartFill.addGestureRecognizer(tapGestureForFavorite)
        
        let tapGestureForUnFavorite = UITapGestureRecognizer(target: self, action: #selector(onTapUnFavorite))
        ivheart.isUserInteractionEnabled = true
        ivheart.addGestureRecognizer(tapGestureForUnFavorite)
    }

    @objc func onTapFavorite(){
        ivheartFill.isHidden = true
        ivheart.isHidden = false
        delegate?.onTapFavorite(isFavorite: true)
    }
    
    @objc func onTapUnFavorite(){
        ivheart.isHidden = true
        ivheartFill.isHidden = false
        delegate?.onTapFavorite(isFavorite: false)
    }
}
