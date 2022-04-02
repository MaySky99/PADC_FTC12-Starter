//
//  MoreActorsViewController.swift
//  Starter
//
//  Created by Cruise on 3/26/22.
//

import UIKit

class MoreActorsViewController: UIViewController {
    
    @IBOutlet weak var collectionViewActor : UICollectionView!
    
    private let movieModel : MovieModel = MovieModelImplementation.shared

    var initData : ActorListResponse?
    private var currentPage : Int = 1
    private var totalPages : Int = 1
    
    private var data : [ActorInfoResponse] = []
    private let itemSpacing : CGFloat = 10
//    private let numberOfItemPerRow = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpCollectionView()
        initState()
    }
    
//    private func initView(){
//        setUpCollectionView()
//    }
    
    private func initState(){
        currentPage = initData?.page ?? 1
        totalPages = initData?.totalPages ?? 1
        
        data.append(contentsOf: initData?.results ?? [ActorInfoResponse]())
        collectionViewActor.reloadData()
    }
    
    private func fetchActorList(page : Int){
        movieModel.getPopularPeople(page: page) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data.results ?? [ActorInfoResponse]())
                self.collectionViewActor.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
   
    func setUpCollectionView(){
        collectionViewActor.dataSource = self
        collectionViewActor.delegate = self
        collectionViewActor.registerForCell(identifier: BestActorsCollectionViewCell.identifier)
        collectionViewActor.showsHorizontalScrollIndicator = false
        collectionViewActor.showsVerticalScrollIndicator = false
        collectionViewActor.contentInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        if let layout = collectionViewActor.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }

}

extension MoreActorsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorsCollectionViewCell.self), for: indexPath) as? BestActorsCollectionViewCell else {
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
            fetchActorList(page: currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let totalSpacing : CGFloat = (itemSpacing * CGFloat(numberOfItemPerRow - 1)) + collectionView.frame.width
        let itemWidth : CGFloat = 110
        let itemHeight : CGFloat = itemWidth * 1.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return itemSpacing
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        navigateToPersonDetailViewController(personId: item.id ?? -1)
    }
}
