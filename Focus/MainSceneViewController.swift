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
    var isShowingPassword = false;
    var isFocus = false;
    var totalSec = 0;
    let defaults = UserDefaults.standard;
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoDisplay: UILabel!
    @IBOutlet weak var infoDisplayDetail: UILabel!
    @IBOutlet weak var firstHint: UILabel!
    
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
        mainLogic();
        startTimer();
        NotificationCenter.default.addObserver(self, selector: #selector(guidedAccessChanged), name: UIAccessibility.guidedAccessStatusDidChangeNotification, object: nil);
    }
    
    func startTimer()
    {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mainLogic), userInfo: nil, repeats: true);
    }
    
    @objc func guidedAccessChanged()
    {
        if(UIAccessibility.isGuidedAccessEnabled && isShowingPassword)
        {
            isFocus = true;
            hideInfo();
            isShowingPassword = false;
        }
        else
        {
            isFocus = false;
        }
    }
    
    @objc func mainLogic() {
        let date = Date();
        let calendar = Calendar.current;
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
        else
        {
            dateLabel.text = "";
        }
        
        if(defaults.bool(forKey: "firstTimeLaunch"))
        {
            firstHint.text = "Press to View Tips";
        }
        else
        {
            firstHint.text = "";
        }
        
        if(isFocus)
        {
            totalSec += 1;
        }
        
        
        
        let hour = calendar.component(.hour, from: date);
        let minutes = calendar.component(.minute, from: date);
        let hourString = String(isTWH && hour > 12 ? hour - 12 : isTWH && hour == 0 ? 12 : hour);
        let minutesString = String(minutes);
        let processedMin = minutesString.count == 1 ? "0" + minutesString : minutesString;
        let processedHr = hourString.count == 1 ? "0" + hourString : hourString;
        isOdd = !isOdd;
        timeLabel.text = processedHr + ( !flashColumn || isOdd ? ":" : " " ) + processedMin;
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
    
    func displayInfo(title : String, detail : String)
    {
        UIView.animate(withDuration: 0.4, animations: {
            self.infoDisplay.alpha = 0;
            self.infoDisplayDetail.alpha = 0;
        }, completion: { (finished : Bool) in
            UIView.animate(withDuration: 0.6, animations: {
                self.infoDisplay.text = title;
                self.infoDisplayDetail.text = detail;
                self.infoDisplay.alpha = 1;
                self.infoDisplayDetail.alpha = 1;
            })
        });
    }
    
    func hideInfo()
    {
        UIView.animate(withDuration: 0.6, animations: {
            self.infoDisplay.alpha = 0;
            self.infoDisplayDetail.alpha = 0;
        });
    }
    
    
    @IBAction func showPassword(_ sender: UITapGestureRecognizer) {
        if(sender.state == .ended)
        {
            if(isShowingPassword)
            {
                hideInfo();
                isShowingPassword = false;
            }
            else
            {
                isShowingPassword = true;
                if(UIAccessibility.isGuidedAccessEnabled)
                {
                    displayInfo(title: "Unable to Display", detail: "Focus Sesstion in Progress.");
                }
                else
                {
                    displayInfo(title: "Guided Access Password", detail: defaults.string(forKey: "guidedPasswd")!);
                }
            }
        }
    }
    
    @IBAction func revealTimer(_ sender: Any) {
        
    }
    
    @IBAction func enterSetting(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == .began)
        {
            if(defaults.bool(forKey: "firstTimeLaunch"))
            {
                let tips = self.storyboard?.instantiateViewController(withIdentifier: "TipsViewController") as! TipsViewController;
                self.present(tips, animated: true, completion: nil);
            }
            else
            {
                let setting = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController;
                self.present(setting, animated: true, completion: nil);
            }
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
