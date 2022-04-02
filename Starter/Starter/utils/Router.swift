//
//  Router.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
//

import Foundation
import UIKit

enum StoryBoardName : String {
    case Main = "Main"
    case Authentication = "Authentication"
    case LaunchScreen = "LaunchScreen"
}

extension UIStoryboard {
    static func mainStoryBoard()->UIStoryboard {
        UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
    }
}

extension UIViewController {
    
    func navigateToMovieDetailViewController(movieId : Int,_ type : Content){
    
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.movieID = movieId
        vc.contentType = type
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }

    func navigateToPersonDetailViewController(personId : Int){
    
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: ActorDetailViewController.identifier) as? ActorDetailViewController else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        vc.personId = personId
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
    
    func navigateToMoreActorsViewController(data : ActorListResponse){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MoreActorsViewController.identifier) as? MoreActorsViewController else {return}
        vc.initData = data
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
    
    func navigateToMoreShowCasesViewController(data : MovieListResponse){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MoreShowCasesViewController.identifier) as? MoreShowCasesViewController else {return}
        vc.initData = data
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
    
    func navigateToSearchViewController(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: SearchViewController.identifier) as? SearchViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }
    
}
