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

    var player: AVAudioPlayer?
    
    var recorder: AVAudioRecorder?
    
    var link: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    
        
    }
    

    @IBAction func start() {
        recorder?.prepareToRecord()
        print(recorder?.record())
        
        
        updataMetering()
        
    }
    @IBAction func pause() {
        recorder?.pause()
        link?.isPaused = true
    }
    @IBAction func stop() {
        recorder?.stop()
        link?.isPaused = true
        
        number = 0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func labThree() {
        
        guard var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last else {
            return
        }
        
        path = path.appending("/recorder.wav")
        
        let url = URL(string: path)
        
        recorder = try? AVAudioRecorder(url: url!, settings: [String : Any]())
        
        //6. 打开分贝的检测
        
        recorder?.isMeteringEnabled = true

        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(AVAudioSessionCategoryRecord)
    }
    
    func updataMetering() {
        if link == nil {
            link = CADisplayLink(target: self, selector: #selector(updataMeter))
            link?.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        }
        if (link?.isPaused)! {
            link?.isPaused = false
        }
    }
     var number: Int = 0
    
    func updataMeter() {
        //需求: 自动停止录音 --> 根据分贝的大小来判断
        
        //1. 我们需要获取分贝信息
        //2. 设置分贝如果小于某个值, 一定时间后, 自动停止
        
        //1. 更新分贝信息
        recorder?.updateMeters()
        
        //2. 获取分贝信息 --> iOS直接传0
        // 0 ~ -160 , 值最大是0, 最小是-160. 系统返回的是负值
        let power = recorder?.averagePower(forChannel: 0) ?? 0
        
        //3. 实现2S自动停止
        

        //displayLink,一秒默认是60次, 如果120此的调用都小于某个分贝值, 我们就可以认为要自动停止
        
        //3.1 先判断用户是否小于某个分贝值 --> 用户是否没说话
        if (power < Float(-30)) {
            number += 1
            
            if (number/60 >= 2) {
                stop()
            }
            
        } else {
            number = 0
        }
        
        print(power)
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


