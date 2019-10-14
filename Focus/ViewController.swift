//
//  ViewController.swift
//  Focus
//
//  Created by William Wu on 10/13/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var splashTitle: UILabel!
    @IBOutlet weak var splashTitleConstraintY: NSLayoutConstraint!
    @IBOutlet weak var splashFirstTimeButton: UIButton!
    @IBOutlet weak var splashFirstTimeButtonConstraintY: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(UserDefaults.standard.bool(forKey: "launchedBefore"))
        {
            splashTitle.text = "EEE";
        }
        else
        {
            UIView.animate(withDuration: 1, delay: 0.5, animations: {
                self.splashTitle.font = self.splashTitle.font.withSize(30);
                self.splashTitle.text = "Welcome to Focus";
                self.splashTitleConstraintY.constant -= 50;
                self.splashTitle.center.y -= 50;
            })
            UIView.animate(withDuration: 0.75, delay: 0.75, animations: {
                self.splashFirstTimeButtonConstraintY.constant += 50;
                self.splashFirstTimeButton.center.y += 50;
                self.splashFirstTimeButton.alpha = 1;
            }, completion: { (finished: Bool) in
                self.splashFirstTimeButton.isEnabled = true;
            })
        }
    }
    
    


}

