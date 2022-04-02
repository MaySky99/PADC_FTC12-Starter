//
//  ViewController.swift
//  Starter
//
//  Created by Cruise on 2/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var textFieldName: UITextField!

    @IBAction func didTapButton(_ sender: Any) {
        labelName.text = textFieldName.text
        textFieldName.text = ""
    }
    
    let networkAgent = MovieDBNetworkAgent.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGestureForImage = UITapGestureRecognizer(target: self, action: #selector(onTapImage))
        imageProfile.addGestureRecognizer(tapGestureForImage)
        imageProfile.isUserInteractionEnabled = true
        
        debugPrint("ViewDidLoad")
        
//        fetchmoviedetail(id: 1399)
    }
    
//    private func fetchmoviedetail(id : Int){
//        networkAgent.getSerieDetail(id: id) { data in
//            self.bindData(data: data)
//        } failure: { error in
//            print(error)
//        }
//    }
//
//    private func bindData(data: SerieDetail){
//        labelName.text = data.overview
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("ViewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("ViewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        debugPrint("ViewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        debugPrint("ViewDidDisappear")
    }
    
    @objc func onTapImage(){
        textFieldName.text = "May Kaung Kin"
    }

}
