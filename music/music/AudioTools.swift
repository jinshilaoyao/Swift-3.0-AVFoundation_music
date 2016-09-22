//
//  AudioTools.swift
//  music
//
//  Created by yesway on 16/9/22.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import AVFoundation

class AudioTools: NSObject {
    
    var soundIDDict: [String: UInt32] = ["": 0]
    
    
    class func playSystemSOundWith(url: URL) {
        AudioServicesPlaySystemSound(AudioTools().loadSoundIDWith(url: url))
    }
    
    class func playAlertSoundWith(url: URL) {
        AudioServicesPlayAlertSound(AudioTools().loadSoundIDWith(url: url))
    }
    
    fileprivate func loadSoundIDWith(url: URL) -> SystemSoundID {
        
        let urlString = url.absoluteString
        
        var soundID = soundIDDict[urlString] ?? 0
        
        if soundID == 0 {
            AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
            soundIDDict[urlString] = soundID
        }
        
        return soundID
    }
    
    
    class func clearMemory() {
        
    }
    
    

}
