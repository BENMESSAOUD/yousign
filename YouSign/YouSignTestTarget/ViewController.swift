//
//  ViewController.swift
//  YouSignTestTarget
//
//  Created by Mahmoud Ben Messaoud on 22/05/2017.
//  Copyright © 2017 Mahmoud Ben Messaoud. All rights reserved.
//

import UIKit
import YouSign

class ViewController: UIViewController {
    let env  =  Environement(Target.production, credential: Authent())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func connect(_ sender: Any) {
        let action  = Connect(env)
        action.send(onSuccess: { (result) in
            print("\(result ? "Connected" : "Error Credential")")
        }) { (error, code) in
            print("Code : \(code) \nError : \(error)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

