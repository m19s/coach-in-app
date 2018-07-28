//
//  DanceFloorViewController.swift
//  coach-in-app
//
//  Created by ide yuta on 2018/07/15.
//  Copyright © 2018年 ojisan. All rights reserved.
//

import UIKit
import AudioKit
import CoreBluetooth


class DanceFloorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let metronome = AKMetronome()
    let dreaminPlayer = AKAppleSampler()
    let vanillaPlayer = AKAppleSampler()
    var characteristicUUID: CBUUID?
    var peripheral: CBPeripheral?
    var channelIdentifier: UInt8 = 0
    
    @IBOutlet weak var bpmLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! self.dreaminPlayer.loadWav("dreamin")
        try! self.vanillaPlayer.loadWav("vanilla")
        
        metronome.callback = {
            if let p = self.peripheral, let uuid = self.characteristicUUID, let characteristic = p.characteristic(by: uuid) {
                let packet = DrivePacket(channel: 0, delayMilliSeconds: 0, driveAll: true)
                p.writeValue(Data(bytes: packet.byteArray()), for: characteristic, type: .withResponse)
            }
            print("call back")
        }
        
        metronome.tempo = 60.0
        metronome.subdivision = 3
        metronome.frequency1 = 2000
        metronome.frequency2 = 1000
        
        let mixer = AKMixer(self.dreaminPlayer, self.vanillaPlayer, metronome)
        AudioKit.output = mixer
        try? AudioKit.start()
        metronome.start()
        
        
        try! self.vanillaPlayer.play()
        print(BLEConnectionManager.shared.peripherals.anyObject())
    }
    
    @IBAction func handleChangeSlider(_ sender: UISlider) {
        var val = sender.value
        metronome.tempo = Double(val)
        bpmLabel.text = String(val)
    }
    
    @IBAction func hundleClickPlayBtn(_ sender: UIButton) {
//        print(self.soundSampler)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "music", for: indexPath)
        cell.textLabel!.text = musics[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(musics[indexPath.row] == "vannila"){
            try! self.vanillaPlayer.play()
            try! self.dreaminPlayer.stop()
        }else if(musics[indexPath.row] == "dreamin"){
            try! self.dreaminPlayer.play()
            try! self.vanillaPlayer.stop()
        }
    }
    
    
    @IBOutlet weak var soundTable: UITableView!
    let musics = ["vannila", "dreamin", "lolisp"]
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


