//
//  SearchViewController.swift
//  Starter
//
//  Created by Cruise on 3/31/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionViewResult: UICollectionView!
    @IBOutlet weak var collectionViewNotFound: UIView!
    private let searchBar = UISearchBar()
    
    private let searchModel : SearchModel = SearchModelImplementation.shared

    private var searchResult : [MovieResult] = []
    private var currentPage : Int = 1
    private var totalPages : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        
    }

    func initView() {
        setUpCollectionView()
        collectionViewNotFound.isHidden = true
        
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        navigationItem.titleView = searchBar
    }
    
    func setUpCollectionView(){
        collectionViewResult.dataSource = self
        collectionViewResult.delegate = self
        collectionViewResult.registerForCell(identifier: PopularFlimsCollectionViewCell.identifier)
        collectionViewResult.showsHorizontalScrollIndicator = false
        collectionViewResult.showsVerticalScrollIndicator = false
        collectionViewResult.contentInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        if let layout = collectionViewResult.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    func searchContent(page : Int, keyword : String) {
        let query = keyword.replacingOccurrences(of: " ", with: "")
        
        searchModel.getSearchMovieByKeyword(query: query, page: page) { [weak self] (result) in
            guard let self = self else { return}
            switch result {
            case .success(let data):
                if data.totalResults == 0 {
                    self.collectionViewResultIsHidden()
                }
                else if data.totalResults != 0 {
                    self.totalPages = data.totalPages ?? 1
                    self.searchResult.append(contentsOf: data.results ?? [MovieResult]())
                    self.collectionViewResult.reloadData()
                    self.collectionViewResult.isHidden = false
                }
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func collectionViewResultIsHidden() {
        collectionViewResult.isHidden = true
        collectionViewNotFound.isHidden = false
    }
    
}

extension SearchViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFlimsCollectionViewCell.self), for: indexPath) as? PopularFlimsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = searchResult[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isAtLastRow = indexPath.row == (searchResult.count - 1)
        let hasMorePages = currentPage < totalPages
        if isAtLastRow && hasMorePages {
            currentPage = currentPage + 1
            searchContent(page: currentPage, keyword: searchBar.text ?? "")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = collectionView.frame.width/3.6
        let itemHeight : CGFloat = (itemWidth * 1.5) + 80
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = searchResult[indexPath.row]
        if let _ = item.originalTitle {
            navigateToMovieDetailViewController(movieId: item.id ?? -1, .tapMovie)
        }
        else {
            navigateToMovieDetailViewController(movieId: item.id ?? -1, .tapSerie)
        }
    }
}

extension SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let data = searchBar.text {
            self.currentPage = 1
            self.totalPages = 1
            self.searchResult.removeAll()
            searchContent(page: currentPage, keyword: data)
        }
    }
}
