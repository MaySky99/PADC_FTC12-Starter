//
//  SampleCollectionViewController.swift
//  Starter
//
//  Created by Cruise on 2/10/22.
//

import UIKit

class SampleCollectionViewController: UIViewController {

    @IBOutlet weak var collectionViewMovie: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
        collectionViewMovie.register(UINib(nibName: String(describing: SampleCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SampleCollectionViewCell.self))

    }
    
}
extension SampleCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SampleCollectionViewCell.self), for: indexPath) as? SampleCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
