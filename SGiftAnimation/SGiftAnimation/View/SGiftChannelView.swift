
//
//  SGiftChannelView.swift
//  SGiftAnimation
//
//  Created by 吴德志 on 2017/5/28.
//  Copyright © 2017年 Sico2Sico. All rights reserved.
//

import UIKit
import SnapKit

enum SGiftChannelState{
    case idle
    case animating
    case willEnd
    case endAnimating
}


class SGiftChannelView: UIView {
    
    fileprivate lazy var bgView : UIView  = {
        let  bgView = UIView()
        bgView.backgroundColor = UIColor.green
        return bgView
    }()
    
    fileprivate lazy var iconImageView :UIImageView = {
        
        let iconImageView  = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    
    fileprivate lazy var  senderNameLable:UILabel = {
        let senderNameLabel = UILabel()
        senderNameLabel.font = UIFont.systemFont(ofSize: 12)
        senderNameLabel.textColor = UIColor.white
        senderNameLabel.numberOfLines = 1
        senderNameLabel.sizeToFit()
        return senderNameLabel
    }()
    
    
    fileprivate lazy var giftDescLabel: UILabel = {
        let giftDescLabel = UILabel()
        giftDescLabel.font = UIFont.systemFont(ofSize: 12)
        giftDescLabel.textColor = UIColor.orange
        giftDescLabel.numberOfLines = 1
        giftDescLabel.sizeToFit()
        return giftDescLabel
    }()
    
    
    fileprivate lazy var giftImageView :UIImageView = {
        let  giftImageView = UIImageView()
        giftImageView.contentMode = .scaleAspectFit
        return giftImageView
    }()
    
    fileprivate lazy var digitLabel : SGiftDigitLabel = {
        let  digitLabel = SGiftDigitLabel()
        return  digitLabel
    }()
    
    fileprivate var  cacheNumber :Int = 0
    fileprivate var  currentNumber : Int = 0
    
    var  state : SGiftChannelState = .idle
    var  complectionCallback : ((SGiftChannelView)->())?
    
    var  giftModel : SGiftModel? {
        
        didSet{
            //1 对模型进行比较
            guard  let tmpmdoel = giftModel else {return}
            //给控件设置信息
            iconImageView.image = UIImage(named: tmpmdoel.senderURL)
            senderNameLable.text = tmpmdoel.senderName
            giftDescLabel.text = "送出礼物: 【\(tmpmdoel.giftName)】"
            giftImageView.image = UIImage(named: tmpmdoel.giftURL)
            //将唱SGiftChannelView弹出
            state = .animating
            // 执行动画
            performAnimation()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SGiftChannelView {

    fileprivate func setUpUI(){
        addSubview(bgView)
        addSubview(iconImageView)
        addSubview(senderNameLable)
        addSubview(giftDescLabel)
        addSubview(giftImageView)
        addSubview(digitLabel)
        setAutoLayout()
    }
    
    fileprivate func setAutoLayout(){
        
       
        iconImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.height.equalTo(self.iconImageView.snp.width)

        }
       
        
        senderNameLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageView.snp.right)
            make.top.equalToSuperview()
            make.bottom.equalTo(self.giftDescLabel.snp.top).offset(-2)
            make.height.equalTo(self.giftDescLabel.snp.height)
        }
        
        giftDescLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.senderNameLable.snp.bottom).offset(2)
            make.left.equalTo(self.senderNameLable.snp.left)
            make.bottom.equalTo(self.iconImageView.snp.bottom)
            make.height.equalTo(self.senderNameLable.snp.height)
        }
        
        giftImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(self.giftDescLabel.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalTo(self.giftImageView.snp.height)
        }
        
        
        bgView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(self.giftImageView.snp.right)
        }

        digitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.giftImageView.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.right.lessThanOrEqualToSuperview()
        }
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let  Radius :CGFloat = frame.height * 0.5

        bgView.layer.cornerRadius = Radius
        bgView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = Radius
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
        iconImageView.layer.masksToBounds = true
    
    }
}


// MARK:- 对外方法
extension SGiftChannelView {
    func addOnecToCache(){
        if  state == .willEnd {
            performDigAnimation()
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        }else {
            cacheNumber += 1
        }
    }
    
}



extension SGiftChannelView{
    
    fileprivate func performAnimation(){
    
        digitLabel.alpha = 1.0
        digitLabel.text = " X1 "
        UIView.animate(withDuration: 0.25, animations: { 
            self.alpha = 1.0
            self.frame.origin.x = 0
        }, completion: { isFinished in
            self.performDigAnimation()
        })
    }
    fileprivate func performDigAnimation(){
         currentNumber += 1
        digitLabel.text = " x\(currentNumber)"
        digitLabel.showDigitAnimation {
            
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performDigAnimation()
            }else {
                self.state = .willEnd
                self.perform(#selector(self.performEndAniamtion), with: nil, afterDelay: 3.0)
            }
        }
        
    }
    
    @objc fileprivate func performEndAniamtion(){
        state = .endAnimating
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 1.0
        }, completion: { isFinished in
            self.currentNumber = 0
            self.cacheNumber = 1
            self.giftModel = nil
            self.frame.origin.x = -UIScreen.main.bounds.width
            self.state = .idle
            self.digitLabel.alpha = 0.0
            
            if let  complectionCallback = self.complectionCallback{
                complectionCallback(self)
            }
        })
        
    }
}












