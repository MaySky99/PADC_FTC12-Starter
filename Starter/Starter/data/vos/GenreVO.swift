//
//  GenreVO.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
// 

import Foundation

class GenreVO {
    
    var id : Int = 0
    var name:String = "ACTION"   //Label name
    var isSelected:Bool = false  //For Overlay
    
    init(id : Int = 0, name:String,isSelected:Bool) {   //Construtor
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}
