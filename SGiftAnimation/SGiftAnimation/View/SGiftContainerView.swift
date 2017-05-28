//
//  SGiftContainerView.swift
//  SGiftAnimation
//
//  Created by 吴德志 on 2017/5/28.
//  Copyright © 2017年  . All rights reserved.
//

import UIKit
import SnapKit




class SGiftContainerView: UIView {
    //MARK:- 定义属性
    fileprivate lazy var  channelViews: [SGiftChannelView] = [SGiftChannelView]()
    fileprivate lazy var  cacheGiftModels : [SGiftModel] = [SGiftModel]()
    var kChannelCount: Int = 2
    var kChannelViewH: CGFloat = 40
    var KChannelMargin: CGFloat = 10
    override init(frame: CGRect) {
        super.init(frame: frame)
        kChannelCount = 2
        kChannelViewH = 40
        KChannelMargin = 10
        setUpUI()
    }
    
    //MARK:- 构造函数
    init(frame: CGRect, giftChannelCount:Int = 2, giftChannelViewH:CGFloat = 40, giftChannelMargin:CGFloat = 10){
        super.init(frame: frame)
        kChannelCount = giftChannelCount
        kChannelViewH = giftChannelViewH
        KChannelMargin = giftChannelMargin
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension SGiftContainerView {
    fileprivate func setUpUI(){
        let h :CGFloat = kChannelViewH
        
        for i  in 0..<kChannelCount {

            let y : CGFloat = (h + KChannelMargin) * CGFloat(i)
            
            let  channelView = SGiftChannelView()
            channelView.alpha = 0.0
            addSubview(channelView)
            channelViews.append(channelView)
            
            channelView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.snp.top).offset(y)
                make.left.width.equalToSuperview()
                make.height.equalTo(h)
            })
            
            channelView.complectionCallback = { channelview in
                //1  取出换成模型
                guard  self.cacheGiftModels.count != 0 else   {return}
                // 2 取出缓存的第一个模型
                let  firstGiftModel = self.cacheGiftModels.first!
                self.cacheGiftModels.removeFirst()
                //让闲置的View 执行动画  
                channelView.giftModel = firstGiftModel
                //将数组中剩余的和firGiftModel相同额模型放入到chanelView缓存中
                //reversed倒序  很聪明哦
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstGiftModel){
                        channelView.addOnecToCache()
                        self.cacheGiftModels.remove(at: i)
                    }
                }
            
            }
        }
    }
    
}


extension SGiftContainerView {

    func showGiftModel(_ giftModel: SGiftModel ){
        //1 判断正在忙的Chanelview 和 赠送的新礼物
        if let channelView = checkUsingChanelView(giftModel) {
            channelView.addOnecToCache()
            return
        }

        if let channelView = checkIdleChannelView(){
            channelView.giftModel = giftModel
            return
        }
        
    }
    
    private func checkUsingChanelView(_ giftModel:SGiftModel)->SGiftChannelView?{
        for chanelView  in channelViews{
            if giftModel.isEqual(chanelView.giftModel) && chanelView.state != .endAnimating{
                return chanelView
            }
        }
        return nil
    }
    
    
    private func checkIdleChannelView()-> SGiftChannelView? {
        for channelView  in channelViews {
            if channelView.state == .idle {
                return channelView
            }
        }
        return nil
    }
}



