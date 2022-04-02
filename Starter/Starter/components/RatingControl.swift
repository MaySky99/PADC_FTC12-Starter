//
//  RatingControl.swift
//  Starter
//
//  Created by Cruise on 2/10/22.
//

import UIKit

class RatingControl: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var starSize : CGSize = CGSize(width: 50.0, height: 50.0){
        didSet{
            setUpButton()
            updateButtonRating()
        }
    }
    @IBInspectable var starCount : Int = 5{
        didSet{
            setUpButton()
            updateButtonRating()
        }
    }
    @IBInspectable var rating : Int = 3{
        didSet{
            updateButtonRating()
        }
    }
    
    var ratingButton = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
        updateButtonRating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
        updateButtonRating()
    }
    
    private func setUpButton(){
        
        clearExistingButton()
        for _ in 0..<starCount {
            
            let button = UIButton()
            
            button.setImage(UIImage(named: "filledStar"), for: .selected)
            button.setImage(UIImage(named: "emptyStar"), for: .normal)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            addArrangedSubview(button)
            button.isUserInteractionEnabled = false
            
            ratingButton.append(button)
        }
    }
    
    private func updateButtonRating(){
        for (index,button) in ratingButton.enumerated(){
            button.isSelected = index < rating
        }
    }
    
    private func clearExistingButton(){
        for button in ratingButton {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButton.removeAll()
    }
    
}
