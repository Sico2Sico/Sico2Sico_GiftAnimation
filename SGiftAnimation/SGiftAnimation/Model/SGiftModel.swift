//
//  HYGiftModel.swift
//  SGiftAnimation
//
//  Created by 吴德志 on 2017/5/28.
//  Copyright © 2017年 Sico2Sico. All rights reserved.
//

import UIKit

class SGiftModel: NSObject {

    var  senderName :String  = ""
    var  senderURL : String = ""
    var  giftName : String = ""
    var  giftURL :String = ""
    
    init(senderName: String, senderURL : String , giftName:String , giftURL: String){
    
        self.senderName = senderName
        self.senderURL = senderURL
        self.giftName = giftName
        self.giftURL = giftURL
    }
    
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let tmpobject = object as? SGiftModel else { return false }
        guard tmpobject.giftName == giftName && tmpobject.senderName ==  senderName else {return false}

        return true
    }
}
