//
//  SettingViewController.swift
//  Focus
//
//  Created by William Wu on 10/14/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var lpgRecognizer: UILongPressGestureRecognizer!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var displayDateButton: UIButton!
    @IBOutlet weak var timeFormatButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var newGuidedPwButton: UIButton!
    @IBOutlet weak var displayTutorialButton: UIButton!
    @IBOutlet weak var internalSettingsButton: UIButton!
    let defaults = UserDefaults.standard;
    
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
        colorButton.setTitle(defaults.bool(forKey: "isBlackBg") ? "Dark" : "Grey", for: .normal);
        let isTWH = defaults.bool(forKey: "isTWH");
        timeFormatButton.setTitle(isTWH ? "12-Hour" : "24-Hour", for: .normal);
        let isShowDate = defaults.bool(forKey: "isShowDate");
        displayDateButton.setTitle(isShowDate ? "Displaying Date" : "Not Displaying Date", for: .normal);
        let verNum = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String;
        versionLabel.text = "Ver: " + (verNum ?? "N/A");
        if(UIAccessibility.isGuidedAccessEnabled)
        {
            newGuidedPwButton.setTitle("Reveal Password", for: .normal);
        }
        NotificationCenter.default.addObserver(self, selector: #selector(guidedAccessChanged), name: UIAccessibility.guidedAccessStatusDidChangeNotification, object: nil);
    }
    
    @objc func guidedAccessChanged()
    {
        if(UIAccessibility.isGuidedAccessEnabled)
        {
            newGuidedPwButton.setTitle("Reveal Password", for: .normal);
        }
        else
        {
            newGuidedPwButton.setTitle("New Guided Password", for: .normal);
        }
    }
    
    @IBAction func showInternalScreen(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == .began)
        {
            let alphaVar = internalSettingsButton.alpha;
            internalSettingsButton.alpha = alphaVar == 1 ? 0 : 1;
            internalSettingsButton.isEnabled = alphaVar == 1 ? false : true;
        }
    }
    
    @IBAction func generateNewPasswd(_ sender: Any) {
//      NSLog("Accessabilitiy enabled: %@", UIAccessibility.isGuidedAccessEnabled ? "YES" : "NO");
        if (!UIAccessibility.isGuidedAccessEnabled)
        {
            newGuidedPwButton.isEnabled = false;
            defaults.set(Utilities.generatePasswd(), forKey: "guidedPasswd");
            UIView.animate(withDuration: 0.5, animations: {
                self.newGuidedPwButton.alpha = 0;
            }, completion: { (finished : Bool) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.newGuidedPwButton.setTitle(self.defaults.string(forKey: "guidedPasswd"), for: .normal);
                    self.newGuidedPwButton.alpha = 1;
                })
            })
        }
        else
        {
            let isPassword = newGuidedPwButton.titleLabel?.text?.count == 6;
            UIView.animate(withDuration: 0.5, animations: {
                self.newGuidedPwButton.alpha = 0;
            }, completion: { (finished : Bool) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.newGuidedPwButton.setTitle(isPassword ? "Reveal Password" : self.defaults.string(forKey: "guidedPasswd"), for: .normal);
                    self.newGuidedPwButton.alpha = 1;
                })
            })
        }
    }
    
    @IBAction func displayDateOnClick(_ sender: Any) {
        defaults.set(!defaults.bool(forKey: "isShowDate"), forKey: "isShowDate");
        displayDateButton.setTitle(defaults.bool(forKey: "isShowDate") ? "Displaying Date" : "Not Displaying Date", for: .normal);
    }
    
    @IBAction func timeFormatOnClick(_ sender: Any) {
        defaults.set(!defaults.bool(forKey: "isTWH"), forKey: "isTWH")
        timeFormatButton.setTitle(defaults.bool(forKey: "isTWH") ? "12-Hour" : "24-Hour", for: .normal);
    }
    
    @IBAction func colorOnClick(_ sender: Any) {
        defaults.set(!defaults.bool(forKey: "isBlackBg"), forKey: "isBlackBg")
        colorButton.setTitle(defaults.bool(forKey: "isBlackBg") ? "Dark" : "Grey", for: .normal);
    }
}
