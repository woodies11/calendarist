//
//  ViewController.swift
//  ViperApp
//
//  Created by Romson Preechawit on 15/3/18.
//  Copyright © 2018 RWP. All rights reserved.
//

import UIKit

protocol LoginPageViewControllerProtocol: AnyObject {
}

class LoginPageViewController: UIViewController, LoginPageViewControllerProtocol {
    
    var presentator: LoginPagePresentatorProtocol!
    
    @IBAction func onConnectButtonPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

