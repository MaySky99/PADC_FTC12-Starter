//
//  MovieViewController.swift
//  Starter
//
//  Created by Cruise on 2/10/22.
//

import UIKit

class MovieViewController: UIViewController {

    //MARK: - IBOUTLET
    @IBOutlet weak var tableViewMovie: UITableView!
    
    @IBAction func onClickSearch(_ sender: Any) {
        navigateToSearchViewController()
    }
    
    //MARK: - PROPERTIES
    private let movieModel : MovieModel = MovieModelImplementation.shared
    
    private var upcomingMovieList : MovieListResponse?
    private var popularMovieList : MovieListResponse?
    private var popularSerieList : MovieListResponse?
    private var genreMovieList : MovieGenreList?
    private var topRatedMovieList : MovieListResponse?
    private var popularPeopleList : ActorListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       initView()
    }
    
    //MARK: - InitView
    private func initView() {
        registerTableViewCell()
        
        if #available(iOS 14.0, *) {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "")
        } else {
            // Fallback on earlier versions
        }

        fetchUpcomingMovieList()
        fetchPopularMovieList()
        fetchPopularSerieList()
        fetchGenreMovieList()
        fetchTopRatedMovieList()
        fetchPopularPeople()
    }
    
    //MARK: - RegisterTableView
    private func registerTableViewCell(){
        
        tableViewMovie.dataSource = self
        tableViewMovie.registerForCell(identifier: MovieSliderTableViewCell.identifier)
        tableViewMovie.registerForCell(identifier: PopularFlimsTableViewCell.identifier)
        tableViewMovie.registerForCell(identifier: MovieShowTimeTableViewCell.identifier)
        tableViewMovie.registerForCell(identifier: GenreTableViewCell.identifier)
        tableViewMovie.registerForCell(identifier: ShowCaseTableViewCell.identifier)
        tableViewMovie.registerForCell(identifier: BestActorsTableViewCell.identifier)
        
    }
    
    //MARK: - NetworkFunctionCall
    func fetchUpcomingMovieList() {
        movieModel.getUpcomingMovieList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.upcomingMovieList = data
                
                //UI update
                self.tableViewMovie.reloadSections(IndexSet(integer: movieTypes.MOVIE_SLIDER.rawValue), with: .automatic)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func fetchPopularMovieList() {
        movieModel.getPopularMovieList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.popularMovieList = data
                
                //UI update
                self.tableViewMovie.reloadSections(IndexSet(integer: movieTypes.MOVIE_POPULAR.rawValue), with: .automatic)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func fetchPopularSerieList() {
        movieModel.getPopularSerieList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.popularSerieList = data
                
                //UI update
                self.tableViewMovie.reloadSections(IndexSet(integer: movieTypes.SERIE_POPULAR.rawValue), with: .automatic)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func fetchGenreMovieList() {
        movieModel.getGenreList { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.genreMovieList = data
                self.tableViewMovie.reloadSections(IndexSet(integer: movieTypes.MOVIE_GENRE.rawValue), with: .automatic)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func fetchTopRatedMovieList() {
        movieModel.getTopRatedMovieList(page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.topRatedMovieList = data
                
                //UI update
                self.tableViewMovie.reloadSections(IndexSet(integer: movieTypes.MOVIE_SHOWCASE.rawValue), with: .automatic)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func fetchPopularPeople() {
        movieModel.getPopularPeople(page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.popularPeopleList = data
                
                //UI update
                self.tableViewMovie.reloadSections(IndexSet(integer: movieTypes.MOVIE_ACTOR.rawValue), with: .automatic)
            case .failure(let message):
                print(message)
            }
        }
    }
    
    
    
}

//MARK: - TABLEVIEWDATASOURCE
extension MovieViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case movieTypes.MOVIE_SLIDER.rawValue:
            let cell = tableView.dequeueCell(identifier: MovieSliderTableViewCell.identifier, indexPath: indexPath) as MovieSliderTableViewCell            
            cell.delegate = self
            cell.data = upcomingMovieList
            return cell
            
        case movieTypes.MOVIE_POPULAR.rawValue:
            let cell =  tableView.dequeueCell(identifier: PopularFlimsTableViewCell.identifier, indexPath: indexPath) as PopularFlimsTableViewCell
            cell.delegate = self
            cell.data = popularMovieList
            cell.labelTitle.text = "popular_movies".uppercased()
            return cell
            
        case movieTypes.SERIE_POPULAR.rawValue:
            let cell =  tableView.dequeueCell(identifier: PopularFlimsTableViewCell.identifier, indexPath: indexPath) as PopularFlimsTableViewCell
            cell.delegate = self
            cell.data = popularSerieList
            cell.labelTitle.text = "popular_series".uppercased()
            return cell
            
        case movieTypes.MOVIE_SHOWTIME.rawValue:
            return tableView.dequeueCell(identifier: MovieShowTimeTableViewCell.identifier, indexPath: indexPath)
            
        case movieTypes.MOVIE_GENRE.rawValue:
            let cell = tableView.dequeueCell(identifier: GenreTableViewCell.identifier, indexPath: indexPath) as GenreTableViewCell
            
            var movieList : [MovieResult] = []
            movieList.append(contentsOf: upcomingMovieList?.results ?? [MovieResult]())
            movieList.append(contentsOf: popularSerieList?.results ?? [MovieResult]())
            movieList.append(contentsOf: popularMovieList?.results ?? [MovieResult]())
            cell.allMoviesAndSeries = movieList
            
            let resultData : [GenreVO]? = genreMovieList?.genres.map { movieGenre -> GenreVO in
                return movieGenre.convertToGenreVO()
            }
            resultData?.first?.isSelected = true
            cell.genreList = resultData
            
            cell.delegate = self
//            cell.serieDelegate = self
            return cell
            
        case movieTypes.MOVIE_SHOWCASE.rawValue:
            let cell = tableView.dequeueCell(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath) as ShowCaseTableViewCell
            cell.delegate = self
            cell.moreShowDelegate = self
            cell.data = topRatedMovieList
            return cell
            
        case movieTypes.MOVIE_ACTOR.rawValue:
            let cell = tableView.dequeueCell(identifier: BestActorsTableViewCell.identifier, indexPath: indexPath) as BestActorsTableViewCell
            cell.delegate = self
            cell.moreDelegate = self
            cell.data = popularPeopleList
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - DELEGATE
extension MovieViewController : MovieItemDelegate, MovieMoreDelegate, ActorItemDelegate, ActorMoreDelegate {
    
    func onTapMovie(id : Int, type : Content) {
        navigateToMovieDetailViewController(movieId: id, type)
    }
 
    func onTapPerson(id: Int) {
        navigateToPersonDetailViewController(personId: id)
    }
    
    func onTapActorMore(isClick: Bool,data : ActorListResponse) {
        print("isClick : \(isClick)")
        navigateToMoreActorsViewController(data: data)
    }
    
    func onTapShowCaseMore(isClick: Bool, data : MovieListResponse) {
        print("isClick : \(isClick)")
        navigateToMoreShowCasesViewController(data: data)
    }
    
}
