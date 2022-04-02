//
//  ShowCaseTableViewCell.swift
//  Starter
//
//  Created by Cruise on 2/12/22.
//

import UIKit

class ShowCaseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblshowCases: UILabel!
    @IBOutlet weak var collectionViewShowCase: UICollectionView!
    @IBOutlet weak var lblmoreShowCases: UILabel!
    @IBOutlet weak var heightForCollectionViewShowCase: NSLayoutConstraint!
    
    weak var delegate : MovieItemDelegate? = nil

    weak var moreShowDelegate : MovieMoreDelegate? = nil
    
    var data : MovieListResponse? {
        didSet {
            if let _ = data {
                collectionViewShowCase.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerForCollectionView()
        lblmoreShowCases.underlineText(text: "MORE SHOWCASES")
        
        let itemWidth : CGFloat = collectionViewShowCase.frame.width - 50
        let itemHeight : CGFloat = (itemWidth / 16) * 9
        heightForCollectionViewShowCase.constant = itemHeight
        
        initGestureRecognizers()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func registerForCollectionView(){
        collectionViewShowCase.dataSource = self
        collectionViewShowCase.delegate = self
        collectionViewShowCase.registerForCell(identifier: ShowCaseCollectionViewCell.identifier)
    }
    
    private func initGestureRecognizers() {
        let tapGestureForMore = UITapGestureRecognizer(target: self, action: #selector(onTapMore))
        lblmoreShowCases.isUserInteractionEnabled = true
        lblmoreShowCases.addGestureRecognizer(tapGestureForMore)
    }
    @objc func onTapMore(){
        moreShowDelegate?.onTapShowCaseMore(isClick: true, data: data!)
    }
    
}
extension ShowCaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath) as ShowCaseCollectionViewCell
        cell.data = data?.results?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = collectionViewShowCase.frame.width - 50
        let itemHeight : CGFloat = (itemWidth / 16) * 9
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // -1 horizontal indicator -2 vertical indicator
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ((scrollView.subviews[(scrollView.subviews.count-1)]).subviews[0]).backgroundColor = UIColor(named: "color_yellow")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        delegate?.onTapMovie(id: item?.id ?? -1, type: .tapMovie)
    }
}
