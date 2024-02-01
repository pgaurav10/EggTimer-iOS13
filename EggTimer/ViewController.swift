//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    let eggTime : [String:Int] = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer : Timer?
    var counter: Int = 0
    @IBOutlet weak var gTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var hard : Int = 0
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    @IBAction func hardnessCLicked(_ sender: UIButton) {
        counter = 0
        progressBar.progress = 0.0
        timer?.invalidate()
        let hardness = sender.currentTitle!
        gTitle.text = hardness
        hard = eggTime[hardness]!
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prozessTimer), userInfo: nil, repeats: true)
       
        
    }
    @objc func prozessTimer() {
        
        if counter <= hard {
            
            progressBar.progress = Float(counter)/Float(hard)
            print(Float(counter)/Float(hard))
            counter += 1
        } else {
            timer?.invalidate()
            gTitle.text = "DONE!"
            playSound()
        }
        
        
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
