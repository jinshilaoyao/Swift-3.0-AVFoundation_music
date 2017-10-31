//
//  ViewController.swift
//  music
//
//  Created by yesway on 16/9/22.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    let name: String = "laoin"
    var player: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    func labTwo() {
        let url = Bundle.main.url(forResource: "我的滑板鞋.mp3", withExtension: nil)
        
        player = try? AVAudioPlayer(contentsOf: url!)
        
        player?.prepareToPlay()
        
        player?.play()
        player?.delegate = self
        
//        player?.pause()
        
//        player?.stop()
    }
    
    func labOne() {
        
//        最简单播放
        
        let url = Bundle.main.url(forResource: "m_03.wav", withExtension: nil)
        
        AudioTools.playSystemSOundWith(url: url!)
        
        AudioTools.playAlertSoundWith(url: url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController {
    
}


