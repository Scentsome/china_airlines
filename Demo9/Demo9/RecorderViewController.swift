//
//  RecorderViewController.swift
//  Demo9
//
//  Created by Michael on 03/04/2018.
//  Copyright © 2018 Zencher. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import Photos

class RecorderViewController: UIViewController {
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?

    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true).first?.appending("/record.m4a")

    @IBAction func takeVideo(_ sender: Any) {
        
        var controller = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            controller.sourceType = .camera
            controller.mediaTypes = [kUTTypeMovie as String]
            controller.delegate = self
            controller.videoMaximumDuration = 10.0
            
            present(controller, animated: true, completion: nil)
        }
        else {
            print("Camera is not available")
        }


    }
    @IBAction func record(_ sender: Any) {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("set Category error:(err.localizedDescription)")
        }
        do {
            try session.setActive(true)
            
        } catch let err {
            print("setSctive error: \(err.localizedDescription)")
        }
        
        let recordSetting = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),//格式
            AVSampleRateKey: 44100,//採樣率
            AVNumberOfChannelsKey: 2,//通道數
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue//品質
        ]
        do {
            let url = URL(fileURLWithPath: filePath!)
            recorder = try AVAudioRecorder(url: url, settings: recordSetting)
            recorder!.prepareToRecord()
            recorder!.record()
            print("Start recording")
            recordButton.backgroundColor = UIColor.lightGray
            stopButton.backgroundColor = UIColor.red
            stopButton.isEnabled = true
            recordButton.isEnabled = false
        } catch let err {
            print("record error: \(err.localizedDescription)")
        }




    }
    
    @IBAction func stopRecord(_ sender: Any) {
        if let recorder = self.recorder {
            
            if recorder.isRecording {
                print("Save to: \(filePath!)")
            }else {
                print("Not recording")
            }
            
            recorder.stop()
            self.recorder = nil
            stopButton.isEnabled = false
            recordButton.isEnabled = true
            
        } else {
            print("not initialize")
        }

    }
    
    
    @IBAction func play(_ sender: Any) {
        do {
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath!))
            
            print("Duration: \(player!.duration)")
            player?.numberOfLoops = -1
            player!.play()
            
        } catch let err {
            print("Play error: \(err.localizedDescription)")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.backgroundColor = UIColor.blue
        stopButton.backgroundColor = UIColor.lightGray
        stopButton.isEnabled = false
        
    PHPhotoLibrary.requestAuthorization({ (status) -> Void in
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecorderViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if info[UIImagePickerControllerMediaType] as! String == kUTTypeMovie as String {
            
            let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
            if let url = urlOfVideo {
                //Save Video
                PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url as URL)
                }) { (isSuccess: Bool, error: Error?) in
                    if isSuccess {
                        print("保存成功!")
                    } else{
                        print("保存失敗：", error!.localizedDescription)
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)

    }
}
