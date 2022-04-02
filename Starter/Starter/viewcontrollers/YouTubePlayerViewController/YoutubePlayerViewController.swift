//
//  YoutubePlayerViewController.swift
//  Starter
//
//  Created by Cruise on 3/25/22.
//

import UIKit
import YouTubePlayer

class YoutubePlayerViewController: UIViewController {
    
    @IBOutlet var videoPlayer: YouTubePlayerView!
    
    var youtubeId : String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Load video from YouTube ID
        if let id = youtubeId {
            videoPlayer.loadVideoID(id)
            videoPlayer.play()
        }else {
            print("Invalid video player")
        }
        
    }
    
    @IBAction func btnClose(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
