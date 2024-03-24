//
//  ViewController.swift
//  EggTimer
//
//  Created by Diamond on 16/03/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var imageEgg: UIImageView!
    var counter : Int = 3
    var seconds : Int = 3
    var timer : Timer?
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        // Do any additional setup after loading the view.
    }

   
    @IBAction func selectAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: imageEgg.image = .softEgg
            counter = 3
        case 1: imageEgg.image = .mediumEgg
            counter = 5
        case 2: imageEgg.image = .hardEgg
            counter = 8
         
        default: break
            
        }
        seconds = counter
        progressBar.progress = 0.0
        resultLbl.text = ""
    }
    
    @IBAction func startBtn(_ sender: Any) {

        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(update),
            userInfo: nil,
            repeats: true)
   
    }
    @objc func update(){
        if(counter > 0){
            counter = counter - 1
            progressBar.progress = 1.0 - Float(counter)/Float(seconds)
           
        }else{
            timer?.invalidate()
            resultLbl.text = "Time is over"
            timerDidFinish()
          
        }
    }
    func timerDidFinish() {
        guard let url = Bundle.main.url(forResource: "https___www.tones7.com_media_extreme_clock_alarm", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.play()
        } catch let error {
            print("Error playing sound")
        }
    }
    @IBAction func stopBtn(_ sender: Any) {
        stopSound()
    }
    func stopSound() {
        
        player?.stop()
        
       }
}

