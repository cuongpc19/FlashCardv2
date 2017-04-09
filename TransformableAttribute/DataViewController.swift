//
//  DataViewController.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/15/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import AVFoundation
class DataViewController: UIViewController {
    var dataObject : String = ""
    var dataImage : UIImage?
    var dataRecord : Record?
    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
