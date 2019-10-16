//
//  Utilities.swift
//  Focus
//
//  Created by William Wu on 10/15/19.
//  Copyright © 2019 Project Pinnacles. All rights reserved.
//

import Foundation

class Utilities {
    static func generatePasswd() -> String {
        var rtn = "";
        
        for _ in 1...6
        {
            rtn += String(Int.random(in: 0..<10));
        }
        
        return rtn;
    }
    
    public var totalSec = 0;
    
    public var sessionSec = 0;
    
    public var isTimer = false;
    
    func writeToConfig()
    {
        let defaults = UserDefaults.standard;
        let curr = defaults.integer(forKey: "focusedSec") + totalSec;
        defaults.set(curr, forKey: "focusedSec");
        sessionSec += totalSec;
        totalSec = 0;
    }
}
