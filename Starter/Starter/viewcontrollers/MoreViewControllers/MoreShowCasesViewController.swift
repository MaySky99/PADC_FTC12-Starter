//
//  MoreShowCasesViewController.swift
//  Starter
//
//  Created by Cruise on 3/30/22.
//

import UIKit

class MoreShowCasesViewController: UIViewController {

    @IBOutlet weak var collectionViewShowCases: UICollectionView!
    
    private let movieModel : MovieModel = MovieModelImplementation.shared

    var initData : MovieListResponse?
    private var currentPage : Int = 1
    private var totalPages : Int = 1
    
    private var data : [MovieResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpCollectionView()
        initState()
    }
    
    private func initState(){
        currentPage = initData?.page ?? 1
        totalPages = initData?.totalPages ?? 1
        
        data.append(contentsOf: initData?.results ?? [MovieResult]())
        collectionViewShowCases.reloadData()
    }
    
    private func fetchShowCase(page : Int) {
        movieModel.getTopRatedMovieList(page: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data.results ?? [MovieResult]())
                self.collectionViewShowCases.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    func setUpCollectionView(){
        collectionViewShowCases.dataSource = self
        collectionViewShowCases.delegate = self
        collectionViewShowCases.registerForCell(identifier: ShowCaseCollectionViewCell.identifier)
        collectionViewShowCases.showsHorizontalScrollIndicator = false
        collectionViewShowCases.showsVerticalScrollIndicator = false
        collectionViewShowCases.contentInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        if let layout = collectionViewShowCases.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }

}

extension MoreShowCasesViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowCaseCollectionViewCell.self), for: indexPath) as? ShowCaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = data[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isAtLastRow = indexPath.row == (data.count - 1)
        let hasMorePages = currentPage < totalPages
        if isAtLastRow && hasMorePages {
            currentPage = currentPage + 1
            fetchShowCase(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = collectionViewShowCases.frame.width
        let itemHeight : CGFloat = (itemWidth / 16) * 9
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        navigateToMovieDetailViewController(movieId: item.id ?? -1, .tapMovie)
    }
}
