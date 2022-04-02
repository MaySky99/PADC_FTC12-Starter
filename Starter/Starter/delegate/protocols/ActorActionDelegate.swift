//
//  ActorActionDelegate.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
//

import Foundation

protocol ActorActionDelegate : AnyObject {
    func onTapFavorite(isFavorite:Bool)
}

protocol ActorItemDelegate : AnyObject{
    func onTapPerson(id : Int)
}

protocol ActorMoreDelegate : AnyObject {
    func onTapActorMore(isClick : Bool, data : ActorListResponse)
}
