//
//  ExtentionAV.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/10/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import AVFoundation
// MARK: - AVAudioRecorderDelegate
extension DetailViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
