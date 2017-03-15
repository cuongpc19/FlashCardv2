//
//  DetailViewController.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/3/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var playRecordButton: UIButton!
    
    var event : Event!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var audioPlayer:AVAudioPlayer! {
        didSet {
            playRecordButton.isEnabled = true
        }
    }
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioRecorderUrl:URL!
    func configureViewAndRecord() {
        
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.timestamp!.description
            }
        }
        
        if let event = self.event {
            //print("event description: \(event.timestamp?.description)")
            if let photo = event.photo  {
                self.photoImageView.image = photo.image
            }
            if let recording = event.record {
                if let dataAudio = recording.record {
                //nsdata -> audio
                do {
                    audioPlayer = try AVAudioPlayer(data: dataAudio as! Data ) as AVAudioPlayer
                    audioRecorderUrl = audioPlayer.url
                } catch {}
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playRecordButton.isEnabled = false
        self.configureViewAndRecord()
        recordAudio()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Recording
    private func recordAudio() {
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
    }
    
    func loadRecordingUI() {
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
    }
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            if let image = UIImage(named: "stopButton") {
                recordButton.setImage(image, for: .normal)
            }
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            audioRecorderUrl = audioRecorder.url
        } catch {
            finishRecording(success: false)
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func finishRecording(success: Bool) {
        if let image = UIImage(named: "recordButton") {
            recordButton.setImage(image, for: .normal)
        }
        audioRecorder.stop()
        if success {
            playRecordButton.isEnabled = true
        } else {
            
        }
    }
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
            //add to CoreData
            let managedContext = event.managedObjectContext
            let entity_record = NSEntityDescription.entity(forEntityName: "Record", in: managedContext!)
            let recording = NSManagedObject.init(entity: entity_record!, insertInto: managedContext) as! Record
            //audio recorder -> data
            let recordingData = NSData.init(contentsOf: audioRecorder.url)
            recording.record = recordingData
            event.record = recording
            //4
            do {
                try managedContext?.save()
                //5
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
    }
    
    @IBAction func playRecordAction(_ sender: Any) {
            do {
                if (audioRecorderUrl != nil) {
                    try audioPlayer = AVAudioPlayer(contentsOf: audioRecorderUrl)
                }
                audioPlayer.play()
            } catch {
                print("can't get audioPlayer.")
            }
        
    }
    
    //MARK: update the view
    var detailItem: Event? {
        didSet {
            // Update the view.
            self.configureViewAndRecord()
        }
    }
    //MARK: UIImagePickerControllerDelegate
    // Can phai conform UIImagePickerControllerDelegate, UINavigatiControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        //insert Photo Entiry
        
        
        let managedContext = event.managedObjectContext
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in:managedContext!)
        let photoEntity = NSManagedObject(entity: entity!, insertInto: managedContext) as! Photo
        //3
        photoEntity.image = selectedImage
        event.photo = photoEntity
        //4
        do {
            try managedContext?.save()
            //5
            //people.append(person)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    func backAction() {
        dismiss(animated: true, completion: nil)
    }
}

