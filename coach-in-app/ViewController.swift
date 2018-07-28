//
//  ViewController.swift
//  coach-in-app
//
//  Created by ide yuta on 2018/07/15.
//  Copyright © 2018年 ojisan. All rights reserved.
//

import UIKit

/**
 
 UIViewControllerを継承したViewControllerクラス. ルートViewに当たる. 
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func handleClickNininbaoriBtn(_ sender: UIButton) {
        let storyboard: UIStoryboard = self.storyboard!
        let nininbaori = storyboard.instantiateViewController(withIdentifier: "nininbaori")
        self.present(nininbaori, animated: true, completion: nil)
    }
    
    
    @IBAction func handleClickDanceBtn(_ sender: UIButton) {
        let storyboard: UIStoryboard = self.storyboard!
        let danceFloor = storyboard.instantiateViewController(withIdentifier: "danceFloor")
        self.present(danceFloor, animated: true, completion: nil)
    }
    
    @IBAction func handleClickBleBtn(_ sender: UIButton) {
        let storyboard: UIStoryboard = self.storyboard!
        let bleViewController = PeripheralTableViewController(style: .plain)
        self.present(bleViewController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }


}

