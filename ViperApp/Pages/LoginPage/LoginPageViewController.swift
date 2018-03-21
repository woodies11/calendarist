//
//  ViewController.swift
//  ViperApp
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController, LoginPageViewInput {
    
    var presentator: LoginPageViewOutput!
    
    @IBOutlet weak var connectButton: UIButton!
    @IBAction func onConnectButtonPressed(_ sender: Any) {
        presentator.initiateLoginProcedure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        connectButton.layer.cornerRadius = 8
        connectButton.layer.masksToBounds = false
        connectButton.layer.shadowColor = UIColor.black.cgColor
        connectButton.layer.shadowRadius = 3
        connectButton.layer.shadowOpacity = 0.2
        connectButton.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

