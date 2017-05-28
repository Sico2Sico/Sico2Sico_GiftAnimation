//
//  SGiftDigitLabel.swift
//  SGiftAnimation
//
//  Created by 吴德志 on 2017/5/27.
//  Copyright © 2017年 Sico2Sico. All rights reserved.
//

import UIKit

class SGiftDigitLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        //1 获取上下文
        let context = UIGraphicsGetCurrentContext()
        //2 给上下文线段设置一个宽度 通过该宽度画出文本
        context?.setLineWidth(5)
        context?.setLineJoin(.round)
        context?.setTextDrawingMode(.stroke)
        textColor = UIColor.orange
        super.drawText(in: rect)
        
        context?.setTextDrawingMode(.fill)
        textColor = UIColor.white
        super.drawText(in: rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SGiftDigitLabel {

    func showDigitAnimation(_ completion : @escaping ()->()){
        
         UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
           
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform  = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            
         }, completion:{ isFinished in
            
          UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: { 
            self.transform = CGAffineTransform.identity
          }, completion: { (isFinished) in
            completion()
          })
        })
    }
}
