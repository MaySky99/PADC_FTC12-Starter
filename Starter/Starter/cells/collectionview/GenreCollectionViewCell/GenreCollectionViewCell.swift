//
//  GenreCollectionViewCell.swift
//  Starter
//
//  Created by Cruise on 2/11/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!  // outlet to take action and catch gesture
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var viewForOverlay: UIView!
    
    var onTapItem : ((Int)->Void) = {_ in} // closure
    
    // object for databind
    var data : GenreVO?=nil {
        // if value changed, viewForOverlay do hide or show
        didSet{
            if let genre = data{    // if data isn't nil
                lblGenre.text = genre.name.uppercased()          // label name
                (genre.isSelected ) ? (viewForOverlay.isHidden = false) :(viewForOverlay.isHidden = true)  // viewForOverlay turnary opeartor
            }
        }
    }
    // just like viewDidLoad in ViewController and When two views bind, start working
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // GestureRecognizer for containerView
        let tapGestureForContainer = UITapGestureRecognizer(target: self, action: #selector(didTapItem))
        containerView.isUserInteractionEnabled = true   // userInteraction
        containerView.addGestureRecognizer(tapGestureForContainer)
    }
    
    //objc function
    @objc func didTapItem(){
        onTapItem(data?.id ?? 0)  // check nil
    }
}
