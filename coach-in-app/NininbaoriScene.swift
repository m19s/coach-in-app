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
    }
    
}

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
