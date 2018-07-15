//
//  NininbaoriScene.swift
//  coach-in-app
//
//  Created by ide yuta on 2018/07/15.
//  Copyright © 2018年 ojisan. All rights reserved.
//

import SpriteKit
import UIKit

class NininbaoriScene: SKScene {
    
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
    
    override func didMove(to view: SKView) {
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
                self.leftDebugLabel.text = "upper"
            }else if(yVal < -25 && abs(xVal) < 25 ){
                print("under")
                self.leftDebugLabel.text = "under"
            } else if(xVal > 25 && abs(yVal) < 25){
                print("right")
                self.leftDebugLabel.text = "right"
            } else if (xVal < -25 && abs(yVal) < 25){
                print("left")
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
