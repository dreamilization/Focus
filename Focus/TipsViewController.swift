//
//  TipsViewController.swift
//  Focus
//
//  Created by William Wu on 10/15/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

    @IBOutlet weak var titleDisplay: UILabel!
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipsLabel.adjustsFontSizeToFitWidth = true;
        welcomeMessage.adjustsFontSizeToFitWidth = true;
        if(UserDefaults.standard.bool(forKey: "firstTimeLaunch"))
        {
            titleDisplay.text = "Welcome";
            UserDefaults.standard.set(false, forKey: "firstTimeLaunch");
            otherLabel.text = "";
        }
        else
        {
            welcomeMessage.text = "";
        }
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
