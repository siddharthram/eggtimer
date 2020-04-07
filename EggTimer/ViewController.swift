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
    
    let eggTimes = ["Soft" : 10, "Medium": 20, "Hard": 30]
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    var counter = 0
    var timer = Timer()
    var progress = 0.0
    var currentTimer = 0
    @IBOutlet weak var countdownTimer: UILabel!
    @IBOutlet weak var counterProgress: UIProgressView!
    var av: AVAudioPlayer = AVAudioPlayer()
  
    @objc func updateCounter(timer: Timer) {
       // let userInfo = timer.userInfo as! [String: Int]
        if counter >  0 {
            //print ("counting down \(counter)")
            countdownTimer.text = String(counter)
            counter-=1
            progress = Double(Float(counter)/Float(currentTimer))
            counterProgress.progress = Float(progress)
            print(progress)

        } else {
            timer.invalidate()
            countdownTimer.text = "Done!"
            av.play()
            
        }
     }
    
    override func viewDidLoad() {
        let sound = Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")
        do{
            av = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }catch {
                 print(error)
                }
         
          
    }
 /*
  let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
      print("FIRE!!!")
  })
*/
 
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        let result = eggTimes[hardness]!
        timer.invalidate()
        counter = result
        currentTimer = result
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: ["duration": result ], repeats: true)
       
           
        //print(result)
    }
    

}
