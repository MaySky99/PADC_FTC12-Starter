//
//  MovieDetailViewController.swift
//  Starter
//
//  Created by Cruise on 2/6/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    //MARK: - IBOUTLET
    @IBOutlet weak var btnRateMovie: UIButton!
    @IBOutlet weak var ivBack: UIImageView!
    
    @IBOutlet weak var labelReleasedYear: UILabel!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var viewRatingCount: RatingControl!
    @IBOutlet weak var labelVoteCount: UILabel!
    @IBOutlet weak var labelAboutMovieTitle: UILabel!
    @IBOutlet weak var labelGenreCollectionString: UILabel!
    @IBOutlet weak var labelProductionCountriesString: UILabel!
    @IBOutlet weak var labelAboutMovieDescription: UILabel!
    @IBOutlet weak var labelAboutReleaseDate: UILabel!
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var collectionViewProductionCompanies: UICollectionView!
    @IBOutlet weak var collectionViewActors: UICollectionView!
    @IBOutlet weak var collectionViewSimilarContent: UICollectionView!
    
    @IBOutlet weak var heightForCollectionViewActors: NSLayoutConstraint!
    @IBOutlet weak var heightForCollectionViewSimilar: NSLayoutConstraint!

    //MARK: - PROPERTIES
//    private var objects = Array.init(repeating: "hello", count: 1000000)
    
    private let movieDetailModel : MovieDetailModel = MovieDetailModelImplementation.shared
    
    var movieID : Int = -1
    var contentType : Content?
    
    private var productionCompanies : [ProductionCompany]?
    private var casts : [MovieCast]?
    private var similarMoviesAndSeries : [MovieResult] = []
    private var movieTrailer : [MovieTrailer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        initView()
    }
    
    //MARK: - InitView
    private func initView() {
        registerForCollectionView()
        
        btnRateMovie.layer.borderColor = UIColor.white.cgColor
        btnRateMovie.layer.borderWidth = 2
        btnRateMovie.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
        if contentType == .tapMovie {
            fetchMovieDetailById(id: movieID)
        }
        else if contentType == .tapSerie{
            fetchSerieDetailById(id: movieID)
        }
        
        let itemWidth : CGFloat = 110
        let itemHeight : CGFloat = itemWidth * 1.5
        heightForCollectionViewActors.constant = itemHeight
        
        btnPlay.isHidden = true
        
    }
    
    //MARK: - Register
    private func registerForCollectionView(){
        
        collectionViewProductionCompanies.dataSource = self
        collectionViewProductionCompanies.delegate = self
        collectionViewProductionCompanies.registerForCell(identifier: ProductionCompaniesCell.identifier)
        collectionViewProductionCompanies.showsHorizontalScrollIndicator = false
        collectionViewProductionCompanies.showsVerticalScrollIndicator = false
        
        collectionViewActors.dataSource = self
        collectionViewActors.delegate = self
        collectionViewActors.registerForCell(identifier: BestActorsCollectionViewCell.identifier)
        collectionViewActors.showsHorizontalScrollIndicator = false
        collectionViewActors.showsVerticalScrollIndicator = false
        
        collectionViewSimilarContent.dataSource = self
        collectionViewSimilarContent.delegate = self
        collectionViewSimilarContent.registerForCell(identifier: PopularFlimsCollectionViewCell.identifier)
        collectionViewSimilarContent.showsHorizontalScrollIndicator = false
        collectionViewSimilarContent.showsVerticalScrollIndicator = false
    }
    
    private func initGestureRecognizers() {
        let tapGestureForBack = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(tapGestureForBack)
    }
    @objc func onTapBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - NetworkFunctionCall
    func fetchMovieDetailById(id : Int) {
        movieDetailModel.getMovieDetail(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                //bind data
                self.bindData(data: data)
                self.fetchMovieCreditById(id: id)
                self.fetchSimilarMovies(id: id)
                self.fetchMovieTrailer(id: id)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchSerieDetailById(id : Int) {
        movieDetailModel.getSerieDetail(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.bindSerieData(data: data)
                self.fetchSerieCreditById(id: id)
                self.fetchSimilarSeries(id: id)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchMovieCreditById(id : Int) {
        movieDetailModel.getMovieCredit(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                //MovieCredit
                self.casts = data.cast ?? [MovieCast]()
                self.collectionViewActors.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchSerieCreditById(id : Int) {
        movieDetailModel.getSerieCredit(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                //SerieCredit
                self.casts = data.cast ?? [MovieCast]()
                self.collectionViewActors.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchSimilarMovies(id : Int) {
        movieDetailModel.getSimilarMovies(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.similarMoviesAndSeries = data.results ?? [MovieResult]()
                self.collectionViewSimilarContent.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchSimilarSeries(id : Int) {
        movieDetailModel.getSimilarSeries(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.similarMoviesAndSeries = data.results ?? [MovieResult]()
                self.collectionViewSimilarContent.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchMovieTrailer(id : Int) {
        movieDetailModel.getMovieTrailerVideo(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.movieTrailer = data.results ?? [MovieTrailer]()
                self.btnPlay.isHidden = self.movieTrailer.isEmpty
            case .failure(let message):
                print(message)
            }
        }
    }
    
    @IBAction func btnPlayTrailer(_ sender : Any){
        let item = movieTrailer.first
        let youtubeVideoId = item?.key
        let playerVC = YoutubePlayerViewController()
        playerVC.youtubeId = youtubeVideoId
        self.present(playerVC, animated: true, completion: nil)
    }
    
    //MARK: - BindData
    private func bindData(data: MovieDetail) {
        productionCompanies = data.productionCompanies
        collectionViewProductionCompanies.reloadData()
        
        let backdropPath = "\(AppConstants.basicImageURL)\(data.backdropPath ?? "")"
        imageViewMoviePoster.sd_setImage(with: URL(string: backdropPath))

        labelReleasedYear.text = String(data.releaseDate?.split(separator: "-")[0] ?? "")
        labelMovieTitle.text = data.originalTitle
        navigationItem.title = data.originalTitle
        
        labelMovieDescription.text = data.overview
        let runTimeHour = Int((data.runtime ?? 0) / 60)
        let runTimeMinute = (data.runtime ?? 0) % 60
        labelDuration.text = "\(runTimeHour) hr \(runTimeMinute) min"
        labelRating.text = "\(data.voteAverage ?? 0.0)"
        viewRatingCount.rating = Int((data.voteAverage ?? 0.0) * 0.5)
        labelVoteCount.text = "\(data.voteCount ?? 0) Votes"
        labelAboutMovieTitle.text = data.originalTitle

        var genreListString = ""
        data.genres.forEach({ item in
            genreListString += "\(item.name), "
        })
        labelGenreCollectionString.text = genreListString
        if labelGenreCollectionString.text != "" {
            labelGenreCollectionString.text?.removeLast()
            labelGenreCollectionString.text?.removeLast()
        }

        var countryListString = ""
        data.productionCountries.forEach({ item in
            countryListString += "\(item.name ?? ""), "
        })
        labelProductionCountriesString.text = countryListString
        if labelProductionCountriesString.text != "" {
            labelProductionCountriesString.text?.removeLast()
            labelProductionCountriesString.text?.removeLast()
        }

        labelAboutMovieDescription.text = data.overview
        labelAboutReleaseDate.text = data.releaseDate
    }
    
    private func bindSerieData(data: SerieDetail) {
        productionCompanies = data.productionCompanies
        collectionViewProductionCompanies.reloadData()
        
        let backdropPath = "\(AppConstants.basicImageURL)\(data.backdropPath ?? "")"
        imageViewMoviePoster.sd_setImage(with: URL(string: backdropPath))

        labelReleasedYear.text = String(data.releaseDate?.split(separator: "-")[0] ?? "")
        labelMovieTitle.text = data.originalName
        navigationItem.title = data.originalName
        
        labelMovieDescription.text = data.overview
        let runTimeHour = Int((data.episodeRuntime?[0] ?? 0) / 60)
        let runTimeMinute = (data.episodeRuntime?[0] ?? 0) % 60
        labelDuration.text = "\(runTimeHour) hr \(runTimeMinute) min"
        labelRating.text = "\(data.voteAverage ?? 0.0)"
        viewRatingCount.rating = Int((data.voteAverage ?? 0.0) * 0.5)
        labelVoteCount.text = "\(data.voteCount ?? 0) Votes"
        labelAboutMovieTitle.text = data.originalName

        var genreListString = ""
        data.genres.forEach({ item in
            genreListString += "\(item.name), "
        })
        labelGenreCollectionString.text = genreListString
        if labelGenreCollectionString.text != "" {
            labelGenreCollectionString.text?.removeLast()
            labelGenreCollectionString.text?.removeLast()
        }

        var countryListString = ""
        data.productionCountries.forEach({ item in
            countryListString += "\(item.name ?? ""), "
        })
        labelProductionCountriesString.text = countryListString
        if labelProductionCountriesString.text != "" {
            labelProductionCountriesString.text?.removeLast()
            labelProductionCountriesString.text?.removeLast()
        }

        labelAboutMovieDescription.text = data.overview
        labelAboutReleaseDate.text = data.releaseDate
    }

}

//MARK: - DATASOURCE, DELEGATE
extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewProductionCompanies {
            return productionCompanies?.count ?? 0
        }
        else if collectionView == collectionViewActors {
            return casts?.count ?? 0
        }
        else if collectionView == collectionViewSimilarContent {
            return similarMoviesAndSeries.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewProductionCompanies {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductionCompaniesCell.self), for: indexPath) as? ProductionCompaniesCell else {
                return UICollectionViewCell()
            }
            cell.data = productionCompanies?[indexPath.row]
            return cell
        }
        else if collectionView == collectionViewActors {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorsCollectionViewCell.self), for: indexPath) as? BestActorsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let item = casts?[indexPath.row]
            cell.data = item?.covertToActorInfoResponse()
            return cell
        }
        else if collectionView == collectionViewSimilarContent{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFlimsCollectionViewCell.self), for: indexPath) as? PopularFlimsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = similarMoviesAndSeries[indexPath.row]
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewProductionCompanies {
            let itemWidth : CGFloat = collectionViewProductionCompanies.frame.height
            let itemHeight = itemWidth
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else if collectionView == collectionViewActors {
            let itemWidth : CGFloat = 110
            let itemHeight : CGFloat = itemWidth * 1.5
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else if collectionView == collectionViewSimilarContent {
            let itemWidth : CGFloat = 110
            let itemHeight : CGFloat = collectionViewSimilarContent.frame.height
            return CGSize(width: itemWidth, height: itemHeight)
        }
        else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewActors {
            let item = casts?[indexPath.row]
            navigateToPersonDetailViewController(personId: item?.id ?? -1)
        }
        else if collectionView == collectionViewSimilarContent {
            let item = similarMoviesAndSeries[indexPath.row]
            if let _ = item.originalTitle {
                navigateToMovieDetailViewController(movieId: item.id ?? -1, .tapMovie)
            }
            else {
                navigateToMovieDetailViewController(movieId: item.id ?? -1, .tapSerie)
            }
        }
    }
}
