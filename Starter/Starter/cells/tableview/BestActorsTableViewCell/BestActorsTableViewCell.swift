//
//  BestActorsTableViewCell.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
//

import UIKit

class BestActorsTableViewCell: UITableViewCell, ActorActionDelegate {

    @IBOutlet weak var lblMoreActor: UILabel!
    @IBOutlet weak var collectionViewActors: UICollectionView!
    @IBOutlet weak var heightForCollectionViewActors: NSLayoutConstraint!
    
    weak var delegate : ActorItemDelegate? = nil
    
    weak var moreDelegate : ActorMoreDelegate? = nil
    
    var data : ActorListResponse? {
        didSet {
            if let _ = data {
                collectionViewActors.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblMoreActor.underlineText(text: "MORE ACTORS")
        registerForCollectionView()
        initGestureRecognizers()
        
        let itemWidth : CGFloat = 110
        let itemHeight : CGFloat = itemWidth * 1.5
        heightForCollectionViewActors.constant = itemHeight
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func registerForCollectionView(){
        collectionViewActors.dataSource = self
        collectionViewActors.delegate = self
        collectionViewActors.registerForCell(identifier: BestActorsCollectionViewCell.identifier)
    }
    
    func onTapFavorite(isFavorite: Bool) {
        debugPrint("isFavorite => \(isFavorite)")
    }
    
    private func initGestureRecognizers() {
        let tapGestureForMore = UITapGestureRecognizer(target: self, action: #selector(onTapMore))
        lblMoreActor.isUserInteractionEnabled = true
        lblMoreActor.addGestureRecognizer(tapGestureForMore)
    }
    @objc func onTapMore(){
        moreDelegate?.onTapActorMore(isClick: true, data: data!)
    }
    
}
extension BestActorsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorsCollectionViewCell.self), for: indexPath) as? BestActorsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.data = data?.results?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = 110
        let itemHeight : CGFloat = itemWidth * 1.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        delegate?.onTapPerson(id: item?.id ?? -1)
    }
}
