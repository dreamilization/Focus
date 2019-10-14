//
//  SettingViewController.swift
//  Focus
//
//  Created by William Wu on 10/14/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var displayDateButton: UIButton!
    @IBOutlet weak var timeFormatButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var displayTutorialButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard;
        if(defaults.bool(forKey: "isBlackBg"))
        {
            self.view.backgroundColor = UIColor.black;
            colorButton.setTitle(defaults.bool(forKey: "isBlackBg") ? "Dark" : "Grey", for: .normal);
        }
        let isTWH = defaults.bool(forKey: "isTWH");
        timeFormatButton.setTitle(isTWH ? "12-Hour" : "24-Hour", for: .normal);
        let isShowDate = defaults.bool(forKey: "isShowDate");
        displayDateButton.setTitle(isShowDate ? "Displaying Date" : "Not Displaying Date", for: .normal);
        let verNum = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String;
        versionLabel.text = "Ver: " + (verNum ?? "N/A");
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
