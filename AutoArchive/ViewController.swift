//
//  ViewController.swift
//  AutoArchive
//
//  Created by dfsx1 on 2018/9/7.
//  Copyright © 2018年 dfsx. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class ViewController: UIViewController {

    let synthesizerAV = AVSpeechSynthesizer()
    lazy var utterance: AVSpeechUtterance = {
        //let s = AVSpeechSynthesisVoice.speechVoices()
        let utterance = AVSpeechUtterance(string: self.str())
        utterance.rate = 0.45
        utterance.pitchMultiplier = 2
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.volume = 0.8
        return utterance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let label = UIButton()
        //label.text = "自动打包测试"
        //label.textAlignment = .center
        label.backgroundColor = .red
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(45)
            make.center.equalTo(view)
        }
        label.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func click(_ gf: Any) {
        
        synthesizerAV.speak(self.utterance)
        
    }
    
    
    func str() -> String {
        return """
        
        除了选择系统的语音播报, 当然你还可以选择讯飞的文字转语音技术，不过它受网络的影响比较大，而且离线转语音价格比较贵，最便宜的要8000RMB/2000装机量。
        
        """
    }

}

