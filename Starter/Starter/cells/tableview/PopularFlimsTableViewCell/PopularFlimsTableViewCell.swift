//
//  PopularFlimsTableViewCell.swift
//  Starter
//
//  Created by Cruise on 2/11/22.
//

import UIKit

class PopularFlimsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewMovie: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    
    weak var delegate : MovieItemDelegate? = nil
//    var serieDelegate : SerieItemDelegate? = nil
    
    var data : MovieListResponse? {
        didSet {
            if let _ = data {
                collectionViewMovie.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerForCollectionViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func registerForCollectionViewCell(){
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
        collectionViewMovie.registerForCell(identifier: PopularFlimsCollectionViewCell.identifier)
    }
    
}
extension PopularFlimsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFlimsCollectionViewCell.self), for: indexPath) as? PopularFlimsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = data?.results?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight : CGFloat = collectionView.frame.height
        return CGSize(width: collectionView.frame.width/3.6, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        if let _ = item?.originalTitle {
            delegate?.onTapMovie(id: item?.id ?? -1, type: .tapMovie)
        }
        else {
            delegate?.onTapMovie(id: item?.id ?? -1, type: .tapSerie)
        }
//        serieDelegate?.onTapSerie(id: item?.id ?? -1, type: .tapSerie)
    }
}
