//
//  SetupViewController.swift
//  Focus
//
//  Created by William Wu on 10/13/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var titleDisplay: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var titleDisplayConstraintX: NSLayoutConstraint!
    @IBOutlet weak var titleDisplayConstraintY: NSLayoutConstraint!
    let defaults = UserDefaults.standard;
    var count = 0;
    let titleList = ["Set Your Preferred Color"];
    let lftBList = ["Black"];
    let rigBList = ["Grey"];
    let argDef = ["isBlackBg"];
    
    override var prefersStatusBarHidden: Bool {
        return true;
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func leftButtonOnClick(_ sender: Any) {
        freezeButton();
        defaults.set(true, forKey: argDef[count]);
        count += 1;
        if(count >= titleList.count)
        {
            nextScreen();
        }
    }
    
    @IBAction func rightButtonOnClick(_ sender: Any) {
        freezeButton();
        defaults.set(false, forKey: argDef[count]);
        count += 1;
        if(count >= titleList.count)
        {
            nextScreen();
        }
    }
    
    func freezeButton()
    {
        leftButton.isEnabled = false;
        rightButton.isEnabled = false;
    }
    
    func resumeButton()
    {
        leftButton.isEnabled = true;
        rightButton.isEnabled = true;
    }
    
    func completeSetup() {
        defaults.set(true, forKey: "launchedBefore");
    }
    
    func swapScreen(title : UILabel,
    newTitle : String,
    leftButton : UIButton,
    lftBConent : String,
    rightButton : UIButton,
    ritBContent : String,
    timeDelta : Double) {
        swapScreen(title: title, newTitle: newTitle, leftButton: leftButton, lftBConent: lftBConent, rightButton: rightButton, ritBContent: ritBContent, timeDelta: timeDelta, titleShiftY: 0, titleConstaint: NSLayoutConstraint.init());
    }
    
    func swapScreen(title : UILabel,
                   newTitle : String,
                   leftButton : UIButton,
                   lftBConent : String,
                   rightButton : UIButton,
                   ritBContent : String,
                   timeDelta : Double,
                   titleShiftY : Int,
                   titleConstaint : NSLayoutConstraint) {
        UIView.animate(withDuration: timeDelta / 2, animations: {
            title.alpha = 0;
            leftButton.alpha = 0;
            rightButton.alpha = 0;
        }, completion: { (finished : Bool) in
            UIView.animate(withDuration: timeDelta / 2, animations: {
                if(titleShiftY != 0)
                {
                    let f = CGFloat(titleShiftY);
                    titleConstaint.constant += f;
                    title.center.y += f;
                }
                title.text = newTitle;
                leftButton.titleLabel?.text = lftBConent;
                rightButton.titleLabel?.text = ritBContent;
                title.alpha = newTitle == "" ? 0 : 1;
                leftButton.alpha = lftBConent == "" ? 0 : 1;
                rightButton.alpha = ritBContent == "" ? 0 : 1;
            })
        })
    }
    
    func nextScreen()
    {
        completeSetup();
        let main = self.storyboard?.instantiateViewController(withIdentifier: "MainSceneViewController") as! MainSceneViewController;
        swapScreen(title: titleDisplay, newTitle: "All Set!", leftButton: leftButton, lftBConent: "", rightButton: rightButton, ritBContent: "", timeDelta: 1.5, titleShiftY: 60, titleConstaint: titleDisplayConstraintY);
        self.present(main, animated: false, completion: nil);
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
