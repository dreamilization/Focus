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
    var isTWH = false;
    let defaults = UserDefaults.standard;
    @IBOutlet weak var dateLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if(defaults.bool(forKey: "isBlackBg"))
        {
            self.view.backgroundColor = UIColor.black;
        }
        isTWH = defaults.bool(forKey: "isTWH");
        updateLabel();
        startTimer();
    }
    
    func startTimer()
    {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true);
    }
    
    @objc func updateLabel() {
        let date = Date();
        let calendar = Calendar.current;
        let hour = calendar.component(.hour, from: date);
        let minutes = calendar.component(.minute, from: date);
        let hourString = String(isTWH && hour > 12 ? hour - 12 : hour == 0 ? 12 : hour);
        let minutesString = String(minutes);
        let processedMin = minutesString.count == 1 ? "0" + minutesString : minutesString;
        let processedHr = hourString.count == 1 ? "0" + hourString : hourString;
        isOdd = !isOdd;
        timeLabel.text = processedHr + ( !flashColumn || isOdd ? ":" : " " ) + processedMin;
        if(defaults.bool(forKey: "isShowDate"))
        {
            let year = calendar.component(.year, from: date);
            let month = calendar.component(.month, from: date);
            let day = calendar.component(.day, from: date);
            let monthString = intToMonth(month: month);
            let dayString = String(day);
            let yearString = String(year);
            dateLabel.text = monthString + " " + dayString + ", " + yearString;
        }
    }
    
    func intToMonth(month : Int) -> String
    {
        switch month {
        case 1:
            return "January";
        case 2:
            return "February";
        case 3:
            return "March";
        case 4:
            return "April";
        case 5:
            return "May";
        case 6:
            return "June";
        case 7:
            return "July";
        case 8:
            return "August";
        case 9:
            return "September";
        case 10:
            return "October";
        case 11:
            return "November";
        case 12:
            return "December";
        default:
            return "Unknown";
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
