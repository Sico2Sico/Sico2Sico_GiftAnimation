//
//  ViewController.swift
//  SGiftAnimation
//
//  Created by 吴德志 on 2017/5/27.
//  Copyright © 2017年 Sico2Sico. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var giftContainerView : SGiftContainerView = SGiftContainerView(frame:CGRect.zero, giftChannelCount: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(giftContainerView)
        
        
        giftContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(100)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.height.equalTo(160)
            make.width.equalTo(250)
        }
    }
    
    @IBAction func gitft1() {
        
        let gift1 = SGiftModel(senderName: "coderwhy", senderURL: "icon4", giftName: "dwadwadwadwa火箭", giftURL: "prop_b")
        giftContainerView.showGiftModel(gift1)
    }
    
    @IBAction func gift2() {
        let gift2 = SGiftModel(senderName: "coder", senderURL: "icon2", giftName: "飞机", giftURL: "prop_f")
        giftContainerView.showGiftModel(gift2)

    }
    
    @IBAction func gift3() {
        let gift3 = SGiftModel(senderName: "why", senderURL: "icon3", giftName: "跑车", giftURL: "prop_g")
        giftContainerView.showGiftModel(gift3)
    }
    //prop_h
    
    @IBAction func gift4() {
        let gift4 = SGiftModel(senderName: "hobao", senderURL: "icon1", giftName: "红包", giftURL: "prop_h")
        giftContainerView.showGiftModel(gift4)
    }

}

