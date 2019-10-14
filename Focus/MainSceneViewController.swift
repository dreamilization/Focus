//
//  MainSceneViewController.swift
//  Focus
//
//  Created by William Wu on 10/14/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController {
    @IBOutlet var lpgRecognizor: UILongPressGestureRecognizer!
    @IBOutlet weak var timeLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.bool(forKey: "isBlackBg"))
        {
            self.view.backgroundColor = UIColor.black;
        }
    }
    
    
    @IBAction func enterSetting(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == .began)
        {
            let setting = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController;
            self.present(setting, animated: true, completion: nil);
        }
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
