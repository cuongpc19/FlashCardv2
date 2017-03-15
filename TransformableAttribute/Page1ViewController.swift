//
//  Page1ViewController.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/15/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import AVFoundation
class Page1ViewController : DataViewController {
    
            
    
    @IBOutlet weak var uiImageView: UIImageView!
    var audioPlayer:AVAudioPlayer?
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        if dataImage != nil
        {
            self.uiImageView.image = dataImage
        }
        playRecord()
    }
    func playRecord() {
        if dataRecord != nil {
            if let dataAudio = dataRecord?.record {
                //nsdata -> audio
                do {
                    audioPlayer = try AVAudioPlayer(data: dataAudio as! Data ) as AVAudioPlayer
                    audioPlayer?.play()
                } catch {}
            }
        }
    }
}
