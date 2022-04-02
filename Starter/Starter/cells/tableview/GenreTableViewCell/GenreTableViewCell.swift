//
//  GenreTableViewCell.swift
//  Starter
//
//  Created by Cruise on 2/11/22.
//

import UIKit
import Alamofire

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewGenre: UICollectionView!
    @IBOutlet weak var collectionViewMovie: UICollectionView!
    
    //data array for genre label name
    //let genreList = [GenreVO(name: "ACTION", isSelected: true),GenreVO(name: "DRAMA", isSelected: false),GenreVO(name: "COMEDY", isSelected: false),GenreVO(name: "CRIMINAL", isSelected: false),GenreVO(name: "ADVENTURE", isSelected: false),GenreVO(name: "BIOGRAPHY", isSelected: false)]
    
    weak var delegate : MovieItemDelegate? = nil
//    var serieDelegate : SerieItemDelegate? = nil
    
    var data : MovieDetailResponse?
    
    var genreList : [GenreVO]? {
        didSet {
            if let _ = genreList{
                collectionViewGenre.reloadData()
                
                genreList?.removeAll(where: { (genreVO) -> Bool in
                    let genreID = genreVO.id
                    
                    let results = movieListByGenre.filter { (key,value) -> Bool in
                        genreID == key
                    }
                    return results.count == 0
                })
            }
            onTapGenre(genreID: genreList?.first?.id ?? 0)
        }
    }
    
    var allMoviesAndSeries : [MovieResult] = [] {
        didSet {
            //computation
            allMoviesAndSeries.forEach { (movieSeries) in
                movieSeries.genreIDS?.forEach({ (genreId) in
                    let key = genreId // 12 -> nil
                    
                    /*
                     first time -> 12 -> nil -> [MovieResult]() -> 12 = [MovieResult]
                     second time -> 12 -> [MovieResult] -> .append(newMovieData)
                     third time ...
                     fourth time ...
                     nth time
                     */
                    if var _ = movieListByGenre[key] {
                        movieListByGenre[key]!.insert(movieSeries)
                    }else {
                        movieListByGenre[key] = [movieSeries]
                    }
                })
            }
            //debugPrint("allMoviesAndSeries.count : \(allMoviesAndSeries.count)")
            
            //onTapGenre(genreID: genreList?.first?.id ?? 0)
        }
    }
    
    
    private var selectedMovieList : [MovieResult] = []
    private var movieListByGenre : [Int : Set<MovieResult>] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // collectionViewGenre
        registerForCollectionViewGenre()
        
        registerForCollectionViewMovie()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func registerForCollectionViewGenre(){
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
        collectionViewGenre.registerForCell(identifier: GenreCollectionViewCell.identifier)
    }
    private func registerForCollectionViewMovie(){
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
        collectionViewMovie.registerForCell(identifier: PopularFlimsCollectionViewCell.identifier)
    }
    
}
extension GenreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewMovie {
            return selectedMovieList.count
        }
        return genreList?.count ?? 0 //number of items in genreList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewMovie {
            guard let cell = collectionView.dequeueCell(identifier: PopularFlimsCollectionViewCell.identifier, indexPath: indexPath) as? PopularFlimsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = selectedMovieList[indexPath.row]
            
            return cell
            
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreCollectionViewCell.self), for: indexPath) as? GenreCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = genreList?[indexPath.row]  //pass genreList in genreVO to data
            
            cell.onTapItem = { genreID in  // call onTapItem closure function
                self.onTapGenre(genreID: genreID)
            }
            return cell
        }
    }
    
    private func onTapGenre(genreID : Int) {
        self.genreList?.forEach{ genreVO in  // genreList update
            if genreID == genreVO.id {
                genreVO.isSelected = true
            }else{
                genreVO.isSelected = false
            }
        }
        let movieList = self.movieListByGenre[genreID] // [MovieResult]?
        self.selectedMovieList = movieList?.map{ $0 } ?? [MovieResult]()
        
        self.collectionViewGenre.reloadData() // reload collectionViewGenre
        self.collectionViewMovie.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewMovie {
            return CGSize(width: collectionView.frame.width/3.6 , height: collectionView.frame.height)
        }
        
        return CGSize(width: widthForString(text: genreList?[indexPath.row].name ?? "", font: UIFont(name: "Geeza Pro Regular", size: 14) ?? UIFont.systemFont(ofSize: 14))+40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // String width function and return cgFloat
    func widthForString(text:String, font:UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font : font] // NSFont
        let textSizes = text.size(withAttributes: fontAttributes)  // Font size
        return textSizes.width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewMovie {
            let item = selectedMovieList[indexPath.row]
            if let _ = item.originalTitle {
                delegate?.onTapMovie(id: item.id ?? -1, type: .tapMovie)
            }
            else {
                delegate?.onTapMovie(id: item.id ?? -1, type: .tapSerie)
            }
//            delegate?.onTapSerie(id: item.id ?? -1, type: .tapSerie)
//            serieDelegate?.onTapSerie(id: item.id ?? -1, type: .tapSerie)
        }
    }
}
