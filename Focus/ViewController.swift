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
    @IBOutlet weak var setupButton: UIButton!
    @IBOutlet weak var setupButtonConstraintY: NSLayoutConstraint!
    @IBOutlet var splashScreen: UIView!
    @IBOutlet weak var splashWelcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(UserDefaults.standard.bool(forKey: "launchedBefore"))
        {
            UIView.animate(withDuration: 0.75, animations: {
                self.splashWelcome.alpha = 1;
            })
        }
        else
        {
            UIView.animate(withDuration: 1, delay: 0.5, animations: {
                self.splashTitle.font = self.splashTitle.font.withSize(30);
                self.splashTitle.text = "Welcome to Focus";
                self.splashTitleConstraintY.constant -= 25;
                self.splashTitle.center.y -= 25;
            })
            UIView.animate(withDuration: 0.75, delay: 0.75, animations: {
                self.setupButtonConstraintY.constant += 25;
                self.setupButton.center.y += 25;
                self.setupButton.alpha = 1;
            }, completion: { (finished: Bool) in
                self.setupButton.isEnabled = true;
            })
        }
    }

    @IBAction func setupButtonOnClick(_ sender: UIButton) {
        setupButton.isEnabled = false;
        UIView.animate(withDuration: 0.5, delay: 0.25, animations: {
            self.splashTitle.alpha = 0;
            self.setupButton.alpha = 0;
        }, completion: { (finished: Bool) in
            let setupView = self.storyboard?.instantiateViewController(withIdentifier: "SetupViewController") as! SetupViewController;
            self.present(setupView, animated: true, completion: nil);
        })
    }
    
}
