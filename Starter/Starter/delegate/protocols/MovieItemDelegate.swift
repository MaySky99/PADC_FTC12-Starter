//
//  MovieItemDelegate.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
//

import Foundation

protocol MovieItemDelegate : AnyObject {
    func onTapMovie(id : Int, type : Content)
//    func onTapSerie(id : Int, type : Content)
}

protocol MovieMoreDelegate : AnyObject {
    func onTapShowCaseMore(isClick : Bool, data : MovieListResponse)
}
