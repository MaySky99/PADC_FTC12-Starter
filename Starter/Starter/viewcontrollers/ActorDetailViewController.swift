//
//  ActorDetailViewController.swift
//  Starter
//
//  Created by Cruise on 3/25/22.
//

import UIKit

class ActorDetailViewController: UIViewController {
    
    @IBOutlet weak var ivBack: UIImageView!
    @IBOutlet weak var labelActorName: UILabel!
    @IBOutlet weak var labelBiography: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var labelBirthday: UILabel!
    
    @IBOutlet weak var collectionViewCredit: UICollectionView!
    
    private let actorModel : ActorModel = ActorModelImplementation.shared
    
    var personId : Int = -1
    private var actorCredit : [ActorCast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerForCollectionView()
        // Do any additional setup after loading the view.
        fetchActorDetail(id: personId)
    }
    
    private func registerForCollectionView(){
        collectionViewCredit.dataSource = self
        collectionViewCredit.delegate = self
        collectionViewCredit.registerForCell(identifier: PopularFlimsCollectionViewCell.identifier)
        collectionViewCredit.showsHorizontalScrollIndicator = false
        collectionViewCredit.showsVerticalScrollIndicator = false
       
    }
    
    private func initGestureRecognizers() {
        let tapGestureForBack = UITapGestureRecognizer(target: self, action: #selector(onTapBack))
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(tapGestureForBack)
    }
    @objc func onTapBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func fetchActorDetail(id : Int) {
        actorModel.getActorDetailById(id: id) { result in
            switch result {
            case .success(let data):
                self.bindData(data: data)
                self.fetchActorCredit(id: id)
            case .failure(let message):
                print(message)
            }
//            self.bindData(data: data)
//            self.fetchActorCredit(id: id)
//        } failure: { error in
//            print(error.description)
        }
    }
    
    private func bindData(data : ActorDetailResponse) {
        let backdropPath = "\(AppConstants.basicImageURL)\(data.profilePath ?? "")"
        imageViewProfile.sd_setImage(with: URL(string: backdropPath))
        
        labelActorName.text = data.name
        labelBiography.text = data.biography
        labelBirthday.text = data.birthday
    }
    
    private func fetchActorCredit(id : Int) {
        actorModel.getActorCredit(id: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.actorCredit = data.cast ?? [ActorCast]()
                self.collectionViewCredit.reloadData()
            case .failure(let message):
                print(message)
            }
        }
    }
    
}

extension ActorDetailViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCredit {
            return actorCredit.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCredit {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFlimsCollectionViewCell.self), for: indexPath) as? PopularFlimsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let item = actorCredit[indexPath.row]
            cell.data = item.convertToMovieResult()
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewCredit {
            let itemWidth : CGFloat = 110
            let itemHeight : CGFloat = collectionViewCredit.frame.height
            return CGSize(width: itemWidth, height: itemHeight)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCredit {
            let item = actorCredit[indexPath.row].convertToMovieResult()
            if let _ = item.originalTitle {
                navigateToMovieDetailViewController(movieId: item.id ?? -1, .tapMovie)
            }
            else {
                navigateToMovieDetailViewController(movieId: item.id ?? -1, .tapSerie)
            }
        }
    }
}
