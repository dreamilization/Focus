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
    var timer : Timer?;
    var flashColumn = false;
    var isOdd = false;
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel();
        if(UserDefaults.standard.bool(forKey: "isBlackBg"))
        {
            self.view.backgroundColor = UIColor.black;
        }
        startTimer();
    }
    
    func startTimer()
    {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true);
    }
    
    @objc func updateLabel() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let hourString = String(hour)
        let minutesString = String(minutes)
        isOdd = !isOdd;
        timeLabel.text = hourString + ( isOdd || !flashColumn ? ":" : " " ) + minutesString
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
