//
//  ViewController.swift
//  AutoArchive
//
//  Created by dfsx1 on 2018/9/7.
//  Copyright © 2018年 dfsx. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let label = UILabel()
        label.text = "自动打包测试"
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(45)
            make.center.equalTo(view)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

