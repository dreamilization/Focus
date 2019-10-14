//
//  SetupViewController.swift
//  Focus
//
//  Created by William Wu on 10/13/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var titleDisplay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard;
        defaults.set(false, forKey: "launchedBefore");
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
