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
        if(UserDefaults.standard.bool(forKey: "launchedBefore"))
        {
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "launchedTimes") + 1, forKey: "launchedTimes");
            let main = self.storyboard?.instantiateViewController(withIdentifier: "MainSceneViewController") as! MainSceneViewController;
            UIView.animate(withDuration: 0.75, animations: {
                self.splashWelcome.alpha = 1;
            }, completion: { (finished : Bool) in
                UIView.animate(withDuration: 0.75, delay: 0.25, animations: {
                    self.splashWelcome.alpha = 0;
                    self.splashTitle.alpha = 0;
                }, completion : { (finish : Bool) in
                    self.present(main, animated: false, completion: nil);
                })
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
        UIView.animate(withDuration: 0.75, delay: 0.25, animations: {
            self.splashTitle.alpha = 0;
            self.setupButton.alpha = 0;
        }, completion: { (finished: Bool) in
            let setupView = self.storyboard?.instantiateViewController(withIdentifier: "SetupViewController") as! SetupViewController;
            self.present(setupView, animated: false, completion: nil);
        })
    }
    
}
