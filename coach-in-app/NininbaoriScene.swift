//
//  NininbaoriScene.swift
//  coach-in-app
//
//  Created by ide yuta on 2018/07/15.
//  Copyright © 2018年 ojisan. All rights reserved.
//

import SpriteKit

class NininbaoriScene: SKScene {
    
    var joystickImageEnabled = true {
        didSet {
            let image =  UIImage(named: "stick")
            joystick.stick.image = image
        }
    }
    
    let joystick = 🕹(diameter: 110) // from Emoji
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        backgroundColor = UIColor.white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        joystick.position = CGPoint(x: joystick.radius + 15, y: joystick.radius + 15)
        addChild(joystick)
    }
    
}

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
