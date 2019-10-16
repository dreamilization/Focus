//
//  DebugViewController.swift
//  Focus
//
//  Created by William Wu on 10/15/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class DebugViewController: UIViewController {

    @IBOutlet weak var L1: UILabel!
    @IBOutlet weak var L2: UILabel!
    @IBOutlet weak var L3: UILabel!
    @IBOutlet weak var L4: UILabel!
    @IBOutlet weak var L5: UILabel!
    @IBOutlet weak var L6: UILabel!
    @IBOutlet weak var L7: UILabel!
    @IBOutlet weak var L8: UILabel!
    let defaults = UserDefaults.standard;
    override func viewDidLoad() {
        super.viewDidLoad()
        let uiDevice = UIDevice.current;
        L1.text = "Version: " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A");
        L2.text = uiDevice.systemName + " " + uiDevice.systemVersion + " ";
        L3.text = "Model: " + uiDevice.model;
        L4.text = "guidedPasswd: " + defaults.string(forKey: "guidedPasswd")!;
        L5.text = "";
        L6.text = "";
        L7.text = "";
        L8.text = "";
        // Do any additional setup after loading the view.
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
