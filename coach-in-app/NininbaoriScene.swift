//
//  NininbaoriScene.swift
//  coach-in-app
//
//  Created by ide yuta on 2018/07/15.
//  Copyright © 2018年 ojisan. All rights reserved.
//

import SpriteKit
import UIKit
import CoreBluetooth

class NininbaoriScene: SKScene {
    
    var characteristicUUID: CBUUID?
    var upperCharasteristic: CBUUID = CBUUID(string: EMSServiceChannel1CharacteristicUUID)
    var underCharasteristic: CBUUID = CBUUID(string: EMSServiceChannel2CharacteristicUUID)
    var rightCharasteristic: CBUUID = CBUUID(string: EMSServiceChannel3CharacteristicUUID)
    var leftCharasteristic: CBUUID = CBUUID(string: EMSServiceChannel4CharacteristicUUID)
    var peripheral: CBPeripheral = BLEConnectionManager.shared.peripherals.anyObject() as! CBPeripheral
    var lefthandPeripheral: CBPeripheral = BLEConnectionManager.shared.peripherals.allObjects[0] as! CBPeripheral
    var righthandPeripheral: CBPeripheral = BLEConnectionManager.shared.peripherals.allObjects[1] as! CBPeripheral
    
    let leftDebugLabel = SKLabelNode(text: "left ctr val")
    let rightDebugLabel = SKLabelNode(text: "right ctr val")
    
    // TODO : スティックの画像に差し替える
    let leftJoystick = 🕹(diameter: 100, colors: (UIColor.blue, UIColor.yellow))
    let rightJoystick = 🕹(diameter: 100, colors: (UIColor.blue, UIColor.yellow))
    
    var joystickImageEnabled = true {
        didSet {
            let image =  UIImage(named: "./resources/stick")
            leftJoystick.stick.image = image
        }
    }
    
    func viewDidLoad() {
        print("loaded")
    }
    
    
    override func didMove(to view: SKView) {
//        self.peripheral = BLEConnectionManager.shared.peripherals.anyObject() as! CBPeripheral
        self.upperCharasteristic = CBUUID(string: EMSServiceChannel1CharacteristicUUID)
        
        /* Setup your scene here */
        backgroundColor = UIColor.white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        leftJoystick.position = CGPoint(x: leftJoystick.radius + 15, y: leftJoystick.radius + 15)
        addChild(leftJoystick)
        rightJoystick.position = CGPoint(x: self.frame.maxX - rightJoystick.radius - 15, y:rightJoystick.radius + 15)
        addChild(rightJoystick)
        
        leftDebugLabel.fontColor = UIColor.black
        leftDebugLabel.fontSize = 20
        leftDebugLabel.verticalAlignmentMode = .top
        leftDebugLabel.horizontalAlignmentMode = .left
        leftDebugLabel.position = CGPoint(x: 300, y: 300)
        addChild(leftDebugLabel)
        
        rightDebugLabel.fontColor = UIColor.black
        rightDebugLabel.fontSize = 20
        rightDebugLabel.verticalAlignmentMode = .top
        rightDebugLabel.horizontalAlignmentMode = .left
        rightDebugLabel.position = CGPoint(x: 600, y: 300)
        addChild(rightDebugLabel)
        
        leftJoystick.trackingHandler = { [unowned self] data in
            // 上下左右に最大値 50
            var xVal = data.velocity.x
            var yVal = data.velocity.y
            if(yVal > 25 && abs(xVal) < 25 ){
                print("upper")
                let p = self.lefthandPeripheral
                let uuid = self.upperCharasteristic
                let characteristic = p.characteristic(by: uuid)
                let packet = DrivePacket(channel: 0, delayMilliSeconds: 0, driveAll: true)
                p.writeValue(Data(bytes: packet.byteArray()), for: characteristic!, type: .withResponse)
                self.leftDebugLabel.text = "upper"
            }else if(yVal < -25 && abs(xVal) < 25 ){
                print("under")
                let p = self.lefthandPeripheral
                let uuid = self.underCharasteristic
                let characteristic = p.characteristic(by: uuid)
                let packet = DrivePacket(channel: 0, delayMilliSeconds: 0, driveAll: true)
                p.writeValue(Data(bytes: packet.byteArray()), for: characteristic!, type: .withResponse)
                self.leftDebugLabel.text = "under"
            } else if(xVal > 25 && abs(yVal) < 25){
                print("right")
                let p = self.lefthandPeripheral
                let uuid = self.rightCharasteristic
                let characteristic = p.characteristic(by: uuid)
                let packet = DrivePacket(channel: 0, delayMilliSeconds: 0, driveAll: true)
                p.writeValue(Data(bytes: packet.byteArray()), for: characteristic!, type: .withResponse)
                self.leftDebugLabel.text = "right"
            } else if (xVal < -25 && abs(yVal) < 25){
                print("left")
                let p = self.lefthandPeripheral
                let uuid = self.leftCharasteristic
                let characteristic = p.characteristic(by: uuid)
                let packet = DrivePacket(channel: 0, delayMilliSeconds: 0, driveAll: true)
                p.writeValue(Data(bytes: packet.byteArray()), for: characteristic!, type: .withResponse)
                self.leftDebugLabel.text = "left"
            }
        }
        
        rightJoystick.trackingHandler = { [unowned self] data in
            // 上下左右に最大値 50
            var xVal = data.velocity.x
            var yVal = data.velocity.y
            if(yVal > 25 && abs(xVal) < 25 ){
                print("upper")
                self.rightDebugLabel.text = "upper"
            }else if(yVal < -25 && abs(xVal) < 25 ){
                print("under")
                self.rightDebugLabel.text = "under"
            } else if(xVal > 25 && abs(yVal) < 25){
                print("right")
                self.rightDebugLabel.text = "right"
            } else if (xVal < -25 && abs(yVal) < 25){
                print("left")
                self.rightDebugLabel.text = "left"
            }
        }
    }
    
}

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
