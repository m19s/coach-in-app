//
//  DanceFloorViewController.swift
//  coach-in-app
//
//  Created by ide yuta on 2018/07/15.
//  Copyright © 2018年 ojisan. All rights reserved.
//

import UIKit
import AudioKit


class DanceFloorViewController: UIViewController {
    
    let metronome = AKMetronome()
    
    @IBOutlet weak var bpmLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sampler = AKAppleSampler()
        try! sampler.loadWav("vanilla")
        
        metronome.callback = {
            print("call back")
        }
        
        metronome.tempo = 60.0
        metronome.subdivision = 3
        metronome.frequency1 = 2000
        metronome.frequency2 = 1000
        let mixer = AKMixer(sampler, metronome)
        AudioKit.output = mixer
        try? AudioKit.start()
        metronome.start()
        try! sampler.play()
    }
    
    @IBAction func handleChangeSlider(_ sender: UISlider) {
        var val = sender.value
        metronome.tempo = Double(val)
        bpmLabel.text = String(val)
    }
    
    @IBAction func hundleClickPlayBtn(_ sender: UIButton) {
//        print(self.soundSampler)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


